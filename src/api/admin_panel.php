<?php
session_start();
require_once 'connect.php';
$pdo = getDatabaseConnection();

// Only admin
if (!isset($_SESSION['user']) || $_SESSION['user']['username'] !== 'admin') {
    echo "No tienes permiso para ver esta página. <a href=/index.php>Volver</a>";
    exit;
}

// Load all data
$allPlatforms = $pdo->query("SELECT platformid, name FROM platform ORDER BY name")->fetchAll(PDO::FETCH_ASSOC);
$allGenres = $pdo->query("SELECT genreid, name FROM genres ORDER BY name")->fetchAll(PDO::FETCH_ASSOC);
$allGames = $pdo->query("SELECT gameid, title, release_date FROM games ORDER BY title")->fetchAll(PDO::FETCH_ASSOC);
?>