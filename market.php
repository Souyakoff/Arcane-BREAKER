<?php include('header.php'); ?>

<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);

// Connexion à la base de données
require 'db_connect.php';

// Récupérer l'ID de l'utilisateur depuis la session
session_start();
if (!isset($_SESSION['user_id'])) {
    // Rediriger vers la page de connexion si l'utilisateur n'est pas connecté
    header("Location: login.php");
    exit();
}
$userId = $_SESSION['user_id'];

// Récupération des informations de l'utilisateur
$userQuery = $conn->prepare("SELECT * FROM users WHERE id = :id");
$userQuery->execute(['id' => $userId]);
$user = $userQuery->fetch(PDO::FETCH_ASSOC);

// Vérifier si l'utilisateur existe
if (!$user) {
    die("Utilisateur introuvable");
}

// Récupération des cartes disponibles dans la boutique du jour
$dateSeed = date('Y-m-d'); // Utilise la date du jour pour générer des cartes différentes chaque jour
srand(strtotime($dateSeed)); // Initialise le générateur aléatoire
$dailyCardsQuery = $conn->query("SELECT * FROM cards");
$allCards = $dailyCardsQuery->fetchAll(PDO::FETCH_ASSOC);
shuffle($allCards); // Mélange les cartes
$dailyCards = array_slice($allCards, 0, 5); // Sélectionne les 5 premières cartes mélangées

