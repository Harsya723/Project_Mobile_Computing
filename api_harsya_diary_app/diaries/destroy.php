<?php

header('Content-Type: application/json');
require_once '../config.php';
require_once '../middlewares/middleware.php';
require_once '../response.php';

// Ambil ID dari URL (misalnya: /update.php?id=1)
$id = isset($_GET['id']) ? $_GET['id'] : null;

$diary = mysqli_query($conn, "SELECT * FROM diaries WHERE id = '$id'");
if (mysqli_num_rows($diary) === 0) {
    return apiError('Diary not found', 404);
    exit;
}

if ($diary) {
    // Pastikan data dikirim dengan metode DELETE
    if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
        // Query untuk hapus data kategori berdasarkan ID
        $sql = "DELETE FROM diaries WHERE id = '$id'";

        if (mysqli_query($conn, $sql)) {
            return apiSuccess($diary, 200, 'Diary deleted successfully');
        } else {
            return apiError('Failed to delete diary', 500);
        }
    } else {
        return apiError('Invalid request method. Use DELETE.', 405);
    }
} else {
    return apiError('ID parameter is required', 400);
}