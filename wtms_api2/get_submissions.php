<?php
include 'db_connect.php';

if (!isset($_POST['worker_id'])) {
    echo json_encode(["status" => "error", "message" => "worker_id not provided"]);
    exit;
}

$worker_id = $_POST['worker_id'];

$sql = "SELECT 
            s.id AS submission_id, 
            s.submitted_at AS submissionDate, 
            s.submission_text AS submissionDescription, 
            w.title AS workTitle
        FROM tbl_submissions s
        JOIN tbl_works w ON s.work_id = w.id
        WHERE s.worker_id = ?";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $worker_id);
$stmt->execute();
$result = $stmt->get_result();

$submissions = [];
while ($row = $result->fetch_assoc()) {
    $submissions[] = $row;
}

echo json_encode([
    "status" => "success",
    "submissions" => $submissions
]);

$stmt->close();
$conn->close();
?>
