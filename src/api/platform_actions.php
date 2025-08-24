<?php
session_start();
require_once 'connect.php';
$pdo = getDatabaseConnection();
if (!isset($_SESSION['user']) || $_SESSION['user']['username']!=='admin') exit('No tienes permiso');

$action = $_POST['action'] ?? '';

if ($action==='create') {
    $pdo->prepare("INSERT INTO platform (name) VALUES (:name)")->execute([':name'=>$_POST['name']]);
}
if ($action==='update') {
    $pdo->prepare("UPDATE platform SET name=:name WHERE platformid=:id")
        ->execute([':name'=>$_POST['name'], ':id'=>$_POST['platformid']]);
}
if ($action==='delete') {
    $pdo->prepare("DELETE FROM game_platform WHERE platformid=:id")->execute([':id'=>$_POST['platformid']]);
    $pdo->prepare("DELETE FROM platform WHERE platformid=:id")->execute([':id'=>$_POST['platformid']]);
}
header("Location: ../admin_panel.php");
exit;
