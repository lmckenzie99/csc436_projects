<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') json_err('POST only', 405);

$body     = get_body();
$username = trim($body['username'] ?? '');
$password = $body['password'] ?? '';

if (!$username) json_err('Username required');

$user = pdo($pdo, 'SELECT user_id, name, password FROM Users WHERE name = ? LIMIT 1', [$username])->fetch();

if (!$user) json_err('Invalid credentials', 401);

// Plain text comparison — swap for password_verify() if you hash passwords later
if ($password !== $user['password']) json_err('Invalid credentials', 401);

json_out([
    'success' => true,
    'user'    => ['user_id' => (int)$user['user_id'], 'name' => $user['name']]
]);
