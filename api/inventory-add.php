<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') json_err('POST only', 405);

$body            = get_body();
$user_id         = (int)($body['user_id']         ?? 0);
$ingredient_name = sanitize_str($body['ingredient_name'] ?? '');
$quantity        = (float)($body['quantity']       ?? 0);
$unit            = sanitize_str($body['unit']      ?? '');
$expiration      = $body['expiration_date']        ?? null;

// Validate expiration date format if provided
if ($expiration && !preg_match('/^\d{4}-\d{2}-\d{2}$/', $expiration)) {
    $expiration = null;
}

if (!$user_id || !$ingredient_name || $quantity <= 0 || !$unit) json_err('Missing required fields');

// Find or create ingredient
$existing = pdo($pdo, 'SELECT ingredient_id FROM Ingredients WHERE LOWER(ingredient_name) = LOWER(?) LIMIT 1', [$ingredient_name])->fetch();
if ($existing) {
    $ingredient_id = (int)$existing['ingredient_id'];
} else {
    pdo($pdo, 'INSERT INTO Ingredients (ingredient_name, default_unit) VALUES (?, ?)', [$ingredient_name, $unit]);
    $ingredient_id = (int)$pdo->lastInsertId();
}

pdo($pdo, '
    INSERT INTO Inventory (ingredient_id, quantity, unit, expiration_date, user_id)
    VALUES (?, ?, ?, ?, ?)
', [$ingredient_id, $quantity, $unit, $expiration ?: null, $user_id]);

json_out(['success' => true, 'inventory_id' => (int)$pdo->lastInsertId()]);
