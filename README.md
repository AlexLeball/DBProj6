# DBProj6 – NexaWorks Project

## 📌 Description

NexaWorks est une base de données conçue pour la gestion de tickets liés à différents produits logiciels et leurs versions.  
Ce projet inclut :

- Le modèle entité–association (ERD)
- Le script SQL pour créer et remplir la base avec 25 tickets d’exemple
- Des procédures stockées pour interroger les tickets selon différents critères

---

## 🗂 Modèle entité–association

![ERD NexaWorks](https://github.com/user-attachments/assets/b40dd33b-7f26-41a6-bc59-ee7c410a1aca)

---

## ⚙️ Prérequis

- SQL Server 2019 ou supérieur
- SQL Server Management Studio (SSMS) installé
- Fichier dump SQL fourni : `FinalDBscript.sql`

---

## 💾 Installation à partir du dump SQL

1. Ouvrir SSMS et se connecter à votre instance SQL Server.
2. **Créer la base de données** (optionnel si non incluse dans le dump) :

    ```sql
    CREATE DATABASE NexaWorks_Project;
    GO
    ```

3. **Restaurer la base à partir du fichier dump** :
    - Dans SSMS, cliquez sur **File → Open → File…** et sélectionnez `FinalDBscript.sql`.
    - Vérifiez que le script s’ouvre correctement dans l’éditeur SQL.
    - Exécutez le script complet en appuyant sur **F5**.
    - Le script créera les tables, insérera les 25 tickets d’exemple et définira toutes les contraintes et relations.

4. **Vérifier la restauration** :

    ```sql
    USE NexaWorks_Project;
    SELECT * FROM Ticket;
    ```

    Vous devriez voir les 25 tickets d’exemple.

---

## 🗂 Structure de la base

### Tables principales

| Table                   | Champs                                                            |
|-------------------------|-------------------------------------------------------------------|
| Produit                 | `id_produit`, `nom_produit`                                      |
| Version                 | `id_version`, `numero_version`, `id_produit`                     |
| Système d’exploitation  | `id_os`, `nom_os`                                                |
| Compatibilité           | `id_version`, `id_os`                                            |
| Ticket                  | `id_ticket`, `id_version`, `id_os`, `date_creation`, `date_resolution`, `statut`, `probleme`, `resolution` |

### Relations

- Un produit possède plusieurs versions.
- Une version peut être compatible avec plusieurs systèmes d’exploitation.
- Un ticket est lié à une version et à un OS spécifique.

---

## 🧰 Procédures stockées disponibles

| Procédure                   | Description                                      |
|-----------------------------|--------------------------------------------------|
| `GetAllTickets`             | Liste tous les tickets                           |
| `GetTicketsByDateRange`     | Filtre les tickets par date de création<br>**Paramètres** : `@date_debut`, `@date_fin`        |
| `GetTicketsByProduct`       | Filtre les tickets par produit<br>**Paramètre** : `@id_produit`           |
| `GetTicketsByStatus`        | Filtre les tickets par statut<br>**Paramètre** : `@statut`                |
| `GetTicketsByKeywords`      | Recherche les tickets par mots-clés<br>**Paramètre** : `@mots_cles`        |
| `ObtenirTickets`            | Filtre combiné flexible selon plusieurs critères  |

---
## 🚀 Utilisation – Exemples de requêtes

Exécuter les procédures stockées dans SSMS :
-- Lister tous les tickets
EXEC GetAllTickets;

-- Tickets créés entre deux dates
EXEC GetTicketsByDateRange '2025-01-05', '2025-12-31';

-- Tickets pour un produit donné
EXEC GetTicketsByProduct 2;

-- Tickets avec statut "Ouvert"
EXEC GetTicketsByStatus 'Ouvert';

-- Recherche par mot-clé
EXEC GetTicketsByKeywords 'crash';


