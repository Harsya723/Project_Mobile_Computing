<?php
// middlewares/middleware.php
require_once 'auth.php';

if (!checkAuth()) {
    http_response_code(401);
    echo json_encode(['message' => 'Unauthorized!']);
    exit;
}