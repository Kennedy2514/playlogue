<?php
function getDatabaseConnection() {
    $config = [
        'host'     => 'playlogue_db',
        'port'     => '5432',
        'dbname'   => 'playlogue',
        'username' => 'admin',
        'password' => 'aromero12!',
        'options'  => [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,    
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,          
            PDO::ATTR_EMULATE_PREPARES   => false,                     
            PDO::ATTR_PERSISTENT         => false                            
        ]
    ];

    $dsn = "pgsql:host={$config['host']};port={$config['port']};dbname={$config['dbname']}";

    try {
        $pdo = new PDO(
            $dsn,
            $config['username'],
            $config['password'],
            $config['options']
        );
        $pdo->query("SELECT 1");
        
        return $pdo;

    } catch (PDOException $e) {
        error_log("Database Connection Failed: " . $e->getMessage());
        
        if (defined('DEV_MODE') && DEV_MODE === true) {
            die("Database Error: " . $e->getMessage());
        } else {
            die("Service unavailable. Please try again later.");
        }
    }
}

?>