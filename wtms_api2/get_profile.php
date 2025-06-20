<?php
include 'db_connect.php';

$worker_id = $_POST['worker_id'];

$sql = "SELECT name, email, phone, address FROM workers WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $worker_id);
$stmt->execute();
$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {
    echo json_encode(["success" => true, "profile" => $row]);
} else {
    echo json_encode(["success" => false, "message" => "Worker not found."]);
}

$stmt->close();
$conn->close();
?>
