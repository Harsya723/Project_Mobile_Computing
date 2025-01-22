<?php
// Diary/update.php
header('Content-Type: application/json');
require_once '../config.php';
require_once '../middlewares/middleware.php';
require_once '../response.php';

// Pastikan data dikirim dengan metode POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Ambil ID dari parameter URL
    $id = isset($_GET['id']) ? $_GET['id'] : null;
    
    if (!$id) {
        return apiError('ID parameter is required', 400);
        exit;
    }

    // Ambil data JSON yang dikirimkan dalam request body
    // $data = json_decode(file_get_contents("php://input"), true);

    $user_id = isset($_POST['user_id']) ? $_POST['user_id'] : null;
    $category_id = isset($_POST['category_id']) ? $_POST['category_id'] : null;
    $title = isset($_POST['title']) ? $_POST['title'] : null;
    $subject = isset($_POST['subject']) ? $_POST['subject'] : null;
    $content = isset($_POST['content']) ? $_POST['content'] : null;
    $date = isset($_POST['date']) ? $_POST['date'] : null;

    // File upload (optional)
    $attachment_path = null; // default attachment is null

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
        
        // Validasi file (misalnya, hanya menerima file gambar)
        $allowed_extensions = ['jpg', 'jpeg', 'png'];
        $file_extension = pathinfo($file_name, PATHINFO_EXTENSION);
        $file_path = $upload_dir . time() . '.' . $file_extension;
        error_log($file_path);

        if (in_array(strtolower($file_extension), $allowed_extensions)) {
            // Cek apakah ada file lama yang perlu dihapus
            $sql = "SELECT attachment FROM diaries WHERE id = '$id'";
            $result = mysqli_query($conn, $sql);

            if ($result && mysqli_num_rows($result) > 0) {
                $row = mysqli_fetch_assoc($result);
                $old_file_path = $row['attachment'];
                error_log($old_file_path);

                // Jika ada file lama, hapus file tersebut
                if ($old_file_path && file_exists($old_file_path)) {
                    unlink($old_file_path);
                }
            }

            // Jika file valid, move file ke folder tujuan
            if (move_uploaded_file($file_tmp, $file_path)) {
                $attachment_path = $file_path; // menyimpan path file
            } else {
                return apiError('Failed to upload file', 500);
                exit;
            }
        } else {
            return apiError('Invalid file type', 422);
            exit;
        }
    } else {
        // Jika tidak ada file yang di-upload, gunakan attachment yang lama
        // Query untuk mendapatkan data lama jika perlu
        $sql = "SELECT attachment FROM diaries WHERE id = '$id'";
        $result = mysqli_query($conn, $sql);

        if ($result && mysqli_num_rows($result) > 0) {
            $row = mysqli_fetch_assoc($result);
            // ./../ replace
            $attachment_path = $row['attachment'];
        }
    }

    // Pastikan semua input tidak kosong
    if (!empty($user_id) && !empty($category_id) && !empty($title) && !empty($subject) && !empty($content) && !empty($date)) {
        // Query untuk update data diary
        $attachment_path = str_replace('./../', '', $attachment_path);
        $sql = "UPDATE diaries SET user_id = '$user_id', category_id = '$category_id', title = '$title', 
                subject = '$subject', content = '$content', date = '$date', attachment = '$attachment_path', 
                updated_at = NOW() WHERE id = '$id'";

        if (!mysqli_query($conn, $sql)) {
            return apiError('Failed to update diary. Error: ' . mysqli_error($conn), 500);
        }

        return apiSuccess($data, 200, 'Diary updated successfully');
    } else {
        return apiError('Invalid input', 400);
    }
}
