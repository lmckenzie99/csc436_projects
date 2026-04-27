<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') json_err('POST only', 405);

$body         = get_body();
$inventory_id = sanitize_int($body['inventory_id'] ?? 0);

if (!$inventory_id) json_err('inventory_id required');

pdo($pdo, 'DELETE FROM Inventory WHERE inventory_id = ?', [$inventory_id]);

json_out(['success' => true]);
