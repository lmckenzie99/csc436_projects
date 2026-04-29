<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') json_err('GET only', 405);

$recipe_id = sanitize_int($_GET['recipe_id'] ?? 0);
$user_id   = sanitize_int($_GET['user_id']   ?? 0);
if (!$recipe_id || !$user_id) json_err('recipe_id and user_id required');

$needed = pdo($pdo, '
    SELECT ri.ingredient_id, ri.quantity AS needed_qty, ri.unit,
           i.ingredient_name
    FROM Recipe_Ingredients ri
    JOIN Ingredients i ON i.ingredient_id = ri.ingredient_id
    WHERE ri.recipe_id = ?
', [$recipe_id])->fetchAll();

if (empty($needed)) {
    json_out(['has_all' => true, 'have' => [], 'missing' => []]);
}

$inventory = pdo($pdo, '
    SELECT inv.ingredient_id, inv.quantity, inv.unit, i.ingredient_name
    FROM Inventory inv
    JOIN Ingredients i ON i.ingredient_id = inv.ingredient_id
    WHERE inv.user_id = ?
', [$user_id])->fetchAll();

// Strip common plural suffixes for fuzzy matching
function stem($name) {
    $name = strtolower(trim($name));
    $name = preg_replace('/(oes|ies|ves|es|s)$/', '', $name);
    return $name;
}

// Build stem -> total qty from inventory
$inv_by_stem = [];
foreach ($inventory as $row) {
    $key = stem($row['ingredient_name']);
    $inv_by_stem[$key] = ($inv_by_stem[$key] ?? 0) + (float)$row['quantity'];
}

// Also build exact id -> qty for direct matches
$inv_by_id = [];
foreach ($inventory as $row) {
    $id = (int)$row['ingredient_id'];
    $inv_by_id[$id] = ($inv_by_id[$id] ?? 0) + (float)$row['quantity'];
}

$have    = [];
$missing = [];

foreach ($needed as $ing) {
    $needed_qty = (float)$ing['needed_qty'];
    $ing_id     = (int)$ing['ingredient_id'];

    // Prefer exact ID match, fall back to stemmed name match
    if (isset($inv_by_id[$ing_id])) {
        $have_qty = $inv_by_id[$ing_id];
    } else {
        $have_qty = $inv_by_stem[stem($ing['ingredient_name'])] ?? 0;
    }

    $entry = [
        'ingredient_id'   => $ing_id,
        'ingredient_name' => $ing['ingredient_name'],
        'needed_qty'      => $needed_qty,
        'have_qty'        => $have_qty,
        'unit'            => $ing['unit']
    ];

    if ($have_qty >= $needed_qty) {
        $have[] = $entry;
    } else {
        $missing[] = $entry;
    }
}

json_out([
    'has_all' => empty($missing),
    'have'    => $have,
    'missing' => $missing
]);
