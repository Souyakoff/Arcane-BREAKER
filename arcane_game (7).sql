-- phpMyAdmin SQL Dump
-- version 5.2.1deb1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : jeu. 19 déc. 2024 à 14:15
-- Version du serveur : 10.11.6-MariaDB-0+deb12u1
-- Version de PHP : 8.2.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `arcane_game`
--

-- --------------------------------------------------------

--
-- Structure de la table `admin_users`
--

CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `role` enum('superadmin','moderator') DEFAULT 'moderator',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `last_login` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `admin_users`
--

INSERT INTO `admin_users` (`id`, `username`, `password_hash`, `email`, `full_name`, `role`, `created_at`, `last_login`, `is_active`) VALUES
(1, 'admin', '$2y$10$A8hQyePbz8kjLhPuGZMkO.9KyW3Tq/nP8bRT2SfyIykbOllvToX0y', 'admin@example.com', 'Admin User', 'superadmin', '2024-12-02 08:14:17', NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `cards`
--

CREATE TABLE `cards` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `image` varchar(255) NOT NULL,
  `health_points` int(11) NOT NULL,
  `attack` int(11) NOT NULL,
  `defense` int(11) NOT NULL,
  `special_ability` text DEFAULT NULL,
  `city_image` varchar(255) NOT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  `id_class` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `cards`
--

INSERT INTO `cards` (`id`, `name`, `image`, `health_points`, `attack`, `defense`, `special_ability`, `city_image`, `price`, `id_class`) VALUES
(1, 'Vi', 'images/cards/vi.jpg', 120, 30, 10, 'Force brute – Double les dégâts pendant 3 tours.', 'images/villes/zaun.jpg', 1000, 1),
(2, 'Jinx', 'images/cards/jinx.jpg', 100, 25, 5, 'Folie – Lance une attaque surprise tous les 2 tours.', 'images/villes/zaun.jpg', 2000, 2),
(3, 'Caitlyn', 'images/cards/caitlyn.jpg', 110, 20, 15, 'Tir précis – Augmente les chances de critique.', 'images/villes/piltover.jpg', 3000, 2),
(4, 'Silco', 'images/cards/silco.jpg', 150, 20, 25, 'Manipulation – Restaure 10 PV tous les 3 tours.', 'images/villes/zaun.jpg', 1500, 4),
(5, 'Jayce', 'images/cards/jayce.jpg', 130, 35, 12, 'Transformation – Change de forme, doublant les dégâts d\'attaque à chaque transformation.', 'images/villes/piltover.jpg', 2500, 1),
(6, 'Ekko', 'images/cards/ekko.jpg', 110, 28, 12, 'Réwind – Annule les dégâts subis au tour précédent.', 'images/villes/zaun.jpg', 3500, 1),
(7, 'Vander/Warwick', 'images/cards/vander.jpg', 180, 15, 40, 'Gardien – Réduit les dégâts subis de 50% pendant 2 tours.', 'images/villes/zaun.jpg', 4000, 1),
(8, 'Heimerdinger', 'images/cards/heimerdinger.png', 90, 18, 18, 'Tourelle – Place une tourelle qui attaque chaque tour.', 'images/villes/piltover.jpg', 6000, 6),
(9, 'Orianna', 'images/cards/orianna.jpg', 95, 22, 20, 'Ball d\'Orianna – Déplace la balle sur le champ de bataille pour des dégâts supplémentaires.', 'images/villes/piltover.jpg', 4500, 3),
(10, 'Viktor', 'images/cards/viktor.jpg', 140, 20, 35, 'Système de perfection – Augmente son attaque chaque fois qu\'il subit des dégâts.', 'images/villes/zaun.jpg', 5000, 3),
(11, 'Ziggs', 'images/cards/ziggs.jpg', 100, 30, 5, 'Explosion – Fait exploser une zone, infligeant des dégâts à toutes les cartes ennemies.', 'images/villes/zaun.jpg', 5500, 3),
(12, 'Sevika', 'images/cards/sevika.png', 140, 25, 20, 'Force mécanique – Augmente la défense chaque fois qu\'elle attaque.', 'images/villes/zaun.jpg', 2000, 1),
(13, 'Mel', 'images/cards/mel.jpg', 100, 18, 30, 'Diplomatie – Réduit les attaques ennemies de 50% pendant un tour.', 'images/villes/piltover.jpg', 1000, 6),
(14, 'Jhin', 'images/cards/jhin.jpg', 80, 40, 10, 'Tir fatal – Augmente l\'attaque chaque fois qu\'un ennemi est éliminé.', 'images/villes/noxus.jpg', 1500, 2),
(15, 'Singed', 'images/cards/singed.jpg', 150, 20, 10, 'Gaz toxique – Dégâts de poison chaque tour pour les cartes ennemies proches.', 'images/villes/zaun.jpg', 2500, 4),
(16, 'Lux', 'images/cards/lux.jpg', 110, 22, 15, 'Lumière radieuse – Lance une attaque de lumière qui inflige des dégâts à toutes les cartes ennemies.', 'images/villes/demacia.jpg', 3000, 3),
(17, 'Kennen', 'images/cards/kennen.jpg', 85, 30, 12, 'Tempête d\'éclairs – Réduit la défense ennemie de 20% pendant 2 tours.', 'images/villes/ixtal.jpg', 4000, 5),
(18, 'Zed', 'images/cards/zed.jpg', 100, 35, 10, 'Ombres – Inflige des dégâts supplémentaires à chaque attaque surprise.', 'images/villes/ionia.jpg', 3500, 5),
(19, 'Teemo', 'images/cards/teemo.jpg', 75, 25, 5, 'Champignon empoisonné – Place un champignon qui inflige des dégâts de poison pendant 3 tours.', 'images/villes/bandle_city.jpg', 4500, 1),
(20, 'Blitzcrank', 'images/cards/blitzcrank.jpg', 140, 20, 30, 'Attraper – Attire une carte ennemie et inflige des dégâts supplémentaires.', 'images/villes/zaun.jpg', 6000, 4),
(21, 'Riven', 'images/cards/riven.jpg', 120, 35, 10, 'Epée brisée – Augmente les dégâts à chaque fois que sa santé descend en dessous de 50%.', 'images/villes/noxus.jpg', 5000, 1);

-- --------------------------------------------------------

--
-- Structure de la table `classe`
--

CREATE TABLE `classe` (
  `id_class` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `icone` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `classe`
--

INSERT INTO `classe` (`id_class`, `nom`, `icone`) VALUES
(1, 'Combattant', 'images/icone/combattant.png'),
(2, 'Tireur', 'images/icone/tireur.png'),
(3, 'Mage', 'images/icone/mage.png'),
(4, 'Tank', 'images/icone/tank.png'),
(5, 'Assassin', 'images/icone/assassin.png'),
(6, 'Support', 'images/icone/support.png');

-- --------------------------------------------------------

--
-- Structure de la table `decks`
--

CREATE TABLE `decks` (
  `deck_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `deck_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `decks`
--

INSERT INTO `decks` (`deck_id`, `user_id`, `deck_name`) VALUES
(9, 4, 'Hugo');

-- --------------------------------------------------------

--
-- Structure de la table `deck_cards`
--

CREATE TABLE `deck_cards` (
  `deck_id` int(11) NOT NULL,
  `card_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `deck_cards`
--

INSERT INTO `deck_cards` (`deck_id`, `card_id`) VALUES
(9, 1),
(9, 2),
(9, 5),
(9, 7),
(9, 9);

-- --------------------------------------------------------

--
-- Structure de la table `inventory`
--

CREATE TABLE `inventory` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `inventory`
--

INSERT INTO `inventory` (`id`, `user_id`, `item_id`, `quantity`) VALUES
(1, 4, 1, 2),
(2, 4, 2, 1);

-- --------------------------------------------------------

--
-- Structure de la table `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `effect` varchar(50) NOT NULL,
  `value` int(11) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `items`
--

INSERT INTO `items` (`id`, `name`, `effect`, `value`, `image`, `description`) VALUES
(1, 'Potion de soin', 'heal', 20, 'images/heal.png', 'Restaure 20 points de vie.'),
(2, 'Potion de force', 'boost', 10, 'images/boost.png', 'Augmente les dégâts de 10 pour un tour.'),
(3, 'Potion paralysante', 'stun', 1, 'images/stun.png', 'Paralyse l’ennemi pour un tour.');

-- --------------------------------------------------------

--
-- Structure de la table `pass_levels`
--

CREATE TABLE `pass_levels` (
  `id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `benefits` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `pass_levels`
--

INSERT INTO `pass_levels` (`id`, `season_id`, `level`, `name`, `benefits`) VALUES
(1, 1, 1, 'Palier 1', 'Accès à des skins exclusifs pour votre avatar.'),
(2, 1, 2, 'Palier 2', 'Bonus de 100 pièces pour acheter des objets dans la boutique.'),
(3, 1, 3, 'Palier 3', 'Accès à des contenus vidéo exclusifs sur les coulisses de la saison.'),
(4, 1, 4, 'Palier 4', 'Réduction de 10% sur tous les articles de la boutique pendant la saison.'),
(5, 1, 5, 'Palier 5', 'Accès à un événement spécial réservé aux membres du pass saisonnier.'),
(6, 1, 6, 'Palier 6', 'Débloque une monture exclusive pour la saison.'),
(7, 1, 7, 'Palier 7', 'Accès anticipé aux nouvelles cartes ou missions de la saison.'),
(8, 1, 8, 'Palier 8', 'Un badge spécial à afficher sur votre profil.'),
(9, 1, 9, 'Palier 9', 'Réduction de 20% sur les achats de la boutique en ligne.'),
(10, 1, 10, 'Palier 10', 'Accès à un pack de skins rares.'),
(11, 1, 11, 'Palier 11', '50% de réduction sur l\'abonnement premium pendant un mois.'),
(12, 1, 12, 'Palier 12', 'Accès à un chat privé avec les développeurs de la saison.'),
(13, 1, 13, 'Palier 13', 'Accès à une série d\'émissions en direct avec des invités spéciaux.'),
(14, 1, 14, 'Palier 14', 'Débloque des objets cosmétiques uniques pour votre avatar.'),
(15, 1, 15, 'Palier 15', 'Accès à un tournoi exclusif avec des récompenses spéciales.'),
(16, 1, 16, 'Palier 16', 'Pack de boosts d\'expérience pour progresser plus rapidement.'),
(17, 1, 17, 'Palier 17', 'Accès à une nouvelle zone ou carte de jeu exclusive.'),
(18, 1, 18, 'Palier 18', 'Réduction de 30% sur les articles physiques de la boutique partenaire.'),
(19, 1, 19, 'Palier 19', 'Accès à des avatars et émoticônes spéciaux pour le chat.'),
(20, 1, 20, 'Palier 20', 'Accès anticipé à la prochaine saison de contenu.'),
(21, 1, 21, 'Palier 21', 'Pack de récompenses pour le joueur avec des objets rares.'),
(22, 1, 22, 'Palier 22', 'Réduction de 40% sur tous les produits de la boutique.'),
(23, 1, 23, 'Palier 23', 'Accès à un contenu inédit sur la saison prochaine.'),
(24, 1, 24, 'Palier 24', 'Débloque une série de nouvelles missions spéciales.'),
(25, 1, 25, 'Palier 25', 'Accès à un cadeau surprise en fin de saison.'),
(26, 1, 26, 'Palier 26', 'Récompense spéciale pour avoir terminé tous les défis de la saison.'),
(27, 1, 27, 'Palier 27', 'Accès à un espace VIP avec des privilèges exclusifs.'),
(28, 1, 28, 'Palier 28', 'Pack de tenues spéciales pour les événements saisonniers.'),
(29, 1, 29, 'Palier 29', 'Réduction de 50% sur tous les achats dans la boutique.'),
(30, 1, 30, 'Palier 30', 'Accès au titre prestigieux de \"Légende de la saison\".');

-- --------------------------------------------------------

--
-- Structure de la table `purshased_cards`
--

CREATE TABLE `purshased_cards` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `card_id` int(11) NOT NULL,
  `date_achat` datetime DEFAULT current_timestamp(),
  `quantite` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `seasons`
--

CREATE TABLE `seasons` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `datede_debut` date DEFAULT NULL,
  `datede_fin` date DEFAULT NULL,
  `description` text NOT NULL,
  `theme` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `pass_benefits` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `seasons`
--

INSERT INTO `seasons` (`id`, `name`, `datede_debut`, `datede_fin`, `description`, `theme`, `image`, `pass_benefits`) VALUES
(1, 'Saison de lancement', '2024-12-04', '2025-01-29', 'Bienvenue dans notre première saison ! Découvrez le nouveau thème, les objets exclusifs et les défis excitants. Profitez d\'une expérience inédite avec des récompenses spéciales pour les joueurs fidèles.', 'L\'Aube Mystique', 'images/season1.jpg', 'Accès à des objets exclusifs, skins spéciaux et une série de quêtes uniques pour cette saison.'),
(2, 'Saison du Feu Céleste', '2024-12-26', '2025-02-10', 'Explorez les mystères du Feu Céleste. Cette saison introduit des défis célestes, des ennemis redoutables, et un nouveau terrain de jeu inspiré des cieux. De nouveaux skins et des bonus de combat attendent les plus courageux.', 'Feu Céleste', 'images/season2.jpg', 'Accès à un pass de combat exclusif, une nouvelle arme légendaire, et un bonus de 10% d\'XP pendant toute la saison.'),
(3, 'Saison de la Tempête', '2025-02-11', '2025-04-10', 'Affrontez les puissantes tempêtes qui ravagent le monde dans cette saison. De nouvelles cartes, des effets météorologiques spectaculaires et des défis époustouflants vous attendent. Prêt à braver les éléments ?', 'Tempête Éternelle', 'images/season3.jpg', 'Accès à un défi spécial de la saison, des skins de tempête et un nouveau mode de jeu avec des conditions météo dynamiques.'),
(4, 'Saison des Ombres', '2025-04-11', '2025-06-07', 'Plongez dans un monde de mystère et de suspense avec la Saison des Ombres. Cette saison, les ténèbres vous entourent et des secrets attendent d\'être découverts. Un tout nouveau mode furtif est à découvrir.', 'Ombres Mystérieuses', 'images/season4.jpg', 'Accès à des zones secrètes, un mode furtif exclusif et une récompense spéciale pour les joueurs ayant complété tous les défis de la saison.');

-- --------------------------------------------------------

--
-- Structure de la table `season_passes`
--

CREATE TABLE `season_passes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `purchase_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `bio` text DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `shards` int(11) DEFAULT 0,
  `score` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `created_at`, `bio`, `profile_picture`, `shards`, `score`) VALUES
(4, 'souyak', 'souyak94@gmail.com', '$2y$10$nQx11meHYIGPH54cgrgxl.keTJBY6hcnE7.7.G3IbmCcTHAVoCSk6', '2024-11-26 10:26:17', '', 'images/default_profile_picture.jpg', 6000, 0);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_class` (`id_class`);

--
-- Index pour la table `classe`
--
ALTER TABLE `classe`
  ADD PRIMARY KEY (`id_class`);

--
-- Index pour la table `decks`
--
ALTER TABLE `decks`
  ADD PRIMARY KEY (`deck_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `deck_cards`
--
ALTER TABLE `deck_cards`
  ADD PRIMARY KEY (`deck_id`,`card_id`),
  ADD KEY `card_id` (`card_id`);

--
-- Index pour la table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Index pour la table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `pass_levels`
--
ALTER TABLE `pass_levels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `season_id` (`season_id`);

--
-- Index pour la table `purshased_cards`
--
ALTER TABLE `purshased_cards`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`card_id`),
  ADD KEY `card_id` (`card_id`);

--
-- Index pour la table `seasons`
--
ALTER TABLE `seasons`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `season_passes`
--
ALTER TABLE `season_passes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `season_id` (`season_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `cards`
--
ALTER TABLE `cards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT pour la table `classe`
--
ALTER TABLE `classe`
  MODIFY `id_class` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `decks`
--
ALTER TABLE `decks`
  MODIFY `deck_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `pass_levels`
--
ALTER TABLE `pass_levels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT pour la table `purshased_cards`
--
ALTER TABLE `purshased_cards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `seasons`
--
ALTER TABLE `seasons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `season_passes`
--
ALTER TABLE `season_passes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `cards`
--
ALTER TABLE `cards`
  ADD CONSTRAINT `fk_class` FOREIGN KEY (`id_class`) REFERENCES `classe` (`id_class`);

--
-- Contraintes pour la table `decks`
--
ALTER TABLE `decks`
  ADD CONSTRAINT `decks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `deck_cards`
--
ALTER TABLE `deck_cards`
  ADD CONSTRAINT `deck_cards_ibfk_1` FOREIGN KEY (`deck_id`) REFERENCES `decks` (`deck_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `deck_cards_ibfk_2` FOREIGN KEY (`card_id`) REFERENCES `cards` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);

--
-- Contraintes pour la table `pass_levels`
--
ALTER TABLE `pass_levels`
  ADD CONSTRAINT `pass_levels_ibfk_1` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`);

--
-- Contraintes pour la table `purshased_cards`
--
ALTER TABLE `purshased_cards`
  ADD CONSTRAINT `purshased_cards_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purshased_cards_ibfk_2` FOREIGN KEY (`card_id`) REFERENCES `cards` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `season_passes`
--
ALTER TABLE `season_passes`
  ADD CONSTRAINT `season_passes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `season_passes_ibfk_2` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
