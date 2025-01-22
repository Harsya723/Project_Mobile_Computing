<?php
// auth/register.php
session_start();  // Memulai session
header('Content-Type: application/json');
require_once '../config.php';
require_once '../response.php';

// Pastikan data dikirim dengan metode POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Ambil data dari body request
    $data = json_decode(file_get_contents("php://input"), true);
    $name = $data['name'];
    $username = $data['username'];
    $email = $data['email'];
    $password = $data['password'];  // Password yang dikirimkan pengguna

    // Cek apakah username atau email sudah terdaftar
    $sql = "SELECT id FROM users WHERE username = '$username' OR email = '$email'";
    $result = mysqli_query($conn, $sql);

    if (mysqli_num_rows($result) > 0) {
        return apiError('Username or email already exists', 409);
    } else {
        // Hash password sebelum disimpan di database
        $hashed_password = password_hash($password, PASSWORD_BCRYPT);

        // Insert data pengguna baru ke database
        $sql = "INSERT INTO users (name, username, email, password, created_at, updated_at) 
                VALUES ('$name', '$username', '$email', '$hashed_password', NOW(), NOW())";

        if (mysqli_query($conn, $sql)) {
            return apiSuccess($data, 201, 'User registered successfully');
        } else {
            return apiError('Failed to register user', 500);
        }
    }
} else {
    return apiError('Invalid request method', 405);
}
