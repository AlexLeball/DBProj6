# DBProj6
NexaworksProjet

## 🗂 Modèle entité–association
doc/ERD
<img width="838" height="820" alt="image" src="https://github.com/user-attachments/assets/b40dd33b-7f26-41a6-bc59-ee7c410a1aca" />

**Produit** (id_produit, nom_produit) - 
**Version** (id_version, numero_version, id_produit) - 
**Système d’exploitation** (id_os, nom_os) -
**Compatibilité** (id_version, id_os) - 
**Ticket** (id_ticket, id_version, id_os, date_creation, date_resolution, statut, problème, résolution) 

Relations : 
Un produit possède plusieurs versions. 
Une version peut être compatible avec plusieurs OS. 
Un ticket est lié à une version et un OS.


## ⚙️ Installation Dans SQL Server Management Studio (SSMS) :
sql
USE master;
GO
CREATE DATABASE NexaWorks_Project;
GO
USE NexaWorks_Project;
GO
:r .\sql\NexaWorks_Project.sql
