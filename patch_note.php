<?php include('header.php'); ?>
<?php
session_start();

// Vérifier si l'utilisateur est un admin (par exemple, via $_SESSION['role'])
$isAdmin = isset($_SESSION['role']) && $_SESSION['role'] === 'superadmin';
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patch Notes | Arcane Breaker</title>
    <link rel="icon" href="images/Arcane_logo.png" type="image/x-icon">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="styles.css" id="theme-link">
    <style>
        .patch-note {
            border: 1px solid #ccc;
            padding: 15px;
            margin: 15px 0;
            border-radius: 5px;
        }
        .admin-controls {
            margin-top: 10px;
        }
        form {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <header>
        <h1>Arcane Breaker</h1>
        <nav>
            <ul>
                <li><a href="index.php">Accueil</a></li>
                <?php if ($user_id): ?>
                <li><a id="play" href="javascript:void(0);" onclick="openGameWindow()">Jouer</a></li> <!-- Nouveau lien "Jouer" -->
                <?php endif; ?>
                <li><a href="deck.php">Deck</a></li>
                <li><a href="market.php">Boutique</a></li>
                <?php if ($isAdmin): ?>
                    <li><a href="admin_dashboard.php">Admin</a></li>
                <?php endif; ?>
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
        <h1>Patch Notes</h1>
        <p>Découvrez les dernières mises à jour et améliorations apportées au jeu.</p>

        <!-- Liste des patch notes -->
        <div id="patch-notes">
            <div class="patch-note">
                <h2>Version 1.2.0 (01/12/2024)</h2>
                <p>- Ajout de nouvelles cartes légendaires.</p>
                <p>- Amélioration des performances dans les combats multijoueurs.</p>
                <p>- Correction de bugs liés aux animations des personnages.</p>
            </div>
            <div class="patch-note">
                <h2>Version 1.1.5 (15/11/2024)</h2>
                <p>- Équilibrage des dégâts pour les armes légères.</p>
                <p>- Ajout d'un tutoriel pour les nouveaux joueurs.</p>
                <p>- Correction d'un problème de connexion au serveur.</p>
            </div>
        </div>

        <?php if ($isAdmin): ?>
            <h2>Ajouter ou modifier un Patch Note</h2>
            <!-- Formulaire d'ajout ou de modification de patch note -->
            <form method="POST" action="">
                <label for="version">Version :</label>
                <input type="text" name="version" id="version" placeholder="Exemple : 1.2.0" required>

                <label for="date">Date :</label>
                <input type="date" name="date" id="date" required>

                <label for="details">Détails :</label>
                <textarea name="details" id="details" rows="5" placeholder="Liste des changements..." required></textarea>

                <button type="submit">Enregistrer</button>
            </form>
        <?php endif; ?>
    </main>

    <footer>
        <p>&copy; 2024 Arcane Breaker. Tous droits réservés.</p>
    </footer>
</body>
</html>
