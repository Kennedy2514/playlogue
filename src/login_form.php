<?php
session_start();
// --- NO TOCAR: Redirección si ya hay sesión iniciada ---
if (isset($_SESSION['user'])) {
    header('Location: index.php');
    exit;
}

// --- NO TOCAR: Manejo de errores de login ---
$error = $_SESSION['login_error'] ?? null;
unset($_SESSION['login_error']);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Playlogue - Iniciar sesión</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
    <div class="login-container">
        <h1>PLAYLOGUE</h1>

        <!-- Botones sociales -->
        <?php if ($error): ?>
            <p class="error-msg"><strong>Error:</strong> <?= htmlspecialchars($error) ?></p>
        <?php endif; ?>

        <!-- Formulario de login -->
        <form class="login-form" action="api/login.php" method="POST">
            <label for="username">Usuario</label>
            <input type="text" name="username" id="username" placeholder="Ingresa tu nombre de usuario..." required>

            <label for="password">Contraseña</label>
            <input type="password" name="password" id="password" placeholder="Contraseña" required>

            <button type="submit">Iniciar sesión</button>
        </form>

        <!-- Enlaces secundarios -->
        <p class="link"><a href="#">¿Olvidaste tu contraseña?</a></p>
        <p class="link">¿No tienes cuenta? <a href="register_form.php">Registrate
