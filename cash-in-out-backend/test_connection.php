<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header('Access-Control-Allow-Headers: Content-Type');

// Simple endpoint to test API connectivity
echo json_encode([
    'success' => true,
    'message' => 'Connection successful',
    'timestamp' => date('Y-m-d H:i:s')
]);
?>