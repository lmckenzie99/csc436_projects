<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') json_err('POST only', 405);

$body   = get_body();
$action = sanitize_str($body['action'] ?? '', 20);

// ── Login ─────────────────────────────────────────────────────
if ($action === 'login') {
    $username = sanitize_str($body['username'] ?? '', 100);
    $password = $body['password'] ?? '';
    if (!$username) json_err('Username required');

    $user = pdo($pdo, 'SELECT user_id, name, password FROM Users WHERE name = ? LIMIT 1', [$username])->fetch();
    if (!$user) json_err('Invalid credentials', 401);

    $valid = password_verify($password, $user['password']) || $password === $user['password'];
    if (!$valid) json_err('Invalid credentials', 401);

    json_out(['success' => true, 'user' => ['user_id' => (int)$user['user_id'], 'name' => $user['name']]]);
}

// ── Register ──────────────────────────────────────────────────
if ($action === 'register') {
    $username = sanitize_str($body['username'] ?? '', 50);
    $password = $body['password'] ?? '';
    if (!$username || strlen($username) < 3) json_err('Username must be at least 3 characters');
    if (!$password || strlen($password) < 6)  json_err('Password must be at least 6 characters');

    $existing = pdo($pdo, 'SELECT user_id FROM Users WHERE LOWER(name) = LOWER(?) LIMIT 1', [$username])->fetch();
    if ($existing) json_err('Username already taken', 409);

    pdo($pdo, 'INSERT INTO Users (name, password) VALUES (?, ?)', [$username, password_hash($password, PASSWORD_BCRYPT)]);
    json_out(['success' => true]);
}

json_err('Unknown action');
