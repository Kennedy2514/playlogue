<?php
session_start();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Playlogue - Inicio</title>
</head>
<body>

    <h1>Bienvenido a Playlogue 👾</h1>

    <?php if (isset($_SESSION['user'])): ?>
        <p>Hola, <?= htmlspecialchars($_SESSION['user']) ?>!</p>
        <a href="logout.php">Cerrar sesión</a>
    <?php else: ?>
        <p><a href="login_form.php">Iniciar sesión</a> | <a href="register_form.php">Registrarse</a></p>
    <?php endif; ?>

    <hr>

    <h2>Contenido Público</h2>
    <p>Esta parte del sitio siempre es visible, iniciar sesión es opcional.</p>

</body>
</html>
