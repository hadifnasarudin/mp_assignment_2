<?php
header('Content-Type: application/json');

$servername = "localhost";
$username = "root";  // your DB username
$password = "";      // your DB password
$dbname = "wtms2_db";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    echo json_encode(['status' => 'error', 'message' => 'Database connection failed']);
    exit();
}

// Get POST data safely
$name = $_POST['name'] ?? '';
$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';
$phone = $_POST['phone'] ?? '';
$address = $_POST['address'] ?? '';

// Check for empty fields
if (empty($name) || empty($email) || empty($password) || empty($phone) || empty($address)) {
    echo json_encode(['status' => 'error', 'message' => 'Please fill all fields']);
    exit();
}

// Check if email already exists in 'workers' table
$sql_check = "SELECT id FROM workers WHERE email = ?";
$stmt_check = $conn->prepare($sql_check);
$stmt_check->bind_param("s", $email);
$stmt_check->execute();
$stmt_check->store_result();

if ($stmt_check->num_rows > 0) {
    echo json_encode(['status' => 'error', 'message' => 'Email already registered']);
    exit();
}

$stmt_check->close();

// Hash the password securely
$hashed_password = password_hash($password, PASSWORD_DEFAULT);

// Insert new worker into 'workers' table
$sql_insert = "INSERT INTO workers (name, email, password, phone, address) VALUES (?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sql_insert);
$stmt->bind_param("sssss", $name, $email, $hashed_password, $phone, $address);

if ($stmt->execute()) {
    echo json_encode(['status' => 'success', 'message' => 'Registration successful']);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Failed to register']);
}

$stmt->close();
$conn->close();
?>