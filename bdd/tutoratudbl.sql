-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 15 déc. 2024 à 17:32
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `tutoratudbl`
--

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

CREATE TABLE `categorie` (
  `id` int(11) NOT NULL,
  `type` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `categorie`
--

INSERT INTO `categorie` (`id`, `type`) VALUES
(1, 'positif'),
(2, 'négatif');

-- --------------------------------------------------------

--
-- Structure de la table `cours`
--

CREATE TABLE `cours` (
  `id` int(11) NOT NULL,
  `intitule` varchar(50) NOT NULL,
  `idPromotion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cours`
--

INSERT INTO `cours` (`id`, `intitule`, `idPromotion`) VALUES
(1, 'c', 1),
(2, 'tad', 1),
(3, 'web', 2),
(4, 'bdd', 3),
(5, 'réseaux', 2);

-- --------------------------------------------------------

--
-- Structure de la table `courslance`
--

CREATE TABLE `courslance` (
  `id` int(11) NOT NULL,
  `dateLancement` datetime(3) NOT NULL,
  `dateFermeture` datetime(3) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `idCours` int(11) NOT NULL,
  `idResponsableTutorat` int(11) NOT NULL,
  `idTuteur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `courslance`
--

INSERT INTO `courslance` (`id`, `dateLancement`, `dateFermeture`, `status`, `idCours`, `idResponsableTutorat`, `idTuteur`) VALUES
(1, '2024-12-11 14:56:00.000', NULL, 1, 1, 1, 1),
(7, '2024-12-12 20:58:00.000', '2024-12-10 18:58:57.000', 1, 2, 1, 1),
(10, '2024-12-12 00:13:00.000', '2024-12-11 00:12:42.000', 1, 3, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `demandeencadrement`
--

CREATE TABLE `demandeencadrement` (
  `id` int(11) NOT NULL,
  `difficulte` text NOT NULL,
  `date` datetime(3) NOT NULL,
  `idEtudiant` int(11) NOT NULL,
  `idCours` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `demandeencadrement`
--

INSERT INTO `demandeencadrement` (`id`, `difficulte`, `date`, `idEtudiant`, `idCours`) VALUES
(2, 'tadd', '2024-12-12 20:32:54.000', 1, 2);

-- --------------------------------------------------------

--
-- Structure de la table `etudiant`
--

CREATE TABLE `etudiant` (
  `id` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `postNom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `matricule` varchar(20) NOT NULL,
  `idPromotion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `etudiant`
--

INSERT INTO `etudiant` (`id`, `nom`, `postNom`, `prenom`, `email`, `matricule`, `idPromotion`) VALUES
(1, 'ilonga', 'kayembe', 'raph', '20ik061@esisalama.org', '20ik061', 1);

-- --------------------------------------------------------

--
-- Structure de la table `feedback`
--

CREATE TABLE `feedback` (
  `id` int(11) NOT NULL,
  `avis` text NOT NULL,
  `idCoursLance` int(11) NOT NULL,
  `idEtudiant` int(11) NOT NULL,
  `idCategorie` int(11) NOT NULL,
  `date` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `feedback`
--

INSERT INTO `feedback` (`id`, `avis`, `idCoursLance`, `idEtudiant`, `idCategorie`, `date`) VALUES
(1, 'lou', 7, 1, 1, '2024-12-12 20:42:13.000'),
(2, 'fedd 2', 7, 1, 2, '2024-12-12 20:50:30.000');

-- --------------------------------------------------------

--
-- Structure de la table `filiere`
--

CREATE TABLE `filiere` (
  `id` int(11) NOT NULL,
  `intitule` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `filiere`
--

INSERT INTO `filiere` (`id`, `intitule`) VALUES
(1, 'GL'),
(2, 'MSI'),
(3, 'TLC'),
(4, 'AS'),
(5, 'DSG');

-- --------------------------------------------------------

--
-- Structure de la table `promotion`
--

CREATE TABLE `promotion` (
  `id` int(11) NOT NULL,
  `intitule` varchar(50) NOT NULL,
  `idFiliere` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `promotion`
--

INSERT INTO `promotion` (`id`, `intitule`, `idFiliere`) VALUES
(1, 'L1 ', NULL),
(2, 'L2', NULL),
(3, 'L3 GL ', 1),
(4, 'L3 MSI', 2),
(5, 'L3 TLC ', 3),
(6, 'L3 AS', 4),
(7, 'L3 DSG', 5),
(8, 'L4 GL ', 1),
(10, 'L4 MSI', 2),
(11, 'L4 TLC ', 3),
(12, 'L4 AS', 4),
(13, 'L4 DSG', 5);

-- --------------------------------------------------------

--
-- Structure de la table `responsabletutorat`
--

CREATE TABLE `responsabletutorat` (
  `id` int(11) NOT NULL,
  `idUtilisateur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `responsabletutorat`
--

INSERT INTO `responsabletutorat` (`id`, `idUtilisateur`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `seance`
--

CREATE TABLE `seance` (
  `id` int(11) NOT NULL,
  `date` datetime(3) NOT NULL,
  `idCoursLance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `seance`
--

INSERT INTO `seance` (`id`, `date`, `idCoursLance`) VALUES
(1, '2024-12-11 14:56:00.000', 1),
(10, '2024-12-12 00:13:00.000', 10),
(11, '2024-12-12 20:58:00.000', 7);

-- --------------------------------------------------------

--
-- Structure de la table `tuteur`
--

CREATE TABLE `tuteur` (
  `id` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `postNom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `numero` varchar(15) NOT NULL,
  `competance` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `tuteur`
--

INSERT INTO `tuteur` (`id`, `nom`, `postNom`, `prenom`, `email`, `numero`, `competance`) VALUES
(1, 'ilunga', 'kayembe', 'raph', 'raphkayembe00@gmail.com', '0975191209', 'progrmmation\r\n');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id` int(11) NOT NULL,
  `pseudo` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mdp` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `pseudo`, `email`, `mdp`) VALUES
(1, 'tutorat', 'tutorat@esisalama.org', '1234'),
(2, 'decanat', 'decanat@esisalama.org', '1234');

-- --------------------------------------------------------

--
-- Structure de la table `_prisma_migrations`
--

CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) NOT NULL,
  `checksum` varchar(64) NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) NOT NULL,
  `logs` text DEFAULT NULL,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `applied_steps_count` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `_prisma_migrations`
--

INSERT INTO `_prisma_migrations` (`id`, `checksum`, `finished_at`, `migration_name`, `logs`, `rolled_back_at`, `started_at`, `applied_steps_count`) VALUES
('60795e3e-74b3-4f0a-86d5-30a55b31a06b', '79870ad7f4f9b77360f92e671504ba1e42822fb727dc938f17d401a79ccc0f8b', '2024-12-01 20:41:41.185', '20241201204134_correction_bdd', NULL, NULL, '2024-12-01 20:41:34.452', 1),
('765ce6ad-0c28-470e-8f63-04b865d52774', 'b0286ad1f56b45dabf5525854edec6855aba675afc8302c3e4652f5addaeeb02', '2024-12-01 19:54:23.539', '20241201195402_create_bdd', NULL, NULL, '2024-12-01 19:54:02.466', 1),
('e22bc5f2-4357-44b8-8159-69bd88c91dcc', 'c02747fbba62f272e093959c4257cec65eae4151326ef2d5b15059655faeb1c7', '2024-12-10 21:57:11.088', '20241210215709_transformer_le_champs_datefermeture', NULL, NULL, '2024-12-10 21:57:09.354', 1),
('e7963a45-6e89-4f68-abf0-9b0b34fef345', '88c7d73118946798cde9d9cd5d25f54238c60777deafcf62336af5618d6cbe53', '2024-12-10 14:35:01.892', '20241210143500_ajout_du_champ_date_dans_filliere', NULL, NULL, '2024-12-10 14:35:01.583', 1),
('e9af71ad-93ff-4191-8b8e-a80174d7331b', 'eeaee42f87f5b849759dd8b52598a2a5034d46294299ee043963955ca914d87f', '2024-12-01 20:18:13.940', '20241201201809_correction_bdd', NULL, NULL, '2024-12-01 20:18:09.686', 1);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `cours`
--
ALTER TABLE `cours`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Cours_idPromotion_fkey` (`idPromotion`);

--
-- Index pour la table `courslance`
--
ALTER TABLE `courslance`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `CoursLance_idCours_key` (`idCours`),
  ADD KEY `CoursLance_idTuteur_fkey` (`idTuteur`),
  ADD KEY `CoursLance_idResponsableTutorat_fkey` (`idResponsableTutorat`);

--
-- Index pour la table `demandeencadrement`
--
ALTER TABLE `demandeencadrement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `DemandeEncadrement_idEtudiant_fkey` (`idEtudiant`),
  ADD KEY `DemandeEncadrement_idCours_fkey` (`idCours`);

--
-- Index pour la table `etudiant`
--
ALTER TABLE `etudiant`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Etudiant_matricule_key` (`matricule`),
  ADD KEY `Etudiant_idPromotion_fkey` (`idPromotion`);

--
-- Index pour la table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Feedback_idCoursLance_fkey` (`idCoursLance`),
  ADD KEY `Feedback_idEtudiant_fkey` (`idEtudiant`),
  ADD KEY `Feedback_idCategorie_fkey` (`idCategorie`);

--
-- Index pour la table `filiere`
--
ALTER TABLE `filiere`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `promotion`
--
ALTER TABLE `promotion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Promotion_idFiliere_fkey` (`idFiliere`);

--
-- Index pour la table `responsabletutorat`
--
ALTER TABLE `responsabletutorat`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ResponsableTutorat_idUtilisateur_key` (`idUtilisateur`);

--
-- Index pour la table `seance`
--
ALTER TABLE `seance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Seance_idCoursLance_fkey` (`idCoursLance`);

--
-- Index pour la table `tuteur`
--
ALTER TABLE `tuteur`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Tuteur_email_key` (`email`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Utilisateur_email_key` (`email`);

--
-- Index pour la table `_prisma_migrations`
--
ALTER TABLE `_prisma_migrations`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `categorie`
--
ALTER TABLE `categorie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `cours`
--
ALTER TABLE `cours`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT pour la table `courslance`
--
ALTER TABLE `courslance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `demandeencadrement`
--
ALTER TABLE `demandeencadrement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `etudiant`
--
ALTER TABLE `etudiant`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `filiere`
--
ALTER TABLE `filiere`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `promotion`
--
ALTER TABLE `promotion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `responsabletutorat`
--
ALTER TABLE `responsabletutorat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `seance`
--
ALTER TABLE `seance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `tuteur`
--
ALTER TABLE `tuteur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `cours`
--
ALTER TABLE `cours`
  ADD CONSTRAINT `Cours_idPromotion_fkey` FOREIGN KEY (`idPromotion`) REFERENCES `promotion` (`id`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `courslance`
--
ALTER TABLE `courslance`
  ADD CONSTRAINT `CoursLance_idCours_fkey` FOREIGN KEY (`idCours`) REFERENCES `cours` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `CoursLance_idResponsableTutorat_fkey` FOREIGN KEY (`idResponsableTutorat`) REFERENCES `responsabletutorat` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `CoursLance_idTuteur_fkey` FOREIGN KEY (`idTuteur`) REFERENCES `tuteur` (`id`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `demandeencadrement`
--
ALTER TABLE `demandeencadrement`
  ADD CONSTRAINT `DemandeEncadrement_idCours_fkey` FOREIGN KEY (`idCours`) REFERENCES `cours` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `DemandeEncadrement_idEtudiant_fkey` FOREIGN KEY (`idEtudiant`) REFERENCES `etudiant` (`id`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `etudiant`
--
ALTER TABLE `etudiant`
  ADD CONSTRAINT `Etudiant_idPromotion_fkey` FOREIGN KEY (`idPromotion`) REFERENCES `promotion` (`id`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `Feedback_idCategorie_fkey` FOREIGN KEY (`idCategorie`) REFERENCES `categorie` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Feedback_idCoursLance_fkey` FOREIGN KEY (`idCoursLance`) REFERENCES `courslance` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Feedback_idEtudiant_fkey` FOREIGN KEY (`idEtudiant`) REFERENCES `etudiant` (`id`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `promotion`
--
ALTER TABLE `promotion`
  ADD CONSTRAINT `Promotion_idFiliere_fkey` FOREIGN KEY (`idFiliere`) REFERENCES `filiere` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `responsabletutorat`
--
ALTER TABLE `responsabletutorat`
  ADD CONSTRAINT `ResponsableTutorat_idUtilisateur_fkey` FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateur` (`id`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `seance`
--
ALTER TABLE `seance`
  ADD CONSTRAINT `Seance_idCoursLance_fkey` FOREIGN KEY (`idCoursLance`) REFERENCES `courslance` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
