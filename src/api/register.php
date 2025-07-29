<?php
session_start();
require 'connect.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    $_SESSION['register_error'] = "Método no permitido";
    header('Location: /register_form.php');
    exit;
}

$username = trim($_POST['username']);
$email = trim($_POST['email']);
$password = $_POST['password'];

// Validaciones
if (strlen($username) < 3 || !preg_match('/^\w+$/', $username)) {
    $_SESSION['register_error'] = "Usuario inválido (3+ caracteres, solo letras/números/_)";
    header('Location: /register_form.php');
    exit;
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $_SESSION['register_error'] = "Correo electrónico inválido";
    header('Location: /register_form.php');
    exit;
}

if (strlen($password) < 8) {
    $_SESSION['register_error'] = "La contraseña debe tener 8+ caracteres";
    header('Location: /register_form.php');
    exit;
}

try {
    $pdo = getDatabaseConnection();
    
    // Verificar usuario existente
    $stmt = $pdo->prepare("SELECT 1 FROM users WHERE username = ? OR email = ?");
    $stmt->execute([$username, $email]);
    
    if ($stmt->fetch()) {
        $_SESSION['register_error'] = "El usuario/correo ya existe";
        header('Location: /register_form.php');
        exit;
    }
    
    // Registrar usuario
    $hash = password_hash($password, PASSWORD_DEFAULT);
    $stmt = $pdo->prepare("INSERT INTO users (username, email, password) VALUES (?, ?, ?)");
    $stmt->execute([$username, $email, $hash]);
    
    // Autologin
    $_SESSION['user'] = [
        'id' => $pdo->lastInsertId(),
        'username' => $username
    ];
    
    header('Location: /index.php');

} catch (PDOException $e) {
    error_log("Error de registro: " . $e->getMessage());
    $_SESSION['register_error'] = "Error en el servidor. Por favor intente más tarde.";
    header('Location: /register_form.php');
}