<?php
session_start();
require 'connect.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    $_SESSION['login_error'] = 'Método no permitido';
    header('Location: /login_form.php');
    exit;
}

$username = trim($_POST['username']);
$password = $_POST['password'];

// Basic validation
if (empty($username) || empty($password)) {
    $_SESSION['login_error'] = 'Usuario y contraseña requeridos';
    header('Location: /login_form.php');
    exit;
}

try {
    $pdo = getDatabaseConnection();

    $stmt = $pdo->prepare("SELECT userid, username, password FROM users WHERE username = ?");
    $stmt->execute([$username]);
    $user = $stmt->fetch();

    if ($user && password_verify($password, $user['password'])) {
        // Successful login
        $_SESSION['user'] = [
            'id' => $user['userid'],
            'username' => $user['username']
        ];
        header('Location: /index.php');
    } else {
        // Failed login (same message to prevent user enumeration)
        $_SESSION['login_error'] = 'Usuario o contraseña incorrectos';
        header('Location: /login_form.php');
    }
} catch (PDOException $e) {
    error_log("Login error: " . $e->getMessage());
    $_SESSION['login_error'] = 'Error en el sistema. Intente más tarde.';
    header('Location: /login_form.php');
}
exit;