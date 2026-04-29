<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') json_err('POST only', 405);

$body          = get_body();
$user_id       = sanitize_int($body['user_id']       ?? 0);
$ingredient_id = sanitize_int($body['ingredient_id'] ?? 0);
$quantity      = (float)($body['quantity']            ?? 1);
$unit          = sanitize_str($body['unit']           ?? 'count', 50);

if (!$user_id || !$ingredient_id) json_err('user_id and ingredient_id required');

// Don't add if already on list and not yet purchased
$exists = pdo($pdo, '
    SELECT list_id FROM Grocery_List
    WHERE user_id = ? AND ingredient_id = ? AND is_purchased = 0 LIMIT 1
', [$user_id, $ingredient_id])->fetch();

if ($exists) {
    json_out(['success' => true, 'already_listed' => true]);
}

pdo($pdo, '
    INSERT INTO Grocery_List (ingredient_id, quantity, unit, is_purchased, user_id)
    VALUES (?, ?, ?, 0, ?)
', [$ingredient_id, $quantity, $unit, $user_id]);

json_out(['success' => true, 'already_listed' => false]);
