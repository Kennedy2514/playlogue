<?php
/* ==========================================
   BACKEND CONFIGURATION - DO NOT MODIFY 
   ========================================== */
session_start();
require_once 'api/connect.php';

/* BACKEND: Database filters and query parameters */
$search = isset($_GET['search']) ? trim($_GET['search']) : '';
$filterPlatforms = isset($_GET['platform']) ? (array)$_GET['platform'] : [];
$filterGenres = isset($_GET['genre']) ? (array)$_GET['genre'] : [];
$orderBy = isset($_GET['order']) && in_array($_GET['order'], ['title', 'release_date']) ? $_GET['order'] : 'title';

/* BACKEND: Pagination configuration */
$gamesPerPage = 20;
$currentPage = isset($_GET['page']) ? max((int)$_GET['page'], 1) : 1;
$offset = ($currentPage - 1) * $gamesPerPage;

/* BACKEND: Database operations - DO NOT MODIFY */
try {
    $pdo = getDatabaseConnection();
    $allPlatforms = $pdo->query("SELECT platformid, name FROM platform ORDER BY name")->fetchAll(PDO::FETCH_ASSOC);
    $allGenres = $pdo->query("SELECT genreid, name FROM genres ORDER BY name")->fetchAll(PDO::FETCH_ASSOC);

    $whereClauses = [];
    $params = [];

    if ($search !== '') {
        $whereClauses[] = "LOWER(g.title) LIKE :search";
        $params[':search'] = '%' . strtolower($search) . '%';
    }

    if (!empty($filterPlatforms)) {
        $placeholders = [];
        foreach ($filterPlatforms as $idx => $pid) {
            $key = ":platform$idx";
            $placeholders[] = $key;
            $params[$key] = $pid;
        }
        $whereClauses[] = "g.gameid IN (
            SELECT gp.gameid FROM game_platform gp WHERE gp.platformid IN (" . implode(',', $placeholders) . ")
        )";
    }

    if (!empty($filterGenres)) {
        $placeholders = [];
        foreach ($filterGenres as $idx => $gid) {
            $key = ":genre$idx";
            $placeholders[] = $key;
            $params[$key] = $gid;
        }
        $whereClauses[] = "g.gameid IN (
            SELECT gg.gameid FROM game_genre gg WHERE gg.genreid IN (" . implode(',', $placeholders) . ")
        )";
    }

    $whereSQL = '';
    if (!empty($whereClauses)) {
        $whereSQL = "WHERE " . implode(' AND ', $whereClauses);
    }

    $countStmt = $pdo->prepare("SELECT COUNT(DISTINCT g.gameid) FROM games g $whereSQL");
    $countStmt->execute($params);
    $totalGames = (int)$countStmt->fetchColumn();

    $sql = "
        SELECT 
            g.gameid, 
            g.title, 
            g.release_date,
            g.cover,
            STRING_AGG(DISTINCT p.name, ', ' ORDER BY p.name) as platforms,
            STRING_AGG(DISTINCT gn.name, ', ' ORDER BY gn.name) as genres,
            ROUND(AVG(r.rating), 1) as avg_rating,
            COUNT(r.reviewid) as review_count
        FROM games g
        LEFT JOIN game_platform gp ON g.gameid = gp.gameid
        LEFT JOIN platform p ON gp.platformid = p.platformid
        LEFT JOIN game_genre gg ON g.gameid = gg.gameid
        LEFT JOIN genres gn ON gg.genreid = gn.genreid
        LEFT JOIN reviews r ON g.gameid = r.gameid
        $whereSQL
        GROUP BY g.gameid, g.title, g.release_date, g.cover
        ORDER BY $orderBy
        LIMIT :limit OFFSET :offset
    ";

    $stmt = $pdo->prepare($sql);
    foreach ($params as $key => $value) {
        $stmt->bindValue($key, $value);
    }
    $stmt->bindValue(':limit', $gamesPerPage, PDO::PARAM_INT);
    $stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
    $stmt->execute();

} catch (PDOException $e) {
    error_log("Database error in index.php with filters: " . $e->getMessage());
    echo "<p class='error-msg'>Hubo un error al cargar tus juegos. 😓 Intenta más tarde.</p>";
}
?>