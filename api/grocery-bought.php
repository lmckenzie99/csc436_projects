<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') json_err('POST only', 405);

$body          = get_body();
$list_id       = sanitize_int($body['list_id']       ?? 0);
$ingredient_id = sanitize_int($body['ingredient_id'] ?? 0);
$quantity      = sanitize_float($body['quantity']    ?? 0);
$unit          = sanitize_str($body['unit']          ?? '', 50);
$user_id       = sanitize_int($body['user_id']       ?? 0);

if (!$list_id || !$ingredient_id || !$user_id) json_err('Missing required fields');

pdo($pdo, 'UPDATE Grocery_List SET is_purchased = 1 WHERE list_id = ?', [$list_id]);

pdo($pdo, '
    INSERT INTO Inventory (ingredient_id, quantity, unit, user_id)
    VALUES (?, ?, ?, ?)
', [$ingredient_id, $quantity ?: 1, $unit ?: 'count', $user_id]);

json_out(['success' => true]);
