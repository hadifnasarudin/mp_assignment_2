<?php
include 'db_connect.php';

$submission_id = $_POST['submission_id'];
$updated_text = $_POST['updated_text'];

$sql = "UPDATE tbl_submission SET submissionDescription = ? WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("si", $updated_text, $submission_id);

if ($stmt->execute()) {
    echo json_encode(["status" => "success", "message" => "Submission updated."]);
} else {
    echo json_encode(["status" => "error", "message" => "Update failed."]);
}

$stmt->close();
$conn->close();
?>
