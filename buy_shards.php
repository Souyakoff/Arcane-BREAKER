<?php include('header.php'); ?>
<?php
// Afficher les erreurs PHP (à désactiver en production)
ini_set('display_errors', 1);
error_reporting(E_ALL);

// Connexion à la base de données
require 'db_connect.php';

// Démarrer la session
session_start();
if (!isset($_SESSION['user_id'])) {
    // Rediriger vers la page de connexion si l'utilisateur n'est pas connecté
    header("Location: login.php");
    exit();
}

$userId = $_SESSION['user_id'];

// Récupérer les informations de l'utilisateur
$userQuery = $conn->prepare("SELECT * FROM users WHERE id = :id");
$userQuery->execute(['id' => $userId]);
$user = $userQuery->fetch(PDO::FETCH_ASSOC);

if (!$user) {
    die("Utilisateur introuvable.");
}

// Traitement de l'achat
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['shards_amount'])) {
    $shardsAmount = intval($_POST['shards_amount']); // Convertir le montant en entier

    if ($shardsAmount > 0) {
        // Ajouter les shards au compte de l'utilisateur
        $updateQuery = $conn->prepare("UPDATE users SET shards = shards + :shards WHERE id = :id");
        $updateQuery->execute(['shards' => $shardsAmount, 'id' => $userId]);

        echo "<p style='color: green;'>Vous avez ajouté {$shardsAmount} shards à votre compte !</p>";
    } else {
        echo "<p style='color: red;'>Montant invalide.</p>";
    }
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="images/Arcanelogo.png" type="image/x-icon">
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="styles_shards.css">
    <title>Acheter des Shards</title>
</head>
<body>
    <header>
        <h1>Arcane Breaker</h1>
        <nav>
            <ul>
                <li><a href="index.php">Accueil</a></li>
                <li><a href="deck.php">Deck</a></li>
                <li><a href="market.php">Boutique</a></li>
                <div class="profile-container" style="display: flex; align-items: center;">
            <?php if ($user_id): ?>
                <a href="profile.php">
                    <img src="<?php echo $profile_picture; ?>" alt="Photo de profil" style="width: 40px; height: 40px; border-radius: 50%; margin-right: 10px;">
                </a>
            <?php endif; ?>
        </div>
        <div class="menu-links" style="display: flex; align-items: center;">
            <?php if ($user_id): ?>
                <li><a href="logout.php">Se déconnecter</a></li>
            <?php else: ?>
                <li><a href="login.php">Connexion</a></li>
            <?php endif; ?>
            <li><a href="settings.php" style="margin-left: 20px;"><i class="bi bi-gear nav-icon"></i></a></li>
        </div>
    </ul>
        </nav>
    </header>

    <main>
        <h2>Achetez des Shards</h2>
        <p>Votre solde actuel : <strong><?php echo htmlspecialchars($user['shards']); ?> shards</strong></p>

        <div class="packs-container">
        <!-- Pack 1 -->
        <div class="shard-pack">
            <img src="images/shards_100.png" alt="100 shards">
            <h3>100 Shards</h3>
            <p>1€</p>
            <form method="POST" action="buy_shards.php">
                <input type="hidden" name="shards_amount" value="100">
                <button type="submit">Acheter</button>
            </form>
        </div>
        <!-- Pack 2 -->
        <div class="shard-pack">
            <img src="images/shards_500.png" alt="500 shards">
            <h3>500 Shards</h3>
            <p>5€</p>
            <form method="POST" action="buy_shards.php">
                <input type="hidden" name="shards_amount" value="500">
                <button type="submit">Acheter</button>
            </form>
        </div>
        <!-- Pack 3 -->
        <div class="shard-pack">
            <img src="images/shards_1000.png" alt="1000 shards">
            <h3>1000 Shards</h3>
            <p>10€</p>
            <form method="POST" action="buy_shards.php">
                <input type="hidden" name="shards_amount" value="1000">
                <button type="submit">Acheter</button>
            </form>
        </div>
        <!-- Pack 4 -->
        <div class="shard-pack">
            <img src="images/shards_5000.png" alt="5000 shards">
            <h3>5000 Shards</h3>
            <p>50€</p>
            <form method="POST" action="buy_shards.php">
                <input type="hidden" name="shards_amount" value="5000">
                <button type="submit">Acheter</button>
            </form>
        </div>
    </div>
    </main>
</body>
</html>
