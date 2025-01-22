<?php
// category/index.php
session_start();
header('Content-Type: application/json');
require_once '../config.php';
require_once '../middlewares/middleware.php';
require_once '../response.php';

$sql = "SELECT * FROM categories";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
    $categories = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $categories[] = $row;
    }
    
    // Konversi id dan user_id menjadi integer menggunakan array_map
    $categories = array_map(function($category) {
        $category['id'] = (int) $category['id'];
        $category['user_id'] = (int) $category['user_id'];
        return $category;
    }, $categories);

    // Kembalikan hasil dalam format JSON
    return apiSuccess($categories, 200, 'All Categories');
} else {
    return apiError('No categories found', 404);
}
