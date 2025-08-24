<?php 
include 'api/admin_panel.php'
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Panel Admin</title>
<link rel="stylesheet" href="/css/estilos.css">
<style>
/* Admin-specific styles.
    We make them more specific by prefixing them with `#admin-container`
    to ensure they override the main stylesheet. 
*/
#admin-container {
    padding: 20px;
}

#admin-container .tabs, 
#admin-container .subtabs {
    display: flex;
    gap: 10px;
    margin-bottom: 15px;
    flex-wrap: wrap; /* To prevent overflow on smaller screens */
}

#admin-container .tab, 
#admin-container .subtab {
    padding: 10px 15px;
    background: #0a264d;
    border-radius: 6px;
    cursor: pointer;
    transition: 0.2s;
    user-select: none;
    color: white;
}

#admin-container .tab.active, 
#admin-container .subtab.active {
    background: #1c9eff;
    color: #fff;
}

#admin-container .section, 
#admin-container .subsection {
    display: none;
    background-color: #0a264d;
    padding: 20px;
    border-radius: 10px;
}

#admin-container .section.active, 
#admin-container .subsection.active {
    display: block;
}

#admin-container form {
    margin: 15px 0;
}

#admin-container input[type="text"], 
#admin-container input[type="date"], 
#admin-container select {
    margin: 5px;
    padding: 10px;
    border-radius: 8px;
    border: 1px solid #1c9eff;
    background-color: #061e3b;
    color: white;
    outline: none;
}

#admin-container button[type="submit"] {
    margin: 5px;
    padding: 10px 20px;
    border-radius: 8px;
    background-color: #1c9eff;
    border: none;
    cursor: pointer;
    font-weight: bold;
    color: white;
    transition: background-color 0.2s ease;
}

#admin-container button[type="submit"]:hover {
    background-color: #007bff;
}

#admin-container .chip {
    display: inline-block;
    padding: 5px 10px;
    margin: 3px;
    border-radius: 20px;
    background: #061e3b;
    cursor: pointer;
    transition: 0.2s;
    user-select: none;
    color: white;
    border: 1px solid transparent;
}

#admin-container .chip input {
    display: none;
}

#admin-container .chip input:checked + span {
    background: #1c9eff;
    color: #fff;
    font-weight: bold;
}