// Traitement d'un achat
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['card_id'])) {
    $cardId = intval($_POST['card_id']); // On s'assure que l'ID est un entier valide

    // Vérification de l'existence de la carte
    $priceQuery = $conn->prepare("SELECT id, price FROM cards WHERE id = :id");
    $priceQuery->execute(['id' => $cardId]);
    $card = $priceQuery->fetch(PDO::FETCH_ASSOC); 

    var_dump($card); // Affiche la réponse de la requête pour déboguer


    if ($card) {
        if ($user['shards'] >= $card['price']) {
            // Déduire le prix des shards de l'utilisateur
            $updateUser = $conn->prepare("UPDATE users SET shards = shards - :price WHERE id = :id");
            $updateUser->execute(['price' => $card['price'], 'id' => $userId]);

            // Insérer l'achat dans la table `purchased_cards`
            $insertPurchase = $conn->prepare("INSERT INTO purchased_cards (user_id, card_id, quantite) 
                                              VALUES (:user_id, :card_id, 1) 
                                              ON DUPLICATE KEY UPDATE quantite = quantite + 1");
            $insertPurchase->execute(['user_id' => $userId, 'card_id' => $cardId]);

            // Confirmer l'achat
            echo "<p style='color: green;'>Achat réussi : {$card['price']} shards déduits !</p>";
        } else {
            echo "<p style='color: red;'>Fonds insuffisants.</p>";
        }
    } else {
        echo "<p style='color: red;'>Carte introuvable.</p>";
        var_dump($cardId); // Vérifie la valeur de l'ID
    }
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="images/Arcane_logo.png" type="image/x-icon">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="styles.css" id="theme-link">
    <link rel="stylesheet" href="styles_market.css">
    <title>Marché des Cartes</title>
</head>
<header>
    <h1>Arcane Breaker</h1>
    <nav>
        <ul>
            <li><a href="index.php">Accueil</a></li>
            <li><a id="play" href="javascript:void(0);" onclick="openGameWindow()">Jouer</a></li>
            <li><a href="deck.php">Deck</a></li>
            <div class="profile-container" style="display: flex; align-items: center;">
            <?php if ($userId): ?>
                <a href="profile.php">
                    <img src="<?php echo $user['profile_picture']; ?>" alt="Photo de profil" style="width: 40px; height: 40px; border-radius: 50%; margin-right: 10px;">
                </a>
            <?php endif; ?>
        </div>
        <div class="menu-links" style="display: flex; align-items: center;">
            <?php if ($userId): ?>
                <li><a href="logout.php">Se déconnecter</a></li>
            <?php else: ?>
                <li><a href="login.php">Connexion</a></li>
            <?php endif; ?>
            <li><a href="settings.php" style="margin-left: 20px;"><i class="bi bi-gear nav-icon"></i></a></li>
        </div>
    </ul>

    </nav>
</header>
<body>
    <h1>Boutique du Jour</h1>
    <h3>La boutique se mettra à jour dans :</h3>
<div id="countdown" style="font-size: 1.5rem; color: #333;"></div>
    <section class="cards">
        <h2>Cartes Disponibles Aujourd'hui</h2>
        <ul class="card-list">
            <?php foreach ($dailyCards as $card): ?>
                <li class="card-item" data-id="<?php echo htmlspecialchars($card['id']); ?>">
                    <div class="card" onclick="openPopup(<?php echo htmlspecialchars($card['id']); ?>, '<?php echo htmlspecialchars($card['name']); ?>', <?php echo htmlspecialchars($card['price']); ?>)">
                        <div class="card-front" style="background-image: url('<?php echo htmlspecialchars($card['image']); ?>');">
                            <h4><?php echo htmlspecialchars($card['name']); ?></h4>
                            <p class="card-price"><?php echo htmlspecialchars($card['price']); ?> Shards</p>
                        </div>
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
        </ul>
    </section>
    <div id="popup" class="popup">
        <div class="popup-content">
            <span class="close-btn" onclick="closePopup()">&times;</span>
            <h3 id="popup-title">Aperçu de la carte</h3>
            <div id="popup-card-display" class="popup-card-display"></div>
            <div id="popup-price-info" class="popup-price-info"></div>
            <form method="POST">
            <input type="hidden" id="popup-card-id" name="card_id" value="">
                <button type="submit" name="card_id" id="buy-button" class="buy-button" style="display: none;">Acheter la carte</button>
            </form>
            <p id="insufficient-funds" style="color: red; display: none;">Vous n'avez pas assez de fonds pour acheter cette carte.</p>
        </div>
    </div>

<script>
function openPopup(cardId, cardName, cardPrice) {
    if (!cardId) {
        alert('ID de la carte invalide.');
        return;
    }
    const popup = document.getElementById('popup');
    const popupTitle = document.getElementById('popup-title');
    const popupCardId = document.getElementById('popup-card-id');
    popupCardId.value = cardId;
    const popupCardDisplay = document.getElementById('popup-card-display');
    const popupPriceInfo = document.getElementById('popup-price-info');
    const buyButton = document.getElementById('buy-button');
    const insufficientFunds = document.getElementById('insufficient-funds');

    // Met à jour les informations de la popup
    popupTitle.textContent = `Aperçu de la carte "${cardName}"`;
    popupCardId.value = cardId;
    popupPriceInfo.innerHTML = `<p>Prix : ${cardPrice} Shards</p>`;

    const card = document.querySelector(`.card-item[data-id='${cardId}']`);
    const cardHTML = card.innerHTML;

    popupCardDisplay.innerHTML = `<div class="card-item-popup">${cardHTML}</div>`;

    const userFunds = <?php echo $user['shards']; ?>;
    if (userFunds >= cardPrice) {
        buyButton.style.display = 'inline-block';
        insufficientFunds.style.display = 'none';
    } else {
        buyButton.style.display = 'none';
        insufficientFunds.style.display = 'block';
    }

    popup.style.display = 'block';
}

function closePopup() {
    const popup = document.getElementById('popup');
    popup.style.display = 'none';
}

function openGameWindow() {
    window.open('game.php', 'GameWindow', 'width=800,height=600');
}
</script>

<script>
// Fonction pour calculer et afficher le temps restant jusqu'à la mise à jour de la boutique
function updateCountdown() {
    const now = new Date();
    const nextUpdate = new Date();
    nextUpdate.setDate(now.getDate() + 1); // Passe au jour suivant
    nextUpdate.setHours(0, 0, 0, 0); // Définit minuit comme l'heure de mise à jour

    const timeDiff = nextUpdate - now; // Différence en millisecondes
    if (timeDiff > 0) {
        const hours = Math.floor((timeDiff / (1000 * 60 * 60)) % 24);
        const minutes = Math.floor((timeDiff / (1000 * 60)) % 60);
        const seconds = Math.floor((timeDiff / 1000) % 60);

        // Affichage formaté du compte à rebours
        document.getElementById('countdown').textContent = 
            `${hours}h ${minutes}m ${seconds}s`;
    } else {
        document.getElementById('countdown').textContent = "Mise à jour en cours...";
        clearInterval(timer); // Arrête le timer lorsque le temps est écoulé
        location.reload(); // Recharge la page pour afficher les nouvelles cartes
    }
}

// Met à jour le compte à rebours toutes les secondes
const timer = setInterval(updateCountdown, 1000);

// Initialisation immédiate au chargement de la page
updateCountdown();
</script>

</body>
</html>
