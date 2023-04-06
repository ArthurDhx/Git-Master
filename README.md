# Application Git'Master

Bonjour et bienvenue sur notre projet de GP dans le cadre des cours de gestion de projet en 2ème année de la filière apprentissage ! 


L'objectif premier de ce projet est de mettre en application les différentes méthodes de gestion de projet, notamment la gestion agile. Elle s'accentue notamment autour de la méthode agile SCRUM.

D'un point de vue fonctionnel, le projet a aussi pour finalité de proposer un outil aux enseignants de TELECOM Nancy afin de leur permettre de générer des groupes de dépôts GITLAB plus facilement. L'application doit inclure la création de groupe de dépôts, la gestion des élèves et des groupes d'élèves ainsi que leur affectation aux groupes GITLAB. Il est aussi souhaité d'inclure une fonctionnalité de "dashboard" pour voir l'avancée des élèves (nombre de commits, de fichiers transmis, ...) sur un dépôt en particulier.

Contraintes imposées pour le projet : 
- backend en python.
- se plier à l'existant pour les fonctionnalités liées à GITLAB.

Membres du groupe : 
- Sangoan BRIGUE
- Arthur DUHOUX
- Baptiste BRULLARD
- Lucas TABBONE
- Rémy HEANEAUX
- Maxime ISTACE

Evalutation du projet : Janvier 2023


# SETUP DE L'APPLICATION
## Création de la database (DB)

### Dans le cadre d'un hébergement local de la DB

Prendre le fichier script_DEV et l'exécuter sur un gestionnaire de base de données (comme PorstgreSQL ou DBeaver...). 
Le fichier se trouve dans le projet à l'emplacement suivant \backend\database\script_DEV.sql
La base de données sera ainsi enregistrée sur votre ordinateur. 

Le script_PROD est un script comportant de vraies informations (@mail, identifiant...). 
Dans le cadre de tests au développement de l'application, nous n'utiliserons pas ce script pour l'instant. 

Pour un bon fonctionnement de l'application, veuillez ensuite modifier le fichier "__init__.py".

La ligne suivante est à changer.
```
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://[NOM_UTILISATEUR]:[MOT_DE_PASSE]@localhost:5432/[NOM_DE_LA_DB]'
```
Vous devez renseigner les informations dans les [] (hormis le premier). Veuillez compléter avec les informations que vous avez choisies pour votre gestionnaire de données.

## Ajout d'un token GITLAB au compte sur lequel vous allez vous connecter 

Pour pouvoir effectuer les différentes requêtes vers l'API Gitlab, il faut que l'utilisateur connecté ait un token Gitlab enregistré en base de données. 

Par conséquent, il est nécessaire de renseigner le token Gitlab directement dans la base de données ou de modifier le script SQL au préalable.
Il est également possible, à la première connexion, de renseigner le token Gitlab directement sur le profil de l'utilisateur.

Pour des raisons de sécurité, nous n'avons pas renseigné de token Gitlab dans le script de base de données mais cela est nécessaire au bon fonctionnement de l'application !  

Procédure : 
- Aller sur votre profil GITLAB et dans l'édition du profil.
- Dans l'onglet "ACCESS TOKEN", générer un token avec les droits que vous estimez nécessaire.
- Récupérer le token généré, et insérer le dans la table "users" à la ligne vous correspondant ou directement sur votre profil dans l'application.


================================================

# LANCEMENT DE L'APPLICATION
## [1ère METHODE : Lancement via un script unique] 

- Tout d'abord, ouvrir un terminal à la racine du projet.

- Ensuite, se déplacer sur le dossier frontend avec la commande : 
```
cd ./frontend
```

### [Obligatoire] Installation des dépendances

Pour que le frontend fonctionne par la suite, il faut au préable installer un ensemble de dépendances :
```
npm install
```

- Et enfin, lancer une des commandes suivantes selon l'OS et l'outil de lancement de python dont vous disposez : 
```
npm run winpy           #Windows + py 
npm run winpython       #Windows + python
npm run winpython3      #Windows + python3
npm run linpy           #Linus ou MACos + py
npm run linpython       #Linus ou MACos + python
npm run linpython3      #Linus ou MACos + python3
```
ATTENTION : Ne pas hésitez à tester toutes les commandes rattachées à votre OS pour trouver celle qui vous correspond. 

Une fois tout ceci fait, l'application devrait être opérationelle.


## [2ème METHODE : Lancement via les lignes de commandes]
Pour cette méthode, il est nécessaire d'ouvrir 2 terminaux en parallèle. 
Le premier servira aux commandes spécifiques au backend.
Le second, quant à lui,  servira aux commandes spécifiques au frontend. 

Se déplacer aux endroits spécifiés : 
- Sous Linux
```powershell
$ ...\scrum_g1\ cd ./backend # Dans le 1er terminal 
$ ...\scrum_g1\ cd ./fronted # Dans le 2nd terminal
```

- Sous Windows
```powershell
PS ...\scrum_g1\ cd ./backend # Dans le 1er terminal 
PS ...\scrum_g1\ cd ./fronted # Dans le 2nd terminal
```

Nous allons maintenant pouvoir configurer le backend et le frontend.

## Configuration du backend

### [Conseillé] Mise en place d'un environnement virtuel python 

Pour mettre en place un environnement virtuel python (venv), il faut suivre les étapes suivantes :
- Sous Linux :
```sh
$ python -m venv env # Création de l'environnement
$ source env/bin/activate # Activation de l'environnement
```

- Sous Windows
```powershell
PS C:\> python -m venv env # Création de l'environnement
PS C:\> .\env\Scripts\activate # Activation de l'environnement
```

- Si besoin, pour désactiver l'environnement virtuel, il suffit d'écrire :
```
deactivate
```

### [Obligatoire] Installation des dépendances

Pour que le backend fonctionne, il faut installer au préalable un ensemble de dépendances :
```
pip install -r requirements.txt
```

- Note : Si on veut sauvegarder les dépendandes installées, on utilise :
```
pip freeze > requirements.txt
```
## Lancement du backend

Une fois les dépendances correctement installées, il ne reste plus qu'à lancer le backend de l'application en choisissant :
```
python app.py   #ou py app.py #ou python3 app.py
```

## Configuration du frontend

### [Obligatoire] Installation des dépendances
ATTENTION : Bien se placer dans le terminal prévu au frontend.

Pour que le frontend fonctionne, il faut installer au préalable un ensemble de dépendances :
```
npm install
```

## Lancement du frontend

Une fois les dépendances correctement installées, il ne reste plus qu'à lancer le frontend de l'application :
```
npm run serve
```

Une fois tout ceci fait, l'application devrait être opérationelle.


================================================
# ACCES A L'APPLICATION

Pour accéder à l'application, veuillez ouvrir un navigateur internet. 

Dans la barre d'URL, entrez : http://localhost:8080/

Connectez-vous avec votre compte. 

Vous avez ainsi accès à l'application !