#admin-container .chip-scroll {
    display: flex;
    flex-wrap: wrap;
    max-height: 150px;
    overflow-y: auto;
}
</style>
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
<main id="admin-container">
    <h1 style="color: white; margin-top: 20px;">Panel de Administración de Playlogue</h1>

    <div class="tabs">
        <div class="tab active" data-target="platforms">Plataformas</div>
        <div class="tab" data-target="genres">Géneros</div>
        <div class="tab" data-target="games">Juegos</div>
    </div>

    <div id="platforms" class="section active">
        <div class="subtabs">
            <div class="subtab active" data-target="platforms-create">Crear</div>
            <div class="subtab" data-target="platforms-update">Modificar</div>
            <div class="subtab" data-target="platforms-delete">Eliminar</div>
        </div>

        <div id="platforms-create" class="subsection active">
            <form method="POST" action="api/platform_actions.php">
                <input type="hidden" name="action" value="create">
                <input type="text" name="name" placeholder="Nombre de plataforma" required>
                <button type="submit">Añadir</button>
            </form>
        </div>

        <div id="platforms-update" class="subsection">
            <form method="POST" action="api/platform_actions.php">
                <input type="hidden" name="action" value="update">
                <select name="platformid" required>
                    <option value="">-- Selecciona plataforma --</option>
                    <?php foreach($allPlatforms as $p): ?>
                        <option value="<?= $p['platformid'] ?>"><?= htmlspecialchars($p['name']) ?></option>
                    <?php endforeach; ?>
                </select>
                <input type="text" name="name" placeholder="Nuevo nombre" required>
                <button type="submit">Modificar</button>
            </form>
        </div>

        <div id="platforms-delete" class="subsection">
            <form method="POST" action="api/platform_actions.php" onsubmit="return confirm('¿Seguro que quieres eliminar esta plataforma?')">
                <input type="hidden" name="action" value="delete">
                <select name="platformid" required>
                    <option value="">-- Selecciona plataforma --</option>
                    <?php foreach($allPlatforms as $p): ?>
                        <option value="<?= $p['platformid'] ?>"><?= htmlspecialchars($p['name']) ?></option>
                    <?php endforeach; ?>
                </select>
                <button type="submit">Eliminar</button>
            </form>
        </div>
    </div>

    <div id="genres" class="section">
        <div class="subtabs">
            <div class="subtab active" data-target="genres-create">Crear</div>
            <div class="subtab" data-target="genres-update">Modificar</div>
            <div class="subtab" data-target="genres-delete">Eliminar</div>
        </div>

        <div id="genres-create" class="subsection active">
            <form method="POST" action="api/genre_actions.php">
                <input type="hidden" name="action" value="create">
                <input type="text" name="name" placeholder="Nombre de género" required>
                <button type="submit">Añadir</button>
            </form>
        </div>

        <div id="genres-update" class="subsection">
            <form method="POST" action="api/genre_actions.php">
                <input type="hidden" name="action" value="update">
                <select name="genreid" required>
                    <option value="">-- Selecciona género --</option>
                    <?php foreach($allGenres as $g): ?>
                        <option value="<?= $g['genreid'] ?>"><?= htmlspecialchars($g['name']) ?></option>
                    <?php endforeach; ?>
                </select>
                <input type="text" name="name" placeholder="Nuevo nombre" required>
                <button type="submit">Modificar</button>
            </form>
        </div>

        <div id="genres-delete" class="subsection">
            <form method="POST" action="api/genre_actions.php" onsubmit="return confirm('¿Seguro que quieres eliminar este género?')">
                <input type="hidden" name="action" value="delete">
                <select name="genreid" required>
                    <option value="">-- Selecciona género --</option>
                    <?php foreach($allGenres as $g): ?>
                        <option value="<?= $g['genreid'] ?>"><?= htmlspecialchars($g['name']) ?></option>
                    <?php endforeach; ?>
                </select>
                <button type="submit">Eliminar</button>
            </form>
        </div>
    </div>

    <div id="games" class="section">
        <div class="subtabs">
            <div class="subtab active" data-target="games-create">Crear</div>
            <div class="subtab" data-target="games-update">Modificar</div>
            <div class="subtab" data-target="games-delete">Eliminar</div>
        </div>

        <div id="games-create" class="subsection active">
            <form method="POST" action="api/game_actions.php">
                <input type="hidden" name="action" value="create">
                <input type="text" name="title" placeholder="Título" required>
                <input type="date" name="release_date" required>

                <h4>Géneros</h4>
                <div class="chip-scroll">
                    <?php foreach($allGenres as $g): ?>
                        <label class="chip">
                            <input type="checkbox" name="genres[]" value="<?= $g['genreid'] ?>">
                            <span><?= htmlspecialchars($g['name']) ?></span>
                        </label>
                    <?php endforeach; ?>
                </div>

                <h4>Plataformas</h4>
                <div class="chip-scroll">
                    <?php foreach($allPlatforms as $p): ?>
                        <label class="chip">
                            <input type="checkbox" name="platforms[]" value="<?= $p['platformid'] ?>">
                            <span><?= htmlspecialchars($p['name']) ?></span>
                        </label>
                    <?php endforeach; ?>
                </div>

                <button type="submit">Añadir juego</button>
            </form>
        </div>

        <div id="games-update" class="subsection">
            <form method="POST" action="api/game_actions.php" id="updateGameForm">
                <input type="hidden" name="action" value="update">

                <select id="gameSelect" name="gameid" required>
                    <option value="">-- Selecciona juego --</option>
                    <?php foreach($allGames as $g): ?>
                        <option value="<?= $g['gameid'] ?>"><?= htmlspecialchars($g['title']) ?></option>
                    <?php endforeach; ?>
                </select>

                <input type="text" name="title" id="gameTitle" placeholder="Nuevo título" required>
                <input type="date" name="release_date" id="gameRelease" required>

                <h4>Géneros</h4>
                <div class="chip-scroll" id="genreChips">
                    <?php foreach($allGenres as $g): ?>
                        <label class="chip">
                            <input type="checkbox" name="genres[]" value="<?= $g['genreid'] ?>" data-genre="<?= $g['genreid'] ?>">
                            <span><?= htmlspecialchars($g['name']) ?></span>
                        </label>
                    <?php endforeach; ?>
                </div>

                <h4>Plataformas</h4>
                <div class="chip-scroll" id="platformChips">
                    <?php foreach($allPlatforms as $p): ?>
                        <label class="chip">
                            <input type="checkbox" name="platforms[]" value="<?= $p['platformid'] ?>" data-platform="<?= $p['platformid'] ?>">
                            <span><?= htmlspecialchars($p['name']) ?></span>
                        </label>
                    <?php endforeach; ?>
                </div>

                <button type="submit">Modificar juego</button>
            </form>
        </div>

        <div id="games-delete" class="subsection">
            <form method="POST" action="api/game_actions.php" onsubmit="return confirm('¿Seguro que quieres eliminar este juego?')">
                <input type="hidden" name="action" value="delete">
                <select name="gameid" required>
                    <option value="">-- Selecciona juego --</option>
                    <?php foreach($allGames as $g): ?>
                        <option value="<?= $g['gameid'] ?>"><?= htmlspecialchars($g['title']) ?></option>
                    <?php endforeach; ?>
                </select>
                <button type="submit">Eliminar</button>
            </form>
        </div>
    </div>
