<?php
$host = 'playlogue_db';
$port = '5432';
$dbname = 'playlogue';
$user = 'admin';
$password = 'aromero12!';

$dsn = "pgsql:host=$host;port=$port;dbname=$dbname";

try {
    $pdo = new PDO($dsn, $user, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    return $pdo;
} catch (PDOException $e) {
    die("💀 falló la conexión a la base de datos");
}
?>