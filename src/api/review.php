<?php
session_start();
require 'connect.php';

$response = ['success' => false, 'message' => ''];
$isAjax = false;

try {
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        throw new Exception('Método no permitido', 405);
    }
    
    if (!isset($_SESSION['user']['id'])) {
        throw new Exception('Debes iniciar sesión para reseñar', 401);
    }
    
    // Check if it's an AJAX request
    $isAjax = isset($_SERVER['HTTP_X_REQUESTED_WITH']) && 
              strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest' ||
              (isset($_SERVER['CONTENT_TYPE']) && 
               strpos($_SERVER['CONTENT_TYPE'], 'application/json') !== false);
    
    // Get input data from either JSON or form submission
    $input = [];
    if (isset($_SERVER['CONTENT_TYPE']) && strpos($_SERVER['CONTENT_TYPE'], 'application/json') !== false) {
        $input = json_decode(file_get_contents('php://input'), true) ?? [];
    } else {
        $input = $_POST;
    }
    
    // Validate inputs
    $gameId = filter_var($input['gameid'] ?? null, FILTER_VALIDATE_INT);
    $content = trim($input['content'] ?? '');
    $rating = filter_var($input['rating'] ?? null, FILTER_VALIDATE_INT, [
        'options' => ['min_range' => 1, 'max_range' => 5]
    ]);
    
    if (!$gameId) {
        throw new Exception('ID de juego inválido', 400);
    }
    
    if (strlen($content) < 10) {
        throw new Exception('La reseña debe tener al menos 10 caracteres', 400);
    }
    
    if (!$rating) {
        throw new Exception('La calificación debe ser entre 1-5 estrellas', 400);
    }
    
    // Check if user already reviewed this game
    $pdo = getDatabaseConnection();
    $checkStmt = $pdo->prepare("SELECT reviewid FROM reviews WHERE userid = ? AND gameid = ?");
    $checkStmt->execute([$_SESSION['user']['id'], $gameId]);
    
    if ($checkStmt->fetch()) {
        throw new Exception('Ya has reseñado este juego', 400);
    }
    
    // Save to database
    $stmt = $pdo->prepare("
        INSERT INTO reviews (userid, gameid, content, rating, date_posted)
        VALUES (?, ?, ?, ?, NOW())
    ");
    $stmt->execute([$_SESSION['user']['id'], $gameId, $content, $rating]);
    
    $response = [
        'success' => true,
        'message' => 'Reseña guardada exitosamente',
        'reviewid' => $pdo->lastInsertId()
    ];
    
} catch (Exception $e) {
    http_response_code($e->getCode() ?: 400);
    $response['message'] = $e->getMessage();
    error_log("Review error: " . $e->getMessage());
}

// Always return JSON for consistency
header('Content-Type: application/json');
echo json_encode($response);
?>