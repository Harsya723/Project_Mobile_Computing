<?php

header('Content-Type: application/json');
require_once '../config.php';
require_once '../middlewares/middleware.php';
require_once '../response.php';

// Ambil ID dari URL (misalnya: /update.php?id=1)
$id = isset($_GET['id']) ? $_GET['id'] : null;

$category = mysqli_query($conn, "SELECT * FROM categories WHERE id = '$id'");
if (mysqli_num_rows($category) === 0) {
    return apiError('Category not found', 404);
    exit;
}

$counta = mysqli_query($conn, "SELECT count(*) as counta FROM diaries WHERE category_id = '$id'");
// Pastikan query berhasil
if ($counta) {
    $row = mysqli_fetch_assoc($counta);

    // Jika ada data yang menggunakan category_id, return error
    if ($row['counta'] > 0) {
        return apiError('Do not delete this data, because data in use!', 409);
        exit;
    }
} else {
    // Jika query gagal, berikan respons error
    return apiError('Query failed to execute.', 500);
    exit;
}

if ($category) {
    // Pastikan data dikirim dengan metode DELETE
    if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
        // Query untuk hapus data kategori berdasarkan ID
        $sql = "DELETE FROM categories WHERE id = '$id'";

        if (mysqli_query($conn, $sql)) {
            return apiSuccess($category, 200, 'Category deleted successfully');
        } else {
            return apiError('Failed to delete category', 500);
        }
    } else {
        return apiError('Invalid request method. Use DELETE.', 405);
    }
} else {
    return apiError('ID parameter is required', 400);
}