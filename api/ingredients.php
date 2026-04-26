<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') json_err('GET only', 405);

$rows = pdo($pdo, 'SELECT ingredient_id, ingredient_name, default_unit FROM Ingredients ORDER BY ingredient_name')->fetchAll();

json_out($rows);
