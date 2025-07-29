<?php
session_start();
// --- NO TOCAR: Redirección si ya hay sesión iniciada ---
if (isset($_SESSION['user'])) {
    header('Location: index.php');
    exit;
}

// --- NO TOCAR: Manejo de errores de registro ---
$error = $_SESSION['register_error'] ?? null;
unset($_SESSION['register_error']); // Limpiar después de mostrar
?>
<!DOCTYPE html>
<html>
<head>
    <title>Registro - Playlogue</title>
    <!-- PUEDES MODIFICAR: Agregar CSS o meta etiquetas si lo necesitas -->
</head>
<body>
    <h1>Regístrate</h1>
    
    <?php if ($error): ?>
        <!-- PUEDES MODIFICAR: Estilos del mensaje de error -->
        <p style="color:red;"><strong>Error:</strong> <?= htmlspecialchars($error) ?></p>
    <?php endif; ?>
    
    <!-- PUEDES MODIFICAR: Estilos y estructura del formulario, pero NO los names ni el action -->
    <form action="api/register.php" method="POST">
        <input type="text" name="username" placeholder="Usuario" required>
        <input type="email" name="email" placeholder="Correo electrónico" required>
        <input type="password" name="password" placeholder="Contraseña" required>
        <button type="submit">Registrarse</button>
    </form>
    
    <!-- PUEDES MODIFICAR: Estilos y texto del enlace de login -->
    <a href="login_form.php">¿Ya tienes cuenta? Inicia sesión</a>
</body>
</html>