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

// Sanitize a string input — strips tags, encodes special chars, trims whitespace.
// PDO prepared statements handle SQLi; this is defence-in-depth for XSS.
function sanitize_str($val, $max_len = 200) {
    $val = strip_tags((string)$val);          
    $val = htmlspecialchars($val, ENT_QUOTES | ENT_HTML5, 'UTF-8'); 
    $val = trim($val);
    return substr($val, 0, $max_len);
}

function sanitize_int($val) {
    return (int)filter_var($val, FILTER_SANITIZE_NUMBER_INT);
}

function sanitize_float($val) {
    return (float)filter_var($val, FILTER_SANITIZE_NUMBER_FLOAT, FILTER_FLAG_ALLOW_FRACTION);
}
