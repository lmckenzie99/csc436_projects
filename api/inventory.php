<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

// ── GET ───────────────────────────────────────────────────────
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $user_id = sanitize_int($_GET['user_id'] ?? 0);
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
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $body   = get_body();
    $action = sanitize_str($body['action'] ?? '', 20);

    // ── add ───────────────────────────────────────────────────
    if ($action === 'add') {
        $user_id         = sanitize_int($body['user_id']         ?? 0);
        $ingredient_name = sanitize_str($body['ingredient_name'] ?? '', 200);
        $quantity        = sanitize_float($body['quantity']      ?? 0);
        $unit            = sanitize_str($body['unit']            ?? '', 50);
        $expiration      = $body['expiration_date']              ?? null;
        if ($expiration && !preg_match('/^\d{4}-\d{2}-\d{2}$/', $expiration)) $expiration = null;

        if (!$user_id || !$ingredient_name || $quantity <= 0 || !$unit) json_err('Missing required fields');

        $ex = pdo($pdo, 'SELECT ingredient_id FROM Ingredients WHERE LOWER(ingredient_name) = LOWER(?) LIMIT 1', [$ingredient_name])->fetch();
        if ($ex) { $ing_id = (int)$ex['ingredient_id']; }
        else { pdo($pdo, 'INSERT INTO Ingredients (ingredient_name, default_unit) VALUES (?, ?)', [$ingredient_name, $unit]); $ing_id = (int)$pdo->lastInsertId(); }

        pdo($pdo, 'INSERT INTO Inventory (ingredient_id, quantity, unit, expiration_date, user_id) VALUES (?, ?, ?, ?, ?)',
            [$ing_id, $quantity, $unit, $expiration ?: null, $user_id]);
        json_out(['success' => true, 'inventory_id' => (int)$pdo->lastInsertId()]);
    }

    // ── delete ────────────────────────────────────────────────
    if ($action === 'delete') {
        $inventory_id = sanitize_int($body['inventory_id'] ?? 0);
        if (!$inventory_id) json_err('inventory_id required');
        pdo($pdo, 'DELETE FROM Inventory WHERE inventory_id = ?', [$inventory_id]);
        json_out(['success' => true]);
    }

    // ── set-opened ────────────────────────────────────────────
    if ($action === 'set-opened') {
        $inventory_id = sanitize_int($body['inventory_id'] ?? 0);
        $date_opened  = $body['date_opened'] ?? '';
        if (!$inventory_id) json_err('inventory_id required');
        if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $date_opened)) json_err('Invalid date format');
        pdo($pdo, 'UPDATE Inventory SET date_opened = ? WHERE inventory_id = ?', [$date_opened, $inventory_id]);
        json_out(['success' => true]);
    }

    json_err('Unknown action');
}

json_err('Method not allowed', 405);
