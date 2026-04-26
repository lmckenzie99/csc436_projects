<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') json_err('GET only', 405);

$user_id = (int)($_GET['user_id'] ?? 0);
if (!$user_id) json_err('user_id required');

$rows = pdo($pdo, '
    SELECT gl.list_id, gl.ingredient_id, gl.quantity, gl.unit,
           gl.is_purchased, i.ingredient_name
    FROM Grocery_List gl
    JOIN Ingredients i ON i.ingredient_id = gl.ingredient_id
    WHERE gl.user_id = ?
    ORDER BY gl.is_purchased ASC, i.ingredient_name ASC
', [$user_id])->fetchAll();

json_out($rows);
