<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') json_err('POST only', 405);

$body      = get_body();
$recipe_id = sanitize_int($body['recipe_id'] ?? 0);
$user_id   = sanitize_int($body['user_id']   ?? 0);

if (!$recipe_id || !$user_id) json_err('recipe_id and user_id required');

// Verify ownership before deleting
$recipe = pdo($pdo, 'SELECT recipe_id FROM Recipes WHERE recipe_id = ? AND user_id = ? LIMIT 1', [$recipe_id, $user_id])->fetch();
if (!$recipe) json_err('Recipe not found or not yours', 403);

// Clean up related data
pdo($pdo, 'DELETE FROM Recipe_Ingredients WHERE recipe_id = ?', [$recipe_id]);
pdo($pdo, 'DELETE FROM Recipe_Tags WHERE recipe_id = ?', [$recipe_id]);
pdo($pdo, 'DELETE FROM Favorites WHERE recipe_id = ?', [$recipe_id]);
pdo($pdo, 'DELETE FROM Recipes WHERE recipe_id = ? AND user_id = ?', [$recipe_id, $user_id]);

json_out(['success' => true]);
