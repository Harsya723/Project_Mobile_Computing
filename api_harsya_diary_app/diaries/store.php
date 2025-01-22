<?php
// Diary/create.php
header('Content-Type: application/json');
require_once '../config.php';
require_once '../middlewares/middleware.php';
require_once '../response.php';

// Pastikan data dikirim dengan metode POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Mengambil data non-file dari $_POST
    $user_id = $_POST['user_id'];  // Pastikan user_id valid
    $category_id = $_POST['category_id'];  // Pastikan category_id valid
    $title = $_POST['title'];  // Pastikan title valid
    $subject = $_POST['subject'];  // Pastikan subject valid
    $content = $_POST['content'];  // Pastikan content valid
    $date = $_POST['date'];  // Pastikan date valid

    // File upload
    if (isset($_FILES['attachment']) && $_FILES['attachment']['error'] === UPLOAD_ERR_OK) {
        // Menyimpan file
        $file_tmp = $_FILES['attachment']['tmp_name'];
        $file_name = $_FILES['attachment']['name'];
        $file_size = $_FILES['attachment']['size'];
        $file_type = $_FILES['attachment']['type'];

        // Tentukan folder tujuan untuk file upload
        $upload_dir = './../uploads/diaries/';
        if (!is_dir($upload_dir)) {
            mkdir($upload_dir, 0777, true);
        }
        $file_path = $upload_dir . basename($file_name);

        // Validasi file (misalnya, hanya menerima file gambar)
        $allowed_extensions = ['jpg', 'jpeg', 'png'];
        $file_extension = pathinfo($file_name, PATHINFO_EXTENSION);

        if (in_array(strtolower($file_extension), $allowed_extensions)) {
            // Jika file valid, move file ke folder tujuan
            if (move_uploaded_file($file_tmp, $file_path)) {
                $attachment_path = str_replace('./../', '', $file_path);

                // Pastikan semua input tidak kosong
                if (!empty($user_id) && !empty($category_id) && !empty($title) && !empty($subject) && !empty($content) && !empty($date)) {
                    $sql = "INSERT INTO diaries (user_id, category_id, title, subject, content, date, attachment, created_at, updated_at) 
                            VALUES ('$user_id', '$category_id', '$title', '$subject', '$content', '$date', '$attachment_path', NOW(), NOW())";

                    if (mysqli_query($conn, $sql)) {
                        return apiSuccess($data, 201, 'Diary created successfully');
                    } else {
                        return apiError('Failed to create diary', 500);
                    }
                } else {
                    return apiError('Invalid input', 422);
                }
            } else {
                return apiError('Failed to upload file', 500);
            }
        } else {
            return apiError('Invalid file type', 422);
        }
    } else {
        return apiError('Attachment is required', 422);
    }
}
