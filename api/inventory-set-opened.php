<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') json_err('POST only', 405);

$body         = get_body();
$inventory_id = sanitize_int($body['inventory_id'] ?? 0);
$date_opened  = $body['date_opened'] ?? '';

if (!$inventory_id) json_err('inventory_id required');
if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $date_opened)) json_err('Invalid date format');

pdo($pdo, 'UPDATE Inventory SET date_opened = ? WHERE inventory_id = ?', [$date_opened, $inventory_id]);

json_out(['success' => true]);
