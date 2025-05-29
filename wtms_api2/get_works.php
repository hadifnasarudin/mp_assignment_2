<?php
header('Content-Type: application/json');
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "wtms2_db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    echo json_encode(['status' => 'error', 'message' => 'Database connection failed']);
    exit();
}

$workerId = $_GET['worker_id'] ?? '';

if (empty($workerId)) {
    echo json_encode(['status' => 'error', 'message' => 'Worker ID missing']);
    exit();
}

// Note: use assigned_to column here
$sql = "SELECT id, title, description, due_date, status FROM tbl_works WHERE assigned_to = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $workerId);
$stmt->execute();
$result = $stmt->get_result();

$tasks = [];
while ($row = $result->fetch_assoc()) {
    $tasks[] = $row;
}

echo json_encode(['status' => 'success', 'data' => $tasks]);

$stmt->close();
$conn->close();
?>
