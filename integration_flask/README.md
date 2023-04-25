# Crud_flutter_flask

Ce projet est une application mobile de gestion de clients développée en Flutter et qui communique avec une API en Python Flask dans le but d'apprendre à faire un CRUD (Create Read Update Delete) .

## Fonctionnalités

- Affichage de la liste des clients
- Ajout d'un nouveau client
- Modification des informations d'un client
- Suppression d'un client existant 
- Authentification

## Installation

**Prérequis**

- Flutter 2.2.3 ou supérieur
- Flask


## Étapes d'installation

1. Clonez le dépôt Git
2. Ouvrez un terminal et naviguez vers le dossier contenant l'application que vous voulez lancer
3. Initialisation de la database

Pour initialiser la base de données importer le fichier fullstack_flask_flutter.sql dans phpmyadmin de wamp server et exécutez


4. Lancez l'API de Flask 

- Pour ce faire, assurez vous d'abord d'avoir crée l'environement virtuel .Puis vous devez ensuite aller dans le terminal à l'adresse"\FullStack_integrationFlask\BackEnd\test_avec_db.py" et exécuter les commande ci-dessous 

```
$ pip install flask
$ pip install flask-sqlalchemy 
```
Pour crée l'environement virtuel faite 
```
python -m venv env
```
puis activer en allant dans env\Scripts\activate

- Puis définissez le project en entrant la commande suivante

```
$env:FLASK_APP="test_avec_db.py"
```

- Enfin lancer le projet avec la commande

```
$ flask run
```


5. Pour l'application flutter installer les dépendances en exécutant la commande 

```
flutter pub get 
```
dans le dossier "\FullStack_integrationFlask\integration_flask" de votre terminal 

6. Lancez l'application en exécutant la commande 

```
flutter run 
```

## Utilisation

- Authentification : Faites l'authentification avec les informations par défaut de la basse de données suivantes : vianney comme nom d'utilisateur et 123 comme mot de passe
- Affichage de la liste des clients : accédez à la page principale de l'application après l'authentification
- Ajout d'un nouveau client : cliquez sur le bouton flottant "Ajouter un client", remplissez les champs du formulaire et cliquez sur "Sauvegarder"
- Suppression d'un client existant : glissez sur le client dans la liste pour faire apparaître l'icône de suppression, puis cliquez sur cette icône pour confirmer la suppression



