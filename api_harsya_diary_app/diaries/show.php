<?php 

require_once '../config.php';
require_once '../middlewares/middleware.php';
require_once '../response.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $id = isset($_GET['id']) ? $_GET['id'] : null;
    $sql = "SELECT * FROM diaries";
    $result = mysqli_query($conn, $sql);

    if (mysqli_num_rows($result) > 0) {
        $diaries = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $diaries[] = $row;
        }

        $diaries = array_map(function($diary) {
            $diary['id'] = (int) $diary['id'];
            $diary['user_id'] = (int) $diary['user_id'];
            $diary['category_id'] = (int) $diary['category_id'];
            return $diary;
        }, $diaries);

        return apiSuccess($diaries, 200, 'All Diaries');
    } else {
        return apiError('No diaries found', 404);
    }
} else {
    return apiError('Invalid request method. Use GET.', 405);
}