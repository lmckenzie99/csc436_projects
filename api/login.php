<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') json_err('POST only', 405);

$body     = get_body();
$username = sanitize_str($body['username'] ?? '', 100);
$password = $body['password'] ?? '';

if (!$username) json_err('Username required');

$user = pdo($pdo, 'SELECT user_id, name, password FROM Users WHERE name = ? LIMIT 1', [$username])->fetch();

if (!$user) json_err('Invalid credentials', 401);

// Support both bcrypt hashes (new users) and plain text (legacy)
$valid = password_verify($password, $user['password'])
      || $password === $user['password'];

if (!$valid) json_err('Invalid credentials', 401);

json_out([
    'success' => true,
    'user'    => ['user_id' => (int)$user['user_id'], 'name' => $user['name']]
]);
