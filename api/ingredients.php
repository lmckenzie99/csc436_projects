<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

// ── GET: list ingredients for a recipe ───────────────────────
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $recipe_id = sanitize_int($_GET['recipe_id'] ?? 0);
    if (!$recipe_id) json_err('recipe_id required');

    $rows = pdo($pdo, '
        SELECT ri.recipe_id, ri.ingredient_id,
               ri.recipe_id * 1000000 + ri.ingredient_id AS ri_id,
               ri.quantity, ri.unit, i.ingredient_name
        FROM Recipe_Ingredients ri
        JOIN Ingredients i ON i.ingredient_id = ri.ingredient_id
        WHERE ri.recipe_id = ?
        ORDER BY i.ingredient_name
    ', [$recipe_id])->fetchAll();
    json_out($rows);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $body   = get_body();
    $action = sanitize_str($body['action'] ?? '', 20);

    // ── POST add ─────────────────────────────────────────────
    if ($action === 'add') {
        $recipe_id       = sanitize_int($body['recipe_id']       ?? 0);
        $user_id         = sanitize_int($body['user_id']         ?? 0);
        $ingredient_name = sanitize_str($body['ingredient_name'] ?? '', 100);
        $quantity        = (float)($body['quantity']             ?? 0);
        $unit            = sanitize_str($body['unit']            ?? 'count', 50);

        if (!$recipe_id || !$user_id || !$ingredient_name || $quantity <= 0) json_err('Missing required fields');

        $recipe = pdo($pdo, 'SELECT recipe_id FROM Recipes WHERE recipe_id = ? AND user_id = ? LIMIT 1', [$recipe_id, $user_id])->fetch();
        if (!$recipe) json_err('Recipe not found or not yours', 403);

        $ex = pdo($pdo, 'SELECT ingredient_id FROM Ingredients WHERE LOWER(ingredient_name) = LOWER(?) LIMIT 1', [$ingredient_name])->fetch();
        if ($ex) { $ing_id = (int)$ex['ingredient_id']; }
        else { pdo($pdo, 'INSERT INTO Ingredients (ingredient_name, default_unit) VALUES (?, ?)', [$ingredient_name, $unit]); $ing_id = (int)$pdo->lastInsertId(); }

        pdo($pdo, '
            INSERT INTO Recipe_Ingredients (recipe_id, ingredient_id, quantity, unit)
            VALUES (?, ?, ?, ?)
            ON DUPLICATE KEY UPDATE quantity = VALUES(quantity), unit = VALUES(unit)
        ', [$recipe_id, $ing_id, $quantity, $unit]);
        json_out(['success' => true]);
    }

    // ── POST delete ───────────────────────────────────────────
    if ($action === 'delete') {
        $recipe_id = sanitize_int($body['recipe_id'] ?? 0);
        $user_id   = sanitize_int($body['user_id']   ?? 0);
        $ri_id     = (float)($body['ri_id']          ?? 0);
        $ing_id    = (int)($ri_id - ($recipe_id * 1000000));

        if (!$recipe_id || !$user_id || !$ing_id) json_err('Missing required fields');

        $recipe = pdo($pdo, 'SELECT recipe_id FROM Recipes WHERE recipe_id = ? AND user_id = ? LIMIT 1', [$recipe_id, $user_id])->fetch();
        if (!$recipe) json_err('Recipe not found or not yours', 403);

        pdo($pdo, 'DELETE FROM Recipe_Ingredients WHERE recipe_id = ? AND ingredient_id = ?', [$recipe_id, $ing_id]);
        json_out(['success' => true]);
    }

    json_err('Unknown action');
}

json_err('Method not allowed', 405);
