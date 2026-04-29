<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

// ── GET: list recipes for user ────────────────────────────────
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $user_id = sanitize_int($_GET['user_id'] ?? 0);
    if (!$user_id) json_err('user_id required');

    $rows = pdo($pdo, '
        SELECT recipe_id, recipe_name, instructions, image_url,
               source_api, serving_size, cache_priority AS type
        FROM Recipes
        WHERE user_id = ?
        ORDER BY recipe_name
    ', [$user_id])->fetchAll();
    json_out($rows);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $body   = get_body();
    $action = sanitize_str($body['action'] ?? 'add', 20);

    // ── POST add ─────────────────────────────────────────────
    if ($action === 'add') {
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

        if ($ingredients) {
            foreach (explode("\n", $ingredients) as $line) {
                $line = trim($line);
                if (!$line) continue;
                if (preg_match('/^([\d.\/]+)\s+(\S+)\s+(.+)$/', $line, $m)) {
                    $qty = (float)$m[1]; $unit = sanitize_str($m[2], 50); $ing_name = sanitize_str($m[3], 100);
                } elseif (preg_match('/^([\d.\/]+)\s+(.+)$/', $line, $m)) {
                    $qty = (float)$m[1]; $unit = 'count'; $ing_name = sanitize_str($m[2], 100);
                } else {
                    $qty = 1; $unit = 'count'; $ing_name = sanitize_str($line, 100);
                }
                if (!$ing_name) continue;
                $ex = pdo($pdo, 'SELECT ingredient_id FROM Ingredients WHERE LOWER(ingredient_name) = LOWER(?) LIMIT 1', [$ing_name])->fetch();
                if ($ex) { $ing_id = (int)$ex['ingredient_id']; }
                else { pdo($pdo, 'INSERT INTO Ingredients (ingredient_name, default_unit) VALUES (?, ?)', [$ing_name, $unit]); $ing_id = (int)$pdo->lastInsertId(); }
                pdo($pdo, 'INSERT IGNORE INTO Recipe_Ingredients (recipe_id, ingredient_id, quantity, unit) VALUES (?, ?, ?, ?)', [$recipe_id, $ing_id, $qty, $unit]);
            }
        }
        json_out(['success' => true, 'recipe_id' => $recipe_id]);
    }

    // ── POST delete ───────────────────────────────────────────
    if ($action === 'delete') {
        $recipe_id = sanitize_int($body['recipe_id'] ?? 0);
        $user_id   = sanitize_int($body['user_id']   ?? 0);
        if (!$recipe_id || !$user_id) json_err('recipe_id and user_id required');

        $recipe = pdo($pdo, 'SELECT recipe_id FROM Recipes WHERE recipe_id = ? AND user_id = ? LIMIT 1', [$recipe_id, $user_id])->fetch();
        if (!$recipe) json_err('Recipe not found or not yours', 403);

        pdo($pdo, 'DELETE FROM Recipe_Ingredients WHERE recipe_id = ?', [$recipe_id]);
        pdo($pdo, 'DELETE FROM Recipe_Tags WHERE recipe_id = ?', [$recipe_id]);
        pdo($pdo, 'DELETE FROM Favorites WHERE recipe_id = ?', [$recipe_id]);
        pdo($pdo, 'DELETE FROM Recipes WHERE recipe_id = ? AND user_id = ?', [$recipe_id, $user_id]);
        json_out(['success' => true]);
    }

    json_err('Unknown action');
}

json_err('Method not allowed', 405);
