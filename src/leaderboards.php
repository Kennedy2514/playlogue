<?php
session_start();
require_once 'api/connect.php';

// --- NO TOCAR: Lógica de conexión y consulta de leaderboard ---
$gamesPerPage = 10;  // Top 10 fijo
$currentPage = 1;    // Leaderboard sin paginación
$offset = 0;

try {
    $pdo = getDatabaseConnection();

    // --- NO TOCAR: Consulta principal para obtener el top 10 de juegos mejor valorados ---
    $stmt = $pdo->prepare("
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
        GROUP BY g.gameid, g.title, g.release_date, g.cover
        HAVING COUNT(r.reviewid) > 0
        ORDER BY avg_rating DESC
        LIMIT :limit OFFSET :offset
    ");
    $stmt->bindValue(':limit', $gamesPerPage, PDO::PARAM_INT);
    $stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
    $stmt->execute();
    
    $topGames = $stmt->fetchAll();

} catch (PDOException $e) {
    die("Error loading leaderboard: " . $e->getMessage());
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Playlogue - Leaderboard</title>
    <link rel="stylesheet" href="/css/estilos.css"> <!-- PUEDES MODIFICAR: Ruta y estilos del CSS -->
</head>
<body>
<header class="navbar">
    <div class="nav-left">
        <h1>PLAYLOGUE</h1>
    </div>

    <nav class="nav-center">
        <a href="index.php">Inicio</a>
        <a href="favoritos.php">Mis Favoritos</a>
        <a href="leaderboards.php">Leaderboards</a>
        <?php if (isset($_SESSION['user']) && $_SESSION['user']['username'] === 'admin'): ?>
            <a href="admin_panel.php">Panel de administración</a>
        <?php endif; ?>
    </nav>

    <div class="nav-right">
        <?php if (isset($_SESSION['user'])): ?>
            <span>Bienvenido, <?= htmlspecialchars($_SESSION['user']['username']) ?></span>
            <a href="api/logout.php">Cerrar sesión</a>
        <?php else: ?>
            <a href="login_form.php">Inicia sesión</a>
            <a href="register_form.php">Regístrate</a>
        <?php endif; ?>
    </div>  
    
</header>
<!-- BANNER AREA -->
<?php
// Traer juegos que tengan al menos una reseña
$bannerGames = $pdo->query("
    SELECT g.gameid, g.title, g.cover, ROUND(AVG(r.rating),1) as avg_rating, COUNT(r.reviewid) as review_count
    FROM games g
    INNER JOIN reviews r ON g.gameid = r.gameid
    GROUP BY g.gameid, g.title, g.cover
    ORDER BY avg_rating DESC
    LIMIT 5

")->fetchAll(PDO::FETCH_ASSOC);
?>

<div class="banner-carousel">
    <?php foreach ($bannerGames as $index => $game): ?>
        <div class="carousel-slide <?= $index === 0 ? 'active' : '' ?>">
            <img src="<?= htmlspecialchars($game['cover']) ?>" alt="<?= htmlspecialchars($game['title']) ?>">
        </div>
    <?php endforeach; ?>

    <!-- Controles -->
    <button class="prev">&#10094;</button>
    <button class="next">&#10095;</button>
</div>
<!-- BANNER AREA TERMINA -->
<br>
<br>
<br>
<br>
<br>
<br>


<h1>Top 10 Juegos Mejor Valorados</h1>

<?php if (count($topGames) === 0): ?>
    <p>No hay juegos disponibles para mostrar.</p>
<?php else: ?>
    <div class="games-portfolio">
        <?php foreach ($topGames as $game):
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
        <div class="game-card" 
             onclick="openGameModal(
                 <?= $game['gameid'] ?>, 
                 '<?= addslashes($game['title']) ?>', 
                 '<?= addslashes($game['cover'] ?: 'default-cover.jpg') ?>', 
                 '<?= addslashes($platforms) ?>', 
                 '<?= addslashes($genres) ?>', 
                 '<?= addslashes($ratingDisplay) ?>'
             )">
            <img src="<?= htmlspecialchars($game['cover'] ?: 'default-cover.jpg', ENT_QUOTES) ?>" alt="<?= htmlspecialchars($game['title'], ENT_QUOTES) ?>">
            <div class="game-info-overlay">
                <h3><?= htmlspecialchars($game['title']) ?></h3>
                <p><strong>Año:</strong> <?= date('Y', strtotime($game['release_date'])) ?></p>
                <p><strong>Plataformas:</strong> <?= htmlspecialchars($platforms) ?></p>
                <p><strong>Géneros:</strong> <?= htmlspecialchars($genres) ?></p>
                <p><strong>Rating:</strong> <?= $ratingDisplay ?></p>
            </div>
        </div>
        <?php endforeach; ?>
    </div>
<?php endif; ?>

<!-- PUEDES MODIFICAR: Estructura y estilos del modal, pero NO los IDs ni nombres de clases usados por JS -->
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

<!-- FOOTER -->
<footer class="site-footer">
    <div class="footer-logo">Playlogue</div>
    <div class="footer-info">
        <p>© 2025 Playlogue. Todos los derechos reservados.</p>
        <p>
            <a href="#">Términos</a> | 
            <a href="#">Privacidad</a> | 
            <a href="#">Contacto</a>
        </p>
        <div class="footer-note">Diseñado con ❤️ por tu equipo</div>
    </div>
</footer>

<!-- PUEDES MODIFICAR: Puedes cambiar la ruta si mueves el JS, pero NO el nombre del archivo ni su funcionalidad -->
<script src="js/script.js"></script>
</body>
</html>
