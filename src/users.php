<?php
$pdo = include 'connect.php';

$stmt = $pdo->query('SELECT * FROM users');
$users = $stmt->fetchAll();

foreach ($users as $user) {
    echo "<p>{$user['username']} - {$user['email']}</p>";
}