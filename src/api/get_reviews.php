<?php
session_start();
require_once 'connect.php';

$response = ['success' => false, 'reviews' => [], 'message' => ''];

try {
    if (!isset($_GET['gameid'])) {
        throw new Exception('Game ID is required', 400);
    }
    
    $gameId = filter_var($_GET['gameid'], FILTER_VALIDATE_INT);
    if (!$gameId) {
        throw new Exception('Invalid game ID', 400);
    }
    
    $pdo = getDatabaseConnection();
    
    // Get reviews with user information
    $stmt = $pdo->prepare("
        SELECT 
            r.reviewid,
            r.content,
            r.rating,
            r.date_posted,
            u.username
        FROM reviews r
        JOIN users u ON r.userid = u.userid
        WHERE r.gameid = ?
        ORDER BY r.date_posted DESC
    ");
    
    $stmt->execute([$gameId]);
    $reviews = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    $response = [
        'success' => true,
        'reviews' => $reviews
    ];
    
} catch (Exception $e) {
    http_response_code($e->getCode() ?: 400);
    $response['message'] = $e->getMessage();
    error_log("Get reviews error: " . $e->getMessage());
}

header('Content-Type: application/json');
echo json_encode($response);
?>