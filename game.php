<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Connexion à la base de données pour récupérer les informations du joueur et ses cartes
include('db_connect.php');

// Démarrer la session si nécessaire
session_start();

// Vérifier si l'utilisateur est connecté
if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit();
}

$user_id = $_SESSION['user_id']; // ID de l'utilisateur connecté

// Récupérer les cartes du joueur
$sql = "
    SELECT c.* 
    FROM cards c
    JOIN deck_cards dc ON c.id = dc.card_id
    JOIN decks d ON dc.deck_id = d.deck_id
    WHERE d.user_id = :user_id
    LIMIT 5";  // Limiter le nombre de cartes retournées si nécessaire
$stmt = $conn->prepare($sql);
$stmt->bindParam(':user_id', $user_id);
$stmt->execute();
$cards = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Arcane - Jeu</title>
    <link rel="icon" href="images/Arcanelogo.png" type="image/x-icon">
    <link rel="stylesheet" href="styles.css" id="theme-link">
    <link rel="stylesheet" href="styles_game.css">
</head>
<body>
    <header>
        <h1>Arcane Breaker</h1>
        <nav>
            <ul>
                <li><a href="javascript:void(0);" onclick="window.close()">Fermer</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <!-- Suppression du game-container pour que le jeu occupe toute la page -->
        <h2>Affrontement contre le Bot</h2>

        <!-- Section des cartes du joueur -->
        <section class="player-deck">
            <h3>Votre Deck</h3>
            <div class="card-container">
            <?php foreach ($cards as $card): ?>
            <li class="card-item" data-id="<?php echo htmlspecialchars($card['id']); ?>">
                <div class="card" onclick="openPopup(<?php echo htmlspecialchars($card['id']); ?>, '<?php echo htmlspecialchars($card['name']); ?>')">
                    <!-- Face avant de la carte -->
                    <div class="card-front" style="background-image: url('<?php echo htmlspecialchars($card['image']); ?>');">
                        <h4><?php echo htmlspecialchars($card['name']); ?></h4>
                        <!-- L'image est maintenant gérée par le background CSS -->
                    </div>
                    <!-- Face arrière de la carte (détails) -->
                    <div class="card-back" style="background-image: url('<?php echo htmlspecialchars($card['city_image']); ?>');">
    <h4><?php echo htmlspecialchars($card['name']); ?></h4>
    <p><strong>Points de Vie :</strong> <?php echo htmlspecialchars($card['health_points']); ?></p>
    <p><strong>Attaque :</strong> <?php echo htmlspecialchars($card['attack']); ?></p>
    <p><strong>Défense :</strong> <?php echo htmlspecialchars($card['defense']); ?></p>
    <p><strong>Capacité Spéciale :</strong> <?php echo htmlspecialchars($card['special_ability']); ?></p>
</div>
                </div>
            </li>
        <?php endforeach; ?>
        </section>

        <!-- Section de combat -->
        <section class="game-play">
            <h3>Votre Tour</h3>
            <button id="attack">Attaquer</button>
            <button id="defend">Défendre</button>
            <button id="special-ability">Utiliser Capacité Spéciale</button>
        </section>

        <section class="game-status">
            <h3>État du Jeu</h3>
            <p><strong>PV Bot :</strong> <span id="bot-pv">100</span></p>
            <p><strong>Vos PV :</strong> <span id="player-pv">100</span></p>
        </section>
    </main>

    <footer>
        <p>&copy; 2024 Arcane Card Game. Tous droits réservés.</p>
    </footer>

    <script>
        // Lancer la logique de jeu ici, comme les attaques, la défense, etc.
        document.getElementById('attack').addEventListener('click', function() {
            // Code pour attaquer...
        });

        document.getElementById('defend').addEventListener('click', function() {
            // Code pour défendre...
        });

        document.getElementById('special-ability').addEventListener('click', function() {
            // Code pour utiliser la capacité spéciale...
        });
    </script>
</body>
</html>
