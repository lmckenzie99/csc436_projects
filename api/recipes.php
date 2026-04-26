<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') json_err('GET only', 405);

$rows = pdo($pdo, '
    SELECT r.recipe_id, r.recipe_name, r.instructions, r.image_url,
           r.source_api, r.serving_size, r.cache_priority AS type
    FROM Recipes r
    ORDER BY r.recipe_name
')->fetchAll();

json_out($rows);
