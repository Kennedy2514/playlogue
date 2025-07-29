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
<html>
<head>
    <title>Playlogue - Iniciar sesión</title>
    <!-- PUEDES MODIFICAR: Agregar CSS o meta etiquetas si lo necesitas -->
</head>
<body>
    <h1>Iniciar sesión</h1>
    
    <?php if ($error): ?>
        <!-- PUEDES MODIFICAR: Estilos del mensaje de error -->
        <p><strong>Error:</strong> <?= htmlspecialchars($error) ?></p>
    <?php endif; ?>
    
    <!-- PUEDES MODIFICAR: Estilos y estructura del formulario, pero NO los names ni el action -->
    <form action="api/login.php" method="POST">
        <input type="text" name="username" placeholder="Nombre de usuario" required><br>
        <input type="password" name="password" placeholder="Contraseña" required><br>
        <button type="submit">Iniciar sesión</button>
    </form>
    
    <!-- PUEDES MODIFICAR: Estilos y texto del enlace de registro -->
    <p>¿No tienes cuenta? <a href="register_form.php">Regístrate aquí</a></p>
</body>
</html>