<?php
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') json_err('POST only', 405);

$body = get_body();
$type = trim($body['type'] ?? 'Other');

pdo($pdo, '
    INSERT INTO Recipes (recipe_name, instructions, source_api, cache_priority, last_fetched)
    VALUES (?, ?, ?, ?, NOW())
', [$type . ' Recipe', 'Fetched from external API — instructions pending.', 'Spoonacular', $type]);

$new_id = (int)$pdo->lastInsertId();
json_out(['success' => true, 'added' => 1, 'type' => $type, 'recipe_id' => $new_id]);
