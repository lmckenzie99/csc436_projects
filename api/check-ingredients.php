<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') json_err('GET only', 405);

$recipe_id = sanitize_int($_GET['recipe_id'] ?? 0);
$user_id   = sanitize_int($_GET['user_id']   ?? 0);
if (!$recipe_id || !$user_id) json_err('recipe_id and user_id required');

// Get all ingredients needed for this recipe
$needed = pdo($pdo, '
    SELECT ri.ingredient_id, ri.quantity AS needed_qty, ri.unit,
           i.ingredient_name
    FROM Recipe_Ingredients ri
    JOIN Ingredients i ON i.ingredient_id = ri.ingredient_id
    WHERE ri.recipe_id = ?
', [$recipe_id])->fetchAll();

if (empty($needed)) {
    json_out(['has_all' => true, 'ingredients' => [], 'missing' => []]);
}

// Check inventory for each ingredient
$have    = [];
$missing = [];

foreach ($needed as $ing) {
    $inv = pdo($pdo, '
        SELECT SUM(quantity) AS total_qty
        FROM Inventory
        WHERE ingredient_id = ? AND user_id = ?
    ', [$ing['ingredient_id'], $user_id])->fetch();

    $total = (float)($inv['total_qty'] ?? 0);
    $entry = [
        'ingredient_id'   => $ing['ingredient_id'],
        'ingredient_name' => $ing['ingredient_name'],
        'needed_qty'      => $ing['needed_qty'],
        'have_qty'        => $total,
        'unit'            => $ing['unit']
    ];

    if ($total >= $ing['needed_qty']) {
        $have[] = $entry;
    } else {
        $missing[] = $entry;
    }
}

json_out([
    'has_all'  => empty($missing),
    'have'     => $have,
    'missing'  => $missing
]);
