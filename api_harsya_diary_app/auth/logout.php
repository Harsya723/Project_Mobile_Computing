<?php
// auth/logout.php
require_once '../config.php';
require_once '../middlewares/middleware.php';
require_once '../response.php';

// with header content-type application/json and bearer with post method
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Pastikan token yang dikirimkan oleh pengguna valid
    session_unset();
    session_destroy();
    return apiSuccess('Token has been removed', 200, 'Logout successful');
} else {
    return apiError('Invalid request method', 405);
}
