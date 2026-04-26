<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') json_err('GET only', 405);

$user_id = (int)($_GET['user_id'] ?? 0);
if (!$user_id) json_err('user_id required');

$rows = pdo($pdo, '
    SELECT iv.inventory_id, iv.ingredient_id, iv.quantity, iv.unit,
           iv.expiration_date, iv.date_opened, i.ingredient_name
    FROM Inventory iv
    JOIN Ingredients i ON i.ingredient_id = iv.ingredient_id
    WHERE iv.user_id = ?
    ORDER BY iv.expiration_date ASC
', [$user_id])->fetchAll();

json_out($rows);
