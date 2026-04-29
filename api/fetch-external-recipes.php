<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') json_err('POST only', 405);

$body    = get_body();
$type    = sanitize_str($body['type']    ?? 'Other', 50);
$user_id = sanitize_int($body['user_id'] ?? 0);
$source  = sanitize_str($body['source']  ?? 'spoonacular', 20);

if (!$user_id) json_err('user_id required');

$SPOONACULAR_KEY = '47b54a602d8f472c91769bbb6942eff1';
$EDAMAM_APP_ID   = 'fd3230a5';
$EDAMAM_APP_KEY  = 'e3d784dd42a820d3e6086779f1019667';

$added  = 0;
$errors = [];

// ── Spoonacular ───────────────────────────────────────────────────────────────
if ($source === 'spoonacular' || $source === 'both') {
    $query = urlencode($type);
    // Step 1: search
    $search_url = "https://api.spoonacular.com/recipes/complexSearch"
                . "?query={$query}&number=5&apiKey={$SPOONACULAR_KEY}";
    $raw = @file_get_contents($search_url);
    if ($raw === false) {
        $errors[] = 'Spoonacular search failed';
    } else {
        $search = json_decode($raw, true);
        $ids    = array_column($search['results'] ?? [], 'id');

        if (!empty($ids)) {
            // Step 2: bulk detail fetch (instructions + ingredients in one call)
            $ids_str    = implode(',', $ids);
            $detail_url = "https://api.spoonacular.com/recipes/informationBulk"
                        . "?ids={$ids_str}&includeNutrition=false&apiKey={$SPOONACULAR_KEY}";
            $raw2 = @file_get_contents($detail_url);
            if ($raw2 === false) {
                $errors[] = 'Spoonacular detail fetch failed';
            } else {
                $recipes = json_decode($raw2, true);
                foreach ($recipes as $r) {
                    $name         = sanitize_str($r['title'] ?? 'Untitled', 255);
                    // Use analyzedInstructions for clean step-by-step text
                    $steps = [];
                    foreach (($r['analyzedInstructions'][0]['steps'] ?? []) as $step) {
                        $steps[] = $step['number'] . '. ' . $step['step'];
                    }
                    $instructions = !empty($steps)
                        ? sanitize_str(implode("\n", $steps), 5000)
                        : sanitize_str(strip_tags($r['instructions'] ?? 'No instructions available.'), 5000);
                    $image_url  = sanitize_str($r['image'] ?? '', 500);
                    $source_api = 'Spoonacular';

                    $exists = pdo($pdo, '
                        SELECT recipe_id FROM Recipes
                        WHERE LOWER(recipe_name) = LOWER(?) AND user_id = ? LIMIT 1
                    ', [$name, $user_id])->fetch();

                    if (!$exists) {
                        pdo($pdo, '
                            INSERT INTO Recipes
                                (user_id, recipe_name, instructions, image_url, source_api, cache_priority, last_fetched)
                            VALUES (?, ?, ?, ?, ?, ?, NOW())
                        ', [$user_id, $name, $instructions, $image_url, $source_api, $type]);
                        $recipe_id = (int)$pdo->lastInsertId();

                        // Store ingredients in Recipe_Ingredients
                        foreach (($r['extendedIngredients'] ?? []) as $ing) {
                            $ing_name = sanitize_str($ing['name'] ?? '', 100);
                            $qty      = (float)($ing['amount'] ?? 0);
                            $unit     = sanitize_str($ing['unit'] ?? 'count', 50);
                            if (!$ing_name) continue;

                            // Find or create ingredient
                            $existing_ing = pdo($pdo, '
                                SELECT ingredient_id FROM Ingredients
                                WHERE LOWER(ingredient_name) = LOWER(?) LIMIT 1
                            ', [$ing_name])->fetch();

                            if ($existing_ing) {
                                $ing_id = (int)$existing_ing['ingredient_id'];
                            } else {
                                pdo($pdo, 'INSERT INTO Ingredients (ingredient_name, default_unit) VALUES (?, ?)', [$ing_name, $unit]);
                                $ing_id = (int)$pdo->lastInsertId();
                            }

                            pdo($pdo, '
                                INSERT IGNORE INTO Recipe_Ingredients (recipe_id, ingredient_id, quantity, unit)
                                VALUES (?, ?, ?, ?)
                            ', [$recipe_id, $ing_id, $qty, $unit]);
                        }
                        $added++;
                    }
                }
            }
        }
    }
}

// ── Edamam ────────────────────────────────────────────────────────────────────
if (($source === 'edamam' || $source === 'both') && $EDAMAM_APP_ID && $EDAMAM_APP_KEY) {
    $query = urlencode($type);
    $url   = "https://api.edamam.com/api/recipes/v2"
           . "?type=public&q={$query}&app_id={$EDAMAM_APP_ID}&app_key={$EDAMAM_APP_KEY}&from=0&to=5";

    $ctx = stream_context_create(['http' => ['header' => "Accept: application/json\r\n"]]);
    $raw = @file_get_contents($url, false, $ctx);
    if ($raw === false) {
        $errors[] = 'Edamam request failed';
    } else {
        $data = json_decode($raw, true);
        foreach (($data['hits'] ?? []) as $hit) {
            $r          = $hit['recipe'] ?? [];
            $name       = sanitize_str($r['label'] ?? 'Untitled', 255);
            $instructions = sanitize_str('See full recipe at: ' . ($r['url'] ?? ''), 500);
            $image_url  = sanitize_str($r['image'] ?? '', 500);
            $source_api = 'Edamam';

            $exists = pdo($pdo, '
                SELECT recipe_id FROM Recipes
                WHERE LOWER(recipe_name) = LOWER(?) AND user_id = ? LIMIT 1
            ', [$name, $user_id])->fetch();

            if (!$exists) {
                pdo($pdo, '
                    INSERT INTO Recipes
                        (user_id, recipe_name, instructions, image_url, source_api, cache_priority, last_fetched)
                    VALUES (?, ?, ?, ?, ?, ?, NOW())
                ', [$user_id, $name, $instructions, $image_url, $source_api, $type]);
                $recipe_id = (int)$pdo->lastInsertId();

                foreach (($r['ingredients'] ?? []) as $ing) {
                    $ing_name = sanitize_str($ing['food'] ?? '', 100);
                    $qty      = (float)($ing['quantity'] ?? 0);
                    $unit     = sanitize_str($ing['measure'] ?? 'count', 50);
                    if (!$ing_name) continue;

                    $existing_ing = pdo($pdo, '
                        SELECT ingredient_id FROM Ingredients
                        WHERE LOWER(ingredient_name) = LOWER(?) LIMIT 1
                    ', [$ing_name])->fetch();

                    if ($existing_ing) {
                        $ing_id = (int)$existing_ing['ingredient_id'];
                    } else {
                        pdo($pdo, 'INSERT INTO Ingredients (ingredient_name, default_unit) VALUES (?, ?)', [$ing_name, $unit]);
                        $ing_id = (int)$pdo->lastInsertId();
                    }

                    pdo($pdo, '
                        INSERT IGNORE INTO Recipe_Ingredients (recipe_id, ingredient_id, quantity, unit)
                        VALUES (?, ?, ?, ?)
                    ', [$recipe_id, $ing_id, $qty, $unit]);
                }
                $added++;
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
