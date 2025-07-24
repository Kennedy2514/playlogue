<?php
session_start();
$pdo = require 'connect.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username']);
    $email    = trim($_POST['email']);
    $password = $_POST['password'];

    // Hash that thang
    $hash = password_hash($password, PASSWORD_DEFAULT);

    try {
        $stmt = $pdo->prepare("INSERT INTO users (username, email, password) VALUES (?, ?, ?)");
        $stmt->execute([$username, $email, $hash]);
        echo "🎉 Registration successful. <a href='login_form.php'>Log in now</a>";
    } catch (PDOException $e) {
        echo "❌ Registration failed: " . $e->getMessage();
    }
}
