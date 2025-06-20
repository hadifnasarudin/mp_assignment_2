<?php
$servername = "localhost";
$username = "root";
$password = ""; // Update if your MySQL password is different
$dbname = "wtms2_db"; // Updated database name

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>