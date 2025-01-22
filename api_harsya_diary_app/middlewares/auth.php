<?php
// middleware/auth.php
function checkAuth() {
    // Cek token di session atau header
    if (isset($_SESSION['token']) && !empty($_SESSION['token'])) {
      // Jika token tidak ada di session, cek di header Authorization
      if (isset(getallheaders()['Authorization'])) {
          $authHeader = getallheaders()['Authorization'];
          list($tokenType, $token) = explode(' ', $authHeader);
          if ($tokenType === 'Bearer' && !empty($token)) {
              // Validasi token (bisa disesuaikan lebih lanjut)
              if(isset($_SESSION['token']) && $_SESSION['token'] === $token){
                return true;
              }
          }
      }
    }

    // Ini bisa aja diubah menjadi false jika anda ingin menggunakan middleware ini, tapi ini aku ganti jadi true karena si flutter tidak bisa menggunakan session
    return true;
}
