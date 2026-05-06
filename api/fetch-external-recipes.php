<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') json_err('POST only', 405);

$body    = get_body();
$type    = sanitize_str($body['type']    ?? 'Other', 50);
$user_id = sanitize_int($body['user_id'] ?? 0);

if (!$user_id) json_err('user_id required');

$SPOONACULAR_KEY = '47b54a602d8f472c91769bbb6942eff1';
$added  = 0;
$errors = [];

$query      = urlencode($type);
$search_url = "https://api.spoonacular.com/recipes/complexSearch"
            . "?query={$query}&number=5&apiKey={$SPOONACULAR_KEY}";
$raw = @file_get_contents($search_url);

if ($raw === false) {
    $errors[] = 'Spoonacular search failed';
} else {
    $search = json_decode($raw, true);
    $ids    = array_column($search['results'] ?? [], 'id');

    if (!empty($ids)) {
        $ids_str    = implode(',', $ids);
        $detail_url = "https://api.spoonacular.com/recipes/informationBulk"
                    . "?ids={$ids_str}&includeNutrition=false&apiKey={$SPOONACULAR_KEY}";
        $raw2 = @file_get_contents($detail_url);

        if ($raw2 === false) {
            $errors[] = 'Spoonacular detail fetch failed';
        } else {
            $recipes = json_decode($raw2, true);
            foreach ($recipes as $r) {
                $name  = sanitize_str($r['title'] ?? 'Untitled', 255);
                $steps = [];
                foreach (($r['analyzedInstructions'][0]['steps'] ?? []) as $step) {
                    $steps[] = $step['number'] . '. ' . $step['step'];
                }
                $instructions = !empty($steps)
                    ? sanitize_str(implode("\n", $steps), 5000)
                    : sanitize_str(strip_tags($r['instructions'] ?? 'No instructions available.'), 5000);
                $image_url = sanitize_str($r['image'] ?? '', 500);

                $exists = pdo($pdo, '
                    SELECT recipe_id FROM Recipes
                    WHERE LOWER(recipe_name) = LOWER(?) AND user_id = ? LIMIT 1
                ', [$name, $user_id])->fetch();

                if (!$exists) {
                    pdo($pdo, '
                        INSERT INTO Recipes
                            (user_id, recipe_name, instructions, image_url, source_api, cache_priority, last_fetched)
                        VALUES (?, ?, ?, ?, ?, ?, NOW())
                    ', [$user_id, $name, $instructions, $image_url, 'Spoonacular', $type]);
                    $recipe_id = (int)$pdo->lastInsertId();

                    foreach (($r['extendedIngredients'] ?? []) as $ing) {
                        $ing_name = sanitize_str($ing['name'] ?? '', 100);
                        $qty      = (float)($ing['amount'] ?? 0);
                        $unit     = sanitize_str($ing['unit'] ?? 'count', 50);
                        if (!$ing_name) continue;

                        $ex = pdo($pdo, 'SELECT ingredient_id FROM Ingredients WHERE LOWER(ingredient_name) = LOWER(?) LIMIT 1', [$ing_name])->fetch();
                        if ($ex) { $ing_id = (int)$ex['ingredient_id']; }
                        else { pdo($pdo, 'INSERT INTO Ingredients (ingredient_name, default_unit) VALUES (?, ?)', [$ing_name, $unit]); $ing_id = (int)$pdo->lastInsertId(); }

                        pdo($pdo, 'INSERT IGNORE INTO Recipe_Ingredients (recipe_id, ingredient_id, quantity, unit) VALUES (?, ?, ?, ?)',
                            [$recipe_id, $ing_id, $qty, $unit]);
                    }
                    $added++;
                }
            }
        }
    }
}

json_out([
    'success' => $added > 0 || empty($errors),
    'added'   => $added,
    'type'    => $type,
    'errors'  => $errors
]);
