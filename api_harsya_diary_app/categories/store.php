<?php
// category/create.php
header('Content-Type: application/json');
require_once '../config.php';
require_once '../middlewares/middleware.php';
require_once '../response.php';

// Pastikan data dikirim dengan metode POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);
    $name = $data['name'];
    $user_id = $data['user_id'];

    if (!empty($name) && !empty($user_id)) {
        $sql = "INSERT INTO categories (user_id, name, created_at, updated_at) VALUES ('$user_id', '$name', NOW(), NOW())";
        if (mysqli_query($conn, $sql)) {
            return apiSuccess($data, 201, 'Category created successfully');
        } else {
            return apiError('Failed to create category', 500);
        }
    } else {
        return apiError('Invalid input', 422);
    }
}
