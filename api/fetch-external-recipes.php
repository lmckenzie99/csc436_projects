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

$added   = 0;
$errors  = [];

// ── Spoonacular ───────────────────────────────────────────────────────────────
if ($source === 'spoonacular' || $source === 'both') {
    $query = urlencode($type);
    $url   = "https://api.spoonacular.com/recipes/complexSearch"
           . "?query={$query}&number=5&addRecipeInformation=true&apiKey={$SPOONACULAR_KEY}";

    $raw = @file_get_contents($url);
    if ($raw === false) {
        $errors[] = 'Spoonacular request failed';
    } else {
        $data = json_decode($raw, true);
        foreach (($data['results'] ?? []) as $r) {
            $name         = sanitize_str($r['title']                    ?? 'Untitled', 255);
            $instructions = sanitize_str(strip_tags($r['summary']       ?? ''), 2000);
            $image_url    = sanitize_str($r['image']                    ?? '', 500);
            $source_api   = 'Spoonacular';

            // skip if this user already has a recipe with the same name
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
                $added++;
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
            $r            = $hit['recipe'] ?? [];
            $name         = sanitize_str($r['label']              ?? 'Untitled', 255);
            $instructions = sanitize_str($r['url']                ?? '', 500); // Edamam links to source
            $image_url    = sanitize_str($r['image']              ?? '', 500);
            $source_api   = 'Edamam';

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
