<?php
// connect to database
error_reporting(0);
session_start();
$servername = "localhost";
$port = "3306";
$username = "root";
$password = "";
$dbname = "db_diary";
$conn = mysqli_connect($servername, $username, $password, $dbname);

// check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// define site title for all pages
define('SITE_TITLE', 'My Diary');
// define site URL for all pages
define('SITE_URL', 'http://localhost:3306/server-native/');