<?php
// diary/index.php
header('Content-Type: application/json');
require_once '../config.php';
require_once '../middlewares/middleware.php';
require_once '../response.php';

$sql = "SELECT * FROM diaries";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
    $diaries = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $diaries[] = $row;
    }
    
    // Konversi id dan user_id menjadi integer menggunakan array_map
    $diaries = array_map(function($diary) {
        $diary['id'] = (int) $diary['id'];
        $diary['user_id'] = (int) $diary['user_id'];
        $diary['category_id'] = (int) $diary['category_id'];
        return $diary;
    }, $diaries);

    // Kembalikan hasil dalam format JSON
    return apiSuccess($diaries, 200, 'All Diaries');
} else {
    return apiError('No diaries found', 404);
}
