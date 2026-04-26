<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') json_err('GET only', 405);

$rows = pdo($pdo, '
    SELECT nv.nutrition_id, nv.recipe_id, r.recipe_name,
           r.cache_priority AS type,
           nv.calories, nv.protein AS protein_g,
           nv.carbs AS carbs_g, nv.fat AS fat_g, nv.sugar AS sugar_g
    FROM Nutritional_Values nv
    JOIN Recipes r ON r.recipe_id = nv.recipe_id
    WHERE nv.entity_type = "recipe"
    ORDER BY r.recipe_name
')->fetchAll();

json_out($rows);
