<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
 
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}
 
function json_out($data, $code = 200) {
    http_response_code($code);
    echo json_encode($data);
    exit;
}
 
function json_err($msg, $code = 400) {
    json_out(['error' => $msg], $code);
}
 
function get_body() {
    return json_decode(file_get_contents('php://input'), true) ?? [];
}
 
