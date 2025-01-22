<?php
// category/update.php
header('Content-Type: application/json');
require_once '../config.php';
require_once '../middlewares/middleware.php';
require_once '../response.php';

// Ambil ID dari URL (misalnya: /update.php?id=1)
$id = isset($_GET['id']) ? $_GET['id'] : null;
// check if id is exist
$category = mysqli_query($conn, "SELECT * FROM categories WHERE id = '$id'");
if (mysqli_num_rows($category) === 0) {
    return apiError(404, 'Category not found');
    exit;
}

if ($category) {
    // Pastikan data dikirim dengan metode PUT
    if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
        // Ambil data dari body request
        $data = json_decode(file_get_contents("php://input"), true);

        // Ambil data yang akan di-update
        $user_id = isset($data['user_id']) ? $data['user_id'] : null;  // Pastikan user_id valid
        $name = isset($data['name']) ? $data['name'] : null;  // Pastikan name valid

        if (!empty($user_id) && !empty($name)) {
            // Query untuk update data kategori berdasarkan ID
            $sql = "UPDATE categories SET user_id = '$user_id', name = '$name', updated_at = NOW() WHERE id = '$id'";

            if (mysqli_query($conn, $sql)) {
                return apiSuccess($data, 200, 'Category updated successfully');
            } else {
                return apiError('Failed to update category', 500);
            }
        } else {
            return apiError('Invalid input', 422);
        }
    } else {
        return apiError('Invalid request method. Use PUT.', 405);
    }
} else {
    return apiError('ID parameter is required', 400);
}
