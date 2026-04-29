<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

// ── GET ───────────────────────────────────────────────────────
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $user_id = sanitize_int($_GET['user_id'] ?? 0);
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
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $body   = get_body();
    $action = sanitize_str($body['action'] ?? '', 20);

    // ── add ───────────────────────────────────────────────────
    if ($action === 'add') {
        $user_id       = sanitize_int($body['user_id']       ?? 0);
        $ingredient_id = sanitize_int($body['ingredient_id'] ?? 0);
        $quantity      = (float)($body['quantity']           ?? 1);
        $unit          = sanitize_str($body['unit']          ?? 'count', 50);
        if (!$user_id || !$ingredient_id) json_err('user_id and ingredient_id required');

        $exists = pdo($pdo, 'SELECT list_id FROM Grocery_List WHERE user_id = ? AND ingredient_id = ? AND is_purchased = 0 LIMIT 1', [$user_id, $ingredient_id])->fetch();
        if ($exists) json_out(['success' => true, 'already_listed' => true]);

        pdo($pdo, 'INSERT INTO Grocery_List (ingredient_id, quantity, unit, is_purchased, user_id) VALUES (?, ?, ?, 0, ?)',
            [$ingredient_id, $quantity, $unit, $user_id]);
        json_out(['success' => true, 'already_listed' => false]);
    }

    // ── bought ────────────────────────────────────────────────
    if ($action === 'bought') {
        $list_id       = sanitize_int($body['list_id']       ?? 0);
        $ingredient_id = sanitize_int($body['ingredient_id'] ?? 0);
        $quantity      = sanitize_float($body['quantity']    ?? 0);
        $unit          = sanitize_str($body['unit']          ?? 'count', 50);
        $user_id       = sanitize_int($body['user_id']       ?? 0);
        if (!$list_id || !$ingredient_id || !$user_id) json_err('Missing required fields');

        pdo($pdo, 'UPDATE Grocery_List SET is_purchased = 1 WHERE list_id = ?', [$list_id]);
        pdo($pdo, 'INSERT INTO Inventory (ingredient_id, quantity, unit, user_id) VALUES (?, ?, ?, ?)',
            [$ingredient_id, $quantity ?: 1, $unit ?: 'count', $user_id]);
        json_out(['success' => true]);
    }

    // ── clear ─────────────────────────────────────────────────
    if ($action === 'clear') {
        $user_id = sanitize_int($body['user_id'] ?? 0);
        if (!$user_id) json_err('user_id required');
        $result = pdo($pdo, 'DELETE FROM Grocery_List WHERE user_id = ? AND is_purchased = 1', [$user_id]);
        json_out(['success' => true, 'removed' => $result->rowCount()]);
    }

    json_err('Unknown action');
}

json_err('Method not allowed', 405);
