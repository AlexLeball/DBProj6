DBProj6 – NexaWorks Project
📌 Description

NexaWorks est une base de données conçue pour la gestion de tickets liés à différents produits logiciels et leurs versions.
Ce projet inclut :

Le modèle entité–association (ERD).

Le script SQL pour créer et remplir la base avec 25 tickets d’exemple.

Des procédures stockées pour interroger les tickets selon différents critères.

🗂 Modèle entité–association
<img width="838" height="820" alt="ERD NexaWorks" src="https://github.com/user-attachments/assets/b40dd33b-7f26-41a6-bc59-ee7c410a1aca" />
⚙️ Prérequis

SQL Server 2019 ou supérieur

SQL Server Management Studio (SSMS) installé

Fichier dump SQL fourni : FinalDBscript.sql

💾 Installation à partir du dump SQL

Ouvrir SSMS et se connecter à votre instance SQL Server.

Créer la base de données (optionnel si non incluse dans le dump) :

CREATE DATABASE NexaWorks_Project;
GO


Restaurer la base à partir du fichier dump :

Dans SSMS, cliquez sur File → Open → File… et sélectionnez FinalDBscript.sql.

Vérifiez que le script s’ouvre correctement dans l’éditeur SQL.

Exécutez le script complet en appuyant sur F5.

Le script créera les tables.

Il insérera les 25 tickets d’exemple.

Il définira toutes les contraintes et relations.

Vérifier la restauration :

USE NexaWorks_Project;
SELECT TOP 10 * FROM Ticket;


Vous devriez voir les 25 tickets d’exemple.

🗂 Structure de la base

Tables principales :

Table	Champs
Produit	id_produit, nom_produit
Version	id_version, numero_version, id_produit
Système d’exploitation	id_os, nom_os
Compatibilité	id_version, id_os
Ticket	id_ticket, id_version, id_os, date_creation, date_resolution, statut, probleme, resolution

Relations :

Un produit possède plusieurs versions.

Une version peut être compatible avec plusieurs systèmes d’exploitation.

Un ticket est lié à une version et à un OS spécifique.

🧰 Procédures stockées disponibles
Procédure	Description
GetAllTickets	Liste tous les tickets
GetTicketsByDateRange @date_debut, @date_fin	Filtre les tickets par date de création
GetTicketsByProduct @id_produit	Filtre les tickets par produit
GetTicketsByStatus @statut	Filtre les tickets par statut
GetTicketsByKeywords @mots_cles	Recherche les tickets par mots-clés
ObtenirTickets	Filtre combiné flexible selon plusieurs critères
