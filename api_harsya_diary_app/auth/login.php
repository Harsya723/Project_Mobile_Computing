<?php
// auth/login.php
header('Content-Type: application/json');
require_once '../config.php';
require_once '../response.php';

// Pastikan data dikirim dengan metode POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Ambil data dari body request
    $data = json_decode(file_get_contents("php://input"), true);
    $username = $data['username'];  // Username atau email
    $password = $data['password'];  // Password yang dikirimkan pengguna

    // Cek apakah username/email ada di database
    $sql = "SELECT id, name, username, email, password FROM users WHERE username = '$username' OR email = '$username'";
    $result = mysqli_query($conn, $sql);

    if ($result && mysqli_num_rows($result) > 0) {
        $user = mysqli_fetch_assoc($result);

        // Verifikasi password yang dikirimkan dengan password yang ada di database
        if (password_verify($password, $user['password'])) {
            // Login berhasil, simpan informasi pengguna ke dalam session
            // make token bearer here
            $_SESSION['token'] = base64_encode(random_bytes(32));
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['user_name'] = $user['name'];
            $_SESSION['user_email'] = $user['email'];

            // Response sukses
            return apiSuccess([
                'access_token' => $_SESSION['token'],
                'token_type' => 'bearer',
                'user' => [
                    'id' => $user['id'],
                    'name' => $user['name'],
                    'username' => $user['username'],
                    'email' => $user['email'],
                ]
            ], 200, 'Login successful');
        } else {
            return apiError('Invalid password', 401);
        }
    } else {
        return apiError('Credentials not match', 401);
    }
} else {
    return apiError('Invalid request method', 405);
}
