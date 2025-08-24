<?php
session_start();
require_once 'connect.php';
$pdo = getDatabaseConnection();

if (!isset($_SESSION['user']) || $_SESSION['user']['username'] !== 'admin') exit('No tienes permiso');

$action = $_POST['action'] ?? '';

if ($action==='create') {
    $title = $_POST['title'];
    $release_date = $_POST['release_date'];
    $genres = $_POST['genres'] ?? [];
    $platforms = $_POST['platforms'] ?? [];

    $pdo->beginTransaction();
    $stmt = $pdo->prepare("INSERT INTO games (title, release_date) VALUES (:title, :release_date) RETURNING gameid");
    $stmt->execute([':title'=>$title, ':release_date'=>$release_date]);
    $gameid = $stmt->fetchColumn();

    $stmt = $pdo->prepare("INSERT INTO game_genre (gameid, genreid) VALUES (:gameid, :genreid)");
    foreach($genres as $g) $stmt->execute([':gameid'=>$gameid, ':genreid'=>$g]);

    $stmt = $pdo->prepare("INSERT INTO game_platform (gameid, platformid) VALUES (:gameid, :pid)");
    foreach($platforms as $p) $stmt->execute([':gameid'=>$gameid, ':pid'=>$p]);
    $pdo->commit();
    header("Location: ../admin_panel.php"); exit;
}

if ($action==='update') {
    $gameid = (int)$_POST['gameid'];
    $title = $_POST['title'];
    $release_date = $_POST['release_date'];
    $genres = $_POST['genres'] ?? [];
    $platforms = $_POST['platforms'] ?? [];

    $pdo->beginTransaction();
    $pdo->prepare("UPDATE games SET title=:title, release_date=:date WHERE gameid=:id")
        ->execute([':title'=>$title, ':date'=>$release_date, ':id'=>$gameid]);

    $pdo->prepare("DELETE FROM game_genre WHERE gameid=:id")->execute([':id'=>$gameid]);
    $stmt = $pdo->prepare("INSERT INTO game_genre (gameid, genreid) VALUES (:id, :gid)");
    foreach($genres as $g) $stmt->execute([':id'=>$gameid, ':gid'=>$g]);

    $pdo->prepare("DELETE FROM game_platform WHERE gameid=:id")->execute([':id'=>$gameid]);
    $stmt = $pdo->prepare("INSERT INTO game_platform (gameid, platformid) VALUES (:id, :pid)");
    foreach($platforms as $p) $stmt->execute([':id'=>$gameid, ':pid'=>$p]);
    $pdo->commit();
    header("Location: ../admin_panel.php"); exit;
}

if ($action==='delete') {
    $gameid = (int)$_POST['gameid'];
    $pdo->prepare("DELETE FROM game_genre WHERE gameid=:id")->execute([':id'=>$gameid]);
    $pdo->prepare("DELETE FROM game_platform WHERE gameid=:id")->execute([':id'=>$gameid]);
    $pdo->prepare("DELETE FROM games WHERE gameid=:id")->execute([':id'=>$gameid]);
    header("Location: ../admin_panel.php"); exit;
}
