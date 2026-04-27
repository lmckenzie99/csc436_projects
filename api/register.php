<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') json_err('POST only', 405);

$body     = get_body();
$username = sanitize_str($body['username'] ?? '', 50);
$password = $body['password'] ?? '';

if (!$username || strlen($username) < 3) json_err('Username must be at least 3 characters');
if (!$password || strlen($password) < 6) json_err('Password must be at least 6 characters');

$existing = pdo($pdo, 'SELECT user_id FROM Users WHERE LOWER(name) = LOWER(?) LIMIT 1', [$username])->fetch();
if ($existing) json_err('Username already taken', 409);

$hash = password_hash($password, PASSWORD_BCRYPT);

pdo($pdo, 'INSERT INTO Users (name, password) VALUES (?, ?)', [$username, $hash]);

json_out(['success' => true]);
