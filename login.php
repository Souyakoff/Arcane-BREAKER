<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
?>

<?php
// Inclure le fichier de connexion à la base de données
include('db_connect.php');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';

    try {
        $user = null;

        // Vérifier si l'utilisateur est un administrateur
        $stmt = $conn->prepare("SELECT * FROM admin_users WHERE username = ?");
        $stmt->execute([$username]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$user) {
            // Si non trouvé dans `admin_users`, vérifier dans `users`
            $stmt = $conn->prepare("SELECT * FROM users WHERE username = ?");
            $stmt->execute([$username]);
            $user = $stmt->fetch(PDO::FETCH_ASSOC);
        }

        if ($user) {
            // Déterminer le champ correct pour la vérification du mot de passe
            $passwordField = isset($user['password_hash']) ? 'password_hash' : 'password';

            // Vérification du mot de passe
            if (password_verify($password, $user[$passwordField])) {
                // Démarrer la session
                session_start();
                $_SESSION['user_id'] = $user['id'];
                $_SESSION['username'] = $user['username'];

                if (isset($user['role'])) {
                    // L'utilisateur est un administrateur
                    $_SESSION['role'] = $user['role'];
                    header('Location: admin_dashboard.php');
                } else {
                    // L'utilisateur est standard
                    $_SESSION['shards'] = $user['shards']; // Bonus pour stocker le nombre de shards
                    header('Location: index.php');
                }
                exit;
            } else {
                $error = "Mot de passe incorrect.";
            }
        } else {
            $error = "Nom d'utilisateur non trouvé.";
        }
    } catch (PDOException $e) {
        $error = "Erreur lors de la connexion : " . $e->getMessage();
    }
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Arcane | Breaker</title>
    <link rel="icon" href="images/Arcanelogo.png" type="image/x-icon">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="styles.css" id="theme-link">
</head>
<body>
    <header>
        <h1>Arcane Breaker</h1>
        <nav>
            <ul>
                <li><a href="index.php">Accueil</a></li>
                <li><a href="register.php">Inscription</a></li>
                <li><a href="settings.php"><i class="bi bi-gear nav-icon"></i></a></li>
            </ul>
        </nav>
    </header>
    <h1>Connexion</h1>
    
    <?php if (isset($error)): ?>
        <p style="color: red;"><?= htmlspecialchars($error) ?></p>
    <?php endif; ?>

    <form method="POST">
        <label for="username">Nom d'utilisateur :</label>
        <input type="text" name="username" id="username" required>
        
        <label for="password">Mot de passe :</label>
        <input type="password" name="password" id="password" required>

        <button type="submit">Se connecter</button>
    </form>

    <p>Pas encore inscrit ? <a href="register.php">Créer un compte</a></p>
</body>
</html>
