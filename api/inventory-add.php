<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') json_err('POST only', 405);

$body         = get_body();
$user_id      = (int)($body['user_id']      ?? 0);
$ingredient_id = (int)($body['ingredient_id'] ?? 0);
$quantity     = (float)($body['quantity']    ?? 0);
$unit         = trim($body['unit']           ?? '');
$expiration   = $body['expiration_date']     ?? null;

if (!$user_id || !$ingredient_id || $quantity <= 0 || !$unit) json_err('Missing required fields');

pdo($pdo, '
    INSERT INTO Inventory (ingredient_id, quantity, unit, expiration_date, user_id)
    VALUES (?, ?, ?, ?, ?)
', [$ingredient_id, $quantity, $unit, $expiration ?: null, $user_id]);

json_out(['success' => true, 'inventory_id' => (int)$pdo->lastInsertId()]);
