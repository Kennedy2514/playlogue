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

<!-- ==========================================
     FRONTEND SECTION - SAFE TO MODIFY
     ========================================== -->
     
<!DOCTYPE html>
<html>
<head>
    <!-- FRONTEND: Feel free to modify title and add more stylesheets -->
    <title>Playlogue - Catálogo</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <!-- FRONTEND: Navigation structure can be modified -->
    <header>
        <nav class="center">
            <a href="index.php">Inicio</a> | 
            <a href="favoritos.php">Mis Favoritos</a> | 
            <a href="leaderboards.php">Leaderboards</a>
        </nav>
    </header>

    <!-- FRONTEND: Layout and styling can be modified -->
    <h1>Playlogue</h1>

    <!-- FRONTEND: Login/Register section layout can be modified, but keep PHP logic intact -->
    <?php if (isset($_SESSION['user'])): ?>
        <p>Bienvenido, <?= htmlspecialchars($_SESSION['user']['username']) ?> | 
        <a href="api/logout.php">Cerrar sesión</a></p>
    <?php else: ?>
        <p>¿Ya tienes una cuenta? <a href="login_form.php">Inicia sesión</a> o <a href="register_form.php">Regístrate</a></p>
    <?php endif; ?>

    <hr>

    <!-- FRONTEND: Filter form styling and layout can be modified, but keep form names and values intact -->
    <form method="GET" action="index.php" id="filtersForm" style="margin-bottom: 1rem;">
        <input type="text" name="search" placeholder="Buscar juegos..." value="<?= htmlspecialchars($search) ?>" />
        
        <fieldset style="display:inline-block; margin-left: 1rem;">
            <legend>Plataformas</legend>
            <?php foreach ($allPlatforms as $platform): ?>
                <label>
                    <input type="checkbox" name="platform[]" value="<?= $platform['platformid'] ?>" 
                        <?= in_array($platform['platformid'], $filterPlatforms) ? 'checked' : '' ?>>
                    <?= htmlspecialchars($platform['name']) ?>
                </label>
            <?php endforeach; ?>
        </fieldset>

        <fieldset style="display:inline-block; margin-left: 1rem;">
            <legend>Géneros</legend>
            <?php foreach ($allGenres as $genre): ?>
                <label>
                    <input type="checkbox" name="genre[]" value="<?= $genre['genreid'] ?>" 
                        <?= in_array($genre['genreid'], $filterGenres) ? 'checked' : '' ?>>
                    <?= htmlspecialchars($genre['name']) ?>
                </label>
            <?php endforeach; ?>
        </fieldset>

        <label style="margin-left: 1rem;">
            Ordenar por:
            <select name="order">
                <option value="title" <?= $orderBy === 'title' ? 'selected' : '' ?>>Nombre</option>
                <option value="release_date" <?= $orderBy === 'release_date' ? 'selected' : '' ?>>Año de lanzamiento</option>
            </select>
        </label>

        <button type="submit" style="margin-left: 1rem;">Filtrar</button>
    </form>

    <!-- FRONTEND: Table structure can be modified, but keep PHP data output intact -->
    <table>
        <thead>
            <tr>
                <th>Título</th>
                <th>Año de lanzamiento</th>
                <th>Plataformas</th>
                <th>Géneros</th>
                <th>Rating</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($game = $stmt->fetch()): 
                $platforms = !empty($game['platforms']) ? $game['platforms'] : 'N/A';
                $genres = !empty($game['genres']) ? $game['genres'] : 'N/A';

                $ratingDisplay = 'Sin reseñas';
                if ($game['avg_rating'] !== null && $game['review_count'] > 0) {
                    $stars = str_repeat('★', floor($game['avg_rating']));
                    if ($game['avg_rating'] - floor($game['avg_rating']) >= 0.5) {
                        $stars .= '☆';
                    }
                    $ratingDisplay = $stars . ' (' . $game['avg_rating'] . '/5)';
                }
            ?>
            <tr class="game-row" 
                onclick="openGameModal(
                    <?= $game['gameid'] ?>, 
                    '<?= htmlspecialchars($game['title'], ENT_QUOTES) ?>', 
                    '<?= htmlspecialchars($game['cover'] ?: '', ENT_QUOTES) ?>', 
                    '<?= htmlspecialchars($platforms, ENT_QUOTES) ?>', 
                    '<?= htmlspecialchars($genres, ENT_QUOTES) ?>', 
                    '<?= $ratingDisplay ?>'
                )">
                <td><?= htmlspecialchars($game['title']) ?></td>
                <td><?= date('Y', strtotime($game['release_date'])) ?></td>
                <td><?= htmlspecialchars($platforms) ?></td>
                <td><?= htmlspecialchars($genres) ?></td>
                <td><?= $ratingDisplay ?></td>
            </tr>
            <?php endwhile; ?>
        </tbody>
    </table>

    <!-- FRONTEND: Pagination styling can be modified -->
    <div>
        <?php
        $totalPages = ceil($totalGames / $gamesPerPage);
        $queryString = $_GET;
        unset($queryString['page']);
        $baseUrl = strtok($_SERVER["REQUEST_URI"], '?');

        function buildPageUrl($pageNum, $queryParams, $baseUrl) {
            $queryParams['page'] = $pageNum;
            return $baseUrl . '?' . http_build_query($queryParams);
        }
        ?>

        <?php if ($currentPage > 1): ?>
            <a href="<?= buildPageUrl($currentPage - 1, $queryString, $baseUrl) ?>">Anterior</a>
        <?php endif; ?>

        <span>Página <?= $currentPage ?> de <?= $totalPages ?></span>

        <?php if ($currentPage < $totalPages): ?>
            <a href="<?= buildPageUrl($currentPage + 1, $queryString, $baseUrl) ?>">Siguiente</a>
        <?php endif; ?>
    </div>

    <!-- FRONTEND: Modal structure and styling can be modified, but keep IDs and data attributes intact -->
    <div id="gameModal" class="modal">
        <div class="modal-content">
            <span class="close-modal" onclick="closeGameModal()">&times;</span>

            <div class="modal-left">
                <img id="gameCover" class="game-cover" src="" alt="Game Cover">
                <div class="game-info">
                    <h2 id="gameTitle"></h2>
                    <p><strong>Plataformas:</strong> <span id="gamePlatforms"></span></p>
                    <p><strong>Géneros:</strong> <span id="gameGenres"></span></p>
                    <p><strong>Rating:</strong> <span id="gameRating"></span></p>
                    <button id="favoriteBtn" >Cargando...</button>
                </div>
            </div>

            <div class="modal-right">
                <h3>Reseñas</h3>
                <div id="reviewsContainer">
                    <div class="no-reviews">Cargando reseñas...</div>
                </div>

                <?php if (isset($_SESSION['user'])): ?>
                <div class="new-review-form">
                    <h3>Añadir tu reseña</h3>
                    <form id="newReviewForm">
                        <input type="hidden" id="reviewGameId" name="gameid">

                        <div class="form-group">
                            <label for="reviewContent">Tu reseña:</label>
                            <textarea id="reviewContent" name="content" placeholder="Escribe tu reseña (mínimo 10 caracteres)" required></textarea>
                        </div>

                        <div class="form-group">
                            <label for="reviewRating">Calificación:</label>
                            <select id="reviewRating" name="rating" required>
                                <option value="">Selecciona calificación</option>
                                <option value="1">1★</option>
                                <option value="2">2★</option>
                                <option value="3">3★</option>
                                <option value="4">4★</option>
                                <option value="5">5★</option>
                            </select>
                        </div>

                        <button type="submit" class="submit-review-btn">Enviar Reseña</button>
                    </form>
                </div>
                <?php else: ?>
                <div class="new-review-form">
                    <p>Para dejar una reseña, <a href="login_form.php">inicia sesión</a> o <a href="register_form.php">regístrate</a>.</p>
                </div>
                <?php endif; ?>
            </div>
        </div>
    </div>

    <!-- FRONTEND: Feel free to add more JavaScript files or modify existing ones -->
    <script src="js/script.js"></script>
</body>
</html>
