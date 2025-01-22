<?php
// users/update.php
header('Content-Type: application/json');
require_once '../config.php';
require_once '../middlewares/middleware.php';
require_once '../response.php';

// Ambil ID dari URL (misalnya: /update.php?id=1)
$id = isset($_GET['id']) ? $_GET['id'] : null;
// check if id is exist
$user = mysqli_query($conn, "SELECT * FROM users WHERE id = '$id'");
if (mysqli_num_rows($user) === 0) {
    return apiError(404, 'User not found');
    exit;
}

if ($user) {
    // Pastikan data dikirim dengan metode PUT
    if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
        // Ambil data dari body request
        $data = json_decode(file_get_contents("php://input"), true);

        // Ambil data yang akan di-update
        $name = isset($data['name']) ? $data['name'] : null;  // Pastikan name valid
        $username = isset($data['username']) ? $data['username'] : null;  // Pastikan username valid
        error_log("name: $name, username: $username");
        if (!empty($name) && !empty($username)) {
            // Query untuk update data kategori berdasarkan ID
            $sql = "UPDATE users SET name = '$name', username = '$username' WHERE id = '$id'";

            if (mysqli_query($conn, $sql)) {
                return apiSuccess($data, 200, 'User updated successfully');
            } else {
                return apiError('Failed to update user', 500);
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
