<?php
header('Content-Type: application/json');
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "wtms2_db";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    echo json_encode(['status' => 'error', 'message' => 'DB connection failed']);
    exit();
}

$work_id = $_POST['work_id'] ?? '';
$worker_id = $_POST['worker_id'] ?? '';
$submission_text = $_POST['submission_text'] ?? '';

if (empty($work_id) || empty($worker_id) || empty($submission_text)) {
    echo json_encode(['status' => 'error', 'message' => 'Please fill all fields']);
    exit();
}

$sql = "INSERT INTO tbl_submissions (work_id, worker_id, submission_text, submitted_at) VALUES (?, ?, ?, NOW())";
$stmt = $conn->prepare($sql);
$stmt->bind_param("iis", $work_id, $worker_id, $submission_text);

if ($stmt->execute()) {
    echo json_encode(['status' => 'success', 'message' => 'Submission successful']);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Failed to submit']);
}

$stmt->close();
$conn->close();
?>
