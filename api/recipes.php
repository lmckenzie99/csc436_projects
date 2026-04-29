<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') json_err('GET only', 405);

$user_id = sanitize_int($_GET['user_id'] ?? 0);
if (!$user_id) json_err('user_id required');

// Returns only recipes belonging to this user.
// Requires ALTER TABLE Recipes ADD COLUMN user_id INT NULL AFTER recipe_id;
// Existing recipes without a user_id will be excluded — run the migration below first.
$rows = pdo($pdo, '
    SELECT recipe_id, recipe_name, instructions, image_url,
           source_api, serving_size, cache_priority AS type
    FROM Recipes
    WHERE user_id = ?
    ORDER BY recipe_name
', [$user_id])->fetchAll();

json_out($rows);
