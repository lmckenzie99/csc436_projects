<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $recipe_id = sanitize_int($_GET['recipe_id'] ?? 0);

    if ($recipe_id) {
        // tags for a specific recipe
        $rows = pdo($pdo, '
            SELECT t.tag_id, t.tag_name, t.color
            FROM Tags t
            JOIN Recipe_Tags rt ON rt.tag_id = t.tag_id
            WHERE rt.recipe_id = ?
        ', [$recipe_id])->fetchAll();
    } else {
        // all tags
        $rows = pdo($pdo, 'SELECT tag_id, tag_name, color FROM Tags ORDER BY tag_name')->fetchAll();
    }
    json_out($rows);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $body      = get_body();
    $action    = sanitize_str($body['action']    ?? '', 20);
    $recipe_id = sanitize_int($body['recipe_id'] ?? 0);

    if ($action === 'add') {
        $tag_name = sanitize_str($body['tag_name'] ?? '', 100);
        if (!$tag_name || !$recipe_id) json_err('recipe_id and tag_name required');

        $tag = pdo($pdo, 'SELECT tag_id FROM Tags WHERE LOWER(tag_name) = LOWER(?) LIMIT 1', [$tag_name])->fetch();
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
        json_out(['success' => true, 'tag_id' => $tag_id, 'tag_name' => $tag_name]);
    }

    if ($action === 'remove') {
        $tag_id = sanitize_int($body['tag_id'] ?? 0);
        if (!$recipe_id || !$tag_id) json_err('recipe_id and tag_id required');
        pdo($pdo, 'DELETE FROM Recipe_Tags WHERE recipe_id = ? AND tag_id = ?', [$recipe_id, $tag_id]);
        json_out(['success' => true]);
    }

    json_err('Unknown action');
}

json_err('Method not allowed', 405);
