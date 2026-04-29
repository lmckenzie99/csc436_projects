<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') json_err('POST only', 405);

$body         = get_body();
$user_id      = sanitize_int($body['user_id']       ?? 0);
$recipe_name  = sanitize_str($body['recipe_name']   ?? '', 255);
$type         = sanitize_str($body['type']          ?? 'Other', 50);
$instructions = sanitize_str($body['instructions']  ?? '', 5000);
$serving_size = isset($body['serving_size']) ? (int)$body['serving_size'] : null;
$ingredients  = trim($body['ingredients'] ?? '');

if (!$user_id)      json_err('user_id required');
if (!$recipe_name)  json_err('Recipe name required');
if (!$instructions) json_err('Instructions required');

pdo($pdo, '
    INSERT INTO Recipes (user_id, recipe_name, instructions, source_api, cache_priority, serving_size, last_fetched)
    VALUES (?, ?, ?, ?, ?, ?, NOW())
', [$user_id, $recipe_name, $instructions, 'User', $type, $serving_size]);

$recipe_id = (int)$pdo->lastInsertId();

// Parse ingredients — each line: "2 cups flour" or just "flour"
if ($ingredients) {
    foreach (explode("\n", $ingredients) as $line) {
        $line = trim($line);
        if (!$line) continue;

        // Try to parse "quantity unit name" e.g. "2 cups flour"
        if (preg_match('/^([\d.\/]+)\s+(\S+)\s+(.+)$/', $line, $m)) {
            $qty      = (float)$m[1];
            $unit     = sanitize_str($m[2], 50);
            $ing_name = sanitize_str($m[3], 100);
        } elseif (preg_match('/^([\d.\/]+)\s+(.+)$/', $line, $m)) {
            $qty      = (float)$m[1];
            $unit     = 'count';
            $ing_name = sanitize_str($m[2], 100);
        } else {
            $qty      = 1;
            $unit     = 'count';
            $ing_name = sanitize_str($line, 100);
        }

        if (!$ing_name) continue;

        $existing = pdo($pdo, 'SELECT ingredient_id FROM Ingredients WHERE LOWER(ingredient_name) = LOWER(?) LIMIT 1', [$ing_name])->fetch();
        if ($existing) {
            $ing_id = (int)$existing['ingredient_id'];
        } else {
            pdo($pdo, 'INSERT INTO Ingredients (ingredient_name, default_unit) VALUES (?, ?)', [$ing_name, $unit]);
            $ing_id = (int)$pdo->lastInsertId();
        }

        pdo($pdo, 'INSERT IGNORE INTO Recipe_Ingredients (recipe_id, ingredient_id, quantity, unit) VALUES (?, ?, ?, ?)',
            [$recipe_id, $ing_id, $qty, $unit]);
    }
}

json_out(['success' => true, 'recipe_id' => $recipe_id]);
