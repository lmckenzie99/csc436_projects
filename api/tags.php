<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $recipe_id = (int)($_GET['recipe_id'] ?? 0);
    if ($recipe_id) {
        $rows = pdo($pdo, '
            SELECT t.tag_id, t.tag_name, t.color
            FROM Tags t
            JOIN Recipe_Tags rt ON rt.tag_id = t.tag_id
            WHERE rt.recipe_id = ?
        ', [$recipe_id])->fetchAll();
    } else {
        $rows = pdo($pdo, 'SELECT tag_id, tag_name, color FROM Tags ORDER BY tag_name')->fetchAll();
    }
    json_out($rows);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $body      = get_body();
    $action    = $body['action']    ?? '';
    $recipe_id = (int)($body['recipe_id'] ?? 0);

    if ($action === 'add') {
        $tag_name = trim($body['tag_name'] ?? '');
        if (!$tag_name || !$recipe_id) json_err('recipe_id and tag_name required');

        $tag = pdo($pdo, 'SELECT tag_id FROM Tags WHERE tag_name = ? LIMIT 1', [$tag_name])->fetch();
        if (!$tag) {
            pdo($pdo, 'INSERT INTO Tags (tag_name, color) VALUES (?, ?)', [$tag_name, '#D5B8DA']);
            $tag_id = (int)$pdo->lastInsertId();
        } else {
            $tag_id = (int)$tag['tag_id'];
        }

        $linked = pdo($pdo, 'SELECT 1 FROM Recipe_Tags WHERE recipe_id = ? AND tag_id = ?', [$recipe_id, $tag_id])->fetch();
        if (!$linked) {
            pdo($pdo, 'INSERT INTO Recipe_Tags (recipe_id, tag_id, date_tagged) VALUES (?, ?, NOW())', [$recipe_id, $tag_id]);
        }
        json_out(['success' => true, 'tag_id' => $tag_id]);
    }

    if ($action === 'remove') {
        $tag_id = (int)($body['tag_id'] ?? 0);
        if (!$recipe_id || !$tag_id) json_err('recipe_id and tag_id required');
        pdo($pdo, 'DELETE FROM Recipe_Tags WHERE recipe_id = ? AND tag_id = ?', [$recipe_id, $tag_id]);
        json_out(['success' => true]);
    }

    json_err('Unknown action');
}

json_err('Method not allowed', 405);
