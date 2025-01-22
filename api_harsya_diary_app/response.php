<?php
// response.php

function apiSuccess($data, $statusCode = 200, $message = null){
    $response = [
        'success' => true,
        'message' => $message,
        'data' => $data
    ];

    http_response_code($statusCode);
    echo json_encode($response);
    exit;
}

function apiError($message = null, $statusCode = 500){
    $response = [
        'success' => false,
        'message' => $message,
        'data' => null
    ];

    http_response_code($statusCode);
    echo json_encode($response);
    exit;
}
