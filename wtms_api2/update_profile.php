<?php
header('Content-Type: application/json'); // Ensure JSON is returned
error_reporting(0); // Disable PHP warnings/notices in output
// error_reporting(E_ALL); ini_set('display_errors', 1); // (Uncomment for debugging)

include 'db_connect.php';

$worker_id = $_POST['worker_id'] ?? '';
$name = $_POST['name'] ?? '';
$email = $_POST['email'] ?? '';
$phone = $_POST['phone'] ?? '';
$address = $_POST['address'] ?? '';

// Basic validation (optional but good)
if (empty($worker_id) || empty($name) || empty($email) || empty($phone)) {
    echo json_encode(["status" => "error", "message" => "Missing required fields"]);
    exit();
}

$sql = "UPDATE workers SET name = ?, email = ?, phone = ?, address = ? WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ssssi", $name, $email, $phone, $address, $worker_id);

if ($stmt->execute()) {
    echo json_encode(["status" => "success", "message" => "Profile updated."]);
} else {
    echo json_encode(["status" => "error", "message" => "Update failed."]);
}

$stmt->close();
$conn->close();
?>
