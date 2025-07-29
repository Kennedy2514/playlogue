<?php
session_start();
require_once 'connect.php';

header('Content-Type: application/json');

if (!isset($_SESSION['user']['id'])) {
    echo json_encode(['success' => false, 'message' => 'No user session']);
    exit;
}

$userid = $_SESSION['user']['id'];
$gameid = $_GET['gameid'] ?? null;

if (!$gameid) {
    echo json_encode(['success' => false, 'message' => 'Missing game ID']);
    exit;
}

try {
    $pdo = getDatabaseConnection();
    $stmt = $pdo->prepare("SELECT 1 FROM user_favorites WHERE userid = :userid AND gameid = :gameid");
    $stmt->execute([':userid' => $userid, ':gameid' => $gameid]);
    $favorited = $stmt->fetchColumn() ? true : false;

    echo json_encode(['success' => true, 'favorited' => $favorited]);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'DB error: ' . $e->getMessage()]);
}
