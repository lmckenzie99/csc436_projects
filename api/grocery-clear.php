<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') json_err('POST only', 405);

$body    = get_body();
$user_id = sanitize_int($body['user_id'] ?? 0);
if (!$user_id) json_err('user_id required');

$result = pdo($pdo, 'DELETE FROM Grocery_List WHERE user_id = ? AND is_purchased = 1', [$user_id]);

json_out(['success' => true, 'removed' => $result->rowCount()]);
