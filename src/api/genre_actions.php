<?php
session_start();
require_once 'connect.php';
$pdo = getDatabaseConnection();
if (!isset($_SESSION['user']) || $_SESSION['user']['username']!=='admin') exit('No tienes permiso');

$action = $_POST['action'] ?? '';

if ($action==='create') {
    $pdo->prepare("INSERT INTO genres (name) VALUES (:name)")->execute([':name'=>$_POST['name']]);
}
if ($action==='update') {
    $pdo->prepare("UPDATE genres SET name=:name WHERE genreid=:id")
        ->execute([':name'=>$_POST['name'], ':id'=>$_POST['genreid']]);
}
if ($action==='delete') {
    $pdo->prepare("DELETE FROM game_genre WHERE genreid=:id")->execute([':id'=>$_POST['genreid']]);
    $pdo->prepare("DELETE FROM genres WHERE genreid=:id")->execute([':id'=>$_POST['genreid']]);
}
header("Location: ../admin_panel.php");
exit;
