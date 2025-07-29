<?php
session_start();
require_once 'connect.php';

header('Content-Type: application/json');

// Debug: check raw input
error_log("FAV DEBUG: POST = " . print_r($_POST, true));
error_log("FAV DEBUG: SESSION = " . print_r($_SESSION, true));

if (!isset($_SESSION['user']['id'])) {
    error_log("FAV DEBUG: No user session");
    echo json_encode(['success' => false, 'message' => 'No user session']);
    exit;
}

$userid = $_SESSION['user']['id'];
$gameid = $_POST['gameid'] ?? null;

if (!$gameid) {
    error_log("FAV DEBUG: Missing gameid");
    echo json_encode(['success' => false, 'message' => 'Missing game ID']);
    exit;
}

try {
    $pdo = getDatabaseConnection();

    $stmt = $pdo->prepare("SELECT 1 FROM user_favorites WHERE userid = :userid AND gameid = :gameid");
    $stmt->execute([':userid' => $userid, ':gameid' => $gameid]);
    $exists = $stmt->fetchColumn();

    if ($exists) {
        $stmt = $pdo->prepare("DELETE FROM user_favorites WHERE userid = :userid AND gameid = :gameid");
        $stmt->execute([':userid' => $userid, ':gameid' => $gameid]);
        echo json_encode(['success' => true, 'favorited' => false]);
    } else {
        $stmt = $pdo->prepare("INSERT INTO user_favorites (userid, gameid) VALUES (:userid, :gameid)");
        $stmt->execute([':userid' => $userid, ':gameid' => $gameid]);
        echo json_encode(['success' => true, 'favorited' => true]);
    }
} catch (PDOException $e) {
    error_log("FAV DEBUG: DB ERROR - " . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Error al agregar favorito']);
}