</main>
<script type="text/javascript">
// Build games data object
const gamesData = {};

<?php
// Fetch all game-genre and game-platform relationships in single queries
$allGameGenres = $pdo->query("SELECT gameid, genreid FROM game_genre")->fetchAll(PDO::FETCH_ASSOC);
$allGamePlatforms = $pdo->query("SELECT gameid, platformid FROM game_platform")->fetchAll(PDO::FETCH_ASSOC);

// Organize them by gameid for easy lookup
$gameGenresMap = [];
foreach ($allGameGenres as $row) {
    $gameGenresMap[$row['gameid']][] = (int)$row['genreid'];
}
$gamePlatformsMap = [];
foreach ($allGamePlatforms as $row) {
    $gamePlatformsMap[$row['gameid']][] = (int)$row['platformid'];
}

foreach ($allGames as $g) {
    $gid = $g['gameid'];
    
    $genreIds = $gameGenresMap[$gid] ?? [];
    $platformIds = $gamePlatformsMap[$gid] ?? [];
    
    echo "gamesData[" . $gid . "] = {";
    echo "title: " . json_encode($g['title']) . ",";
    echo "release_date: " . json_encode($g['release_date']) . ",";
    echo "genres: " . json_encode($genreIds) . ",";
    echo "platforms: " . json_encode($platformIds);
    echo "};\n";
}
?>

// Function to prefill the form
function prefillGameForm(gameId) {
    console.log('Prefilling form for game ID:', gameId);
    
    if (!gameId || !gamesData[gameId]) {
        // Clear form if no game selected or game not found
        document.getElementById('gameTitle').value = '';
        document.getElementById('gameRelease').value = '';
        
        // Uncheck all checkboxes
        document.querySelectorAll('#genreChips input[type="checkbox"]').forEach(cb => cb.checked = false);
        document.querySelectorAll('#platformChips input[type="checkbox"]').forEach(cb => cb.checked = false);
        
        console.log('Form cleared');
        return;
    }
    
    const game = gamesData[gameId];
    console.log('Game data:', game);
    
    // Fill basic fields
    document.getElementById('gameTitle').value = game.title;
    document.getElementById('gameRelease').value = game.release_date;
    
    // First uncheck all checkboxes
    document.querySelectorAll('#genreChips input[type="checkbox"]').forEach(cb => cb.checked = false);
    document.querySelectorAll('#platformChips input[type="checkbox"]').forEach(cb => cb.checked = false);
    
    // Check genre checkboxes
    game.genres.forEach(genreId => {
        const checkbox = document.querySelector(`#genreChips input[data-genre="${genreId}"]`);
        if (checkbox) {
            checkbox.checked = true;
            console.log('Checked genre:', genreId);
        }
    });
    
    // Check platform checkboxes
    game.platforms.forEach(platformId => {
        const checkbox = document.querySelector(`#platformChips input[data-platform="${platformId}"]`);
        if (checkbox) {
            checkbox.checked = true;
            console.log('Checked platform:', platformId);
        }
    });
    
    console.log('Form prefilled successfully');
}

// Add event listener to the game select dropdown
document.addEventListener('DOMContentLoaded', function() {
    const gameSelect = document.getElementById('gameSelect');
    if (gameSelect) {
        gameSelect.addEventListener('change', function() {
            const selectedGameId = this.value;
            prefillGameForm(selectedGameId);
        });
        console.log('Event listener added to game select');
    }
});
</script>

<script>
// Main tabs
document.querySelectorAll('.tab').forEach(tab => {
    tab.addEventListener('click', () => {
        document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
        document.querySelectorAll('.section').forEach(s => s.classList.remove('active'));
        tab.classList.add('active');
        document.getElementById(tab.dataset.target).classList.add('active');
    });
});

// Subtabs
document.querySelectorAll('.subtabs').forEach(container => {
    container.querySelectorAll('.subtab').forEach(st => {
        st.addEventListener('click', () => {
            container.querySelectorAll('.subtab').forEach(s => s.classList.remove('active'));
            container.parentElement.querySelectorAll('.subsection').forEach(ss => ss.classList.remove('active'));
            st.classList.add('active');
            document.getElementById(st.dataset.target).classList.add('active');
        });
    });
});
</script>
</body>
</html>