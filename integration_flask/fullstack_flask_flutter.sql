-- phpMyAdmin SQL Dump
-- version 3.3.9
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- Généré le : Mar 25 Avril 2023 à 18:11
-- Version du serveur: 5.5.8
-- Version de PHP: 5.3.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `fullstack_flask_flutter`
--

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE IF NOT EXISTS `client` (
  `Id_clt` int(3) NOT NULL AUTO_INCREMENT,
  `Nom_clt` varchar(100) NOT NULL,
  `Contact` int(100) NOT NULL,
  PRIMARY KEY (`Id_clt`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `client`
--

INSERT INTO `client` (`Id_clt`, `Nom_clt`, `Contact`) VALUES
(1, 'FPPN', 707070707),
(2, 'Unicef', 2147483647),
(3, 'Port d''abidjan', 20212324);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE IF NOT EXISTS `utilisateur` (
  `Id_user` int(3) NOT NULL AUTO_INCREMENT,
  `Nom_user` varchar(30) NOT NULL,
  `Mdp` varchar(10) NOT NULL,
  PRIMARY KEY (`Id_user`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `utilisateur`
--

INSERT INTO `utilisateur` (`Id_user`, `Nom_user`, `Mdp`) VALUES
(1, 'vianney', '123');
