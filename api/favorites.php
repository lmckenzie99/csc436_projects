<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $user_id = (int)($_GET['user_id'] ?? 0);
    if (!$user_id) json_err('user_id required');

    $rows = pdo($pdo, '
        SELECT f.favorite_id, f.recipe_id, f.rating, f.notes, f.date_added,
               r.recipe_name
        FROM Favorites f
        JOIN Recipes r ON r.recipe_id = f.recipe_id
        WHERE f.user_id = ?
        ORDER BY f.date_added DESC
    ', [$user_id])->fetchAll();

    json_out($rows);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $body      = get_body();
    $user_id   = (int)($body['user_id']   ?? 0);
    $recipe_id = (int)($body['recipe_id'] ?? 0);
    if (!$user_id || !$recipe_id) json_err('user_id and recipe_id required');

    $existing = pdo($pdo, 'SELECT favorite_id FROM Favorites WHERE user_id = ? AND recipe_id = ?', [$user_id, $recipe_id])->fetch();

    if ($existing) {
        pdo($pdo, 'DELETE FROM Favorites WHERE favorite_id = ?', [$existing['favorite_id']]);
        json_out(['favorited' => false]);
    } else {
        pdo($pdo, 'INSERT INTO Favorites (recipe_id, user_id, date_added) VALUES (?, ?, NOW())', [$recipe_id, $user_id]);
        json_out(['favorited' => true]);
    }
}

json_err('Method not allowed', 405);
