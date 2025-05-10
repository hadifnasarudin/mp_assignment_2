<?php
include 'db_connect.php';

$name = $_POST['name'];
$email = $_POST['email'];
$password = $_POST['password'];
$phone = $_POST['phone'];
$university = $_POST['university'];
$address = $_POST['address'];

// Insert into database
$sql = "INSERT INTO users (name, email, password, phone, university, address)
VALUES ('$name', '$email', '$password', '$phone', '$university', '$address')";

if (mysqli_query($conn, $sql)) {
    echo json_encode(["status" => "success"]);
} else {
    echo json_encode(["status" => "fail", "error" => mysqli_error($conn)]);
}
?>
