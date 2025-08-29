--Pour trouver le code de création utilisez <EXEC sp_helptext 'GetTicketsByStatus';> dans SSMS--

CREATE PROCEDURE [dbo].[GetAllTickets]  
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    SELECT   
        t.id_ticket,  
        t.resolution,  
        t.probleme,  
        t.staut,  
        t.date_creation,  
        v.numero_version,  
        p.nom_produit  
    FROM Ticket t  
    JOIN Version v ON t.id_version = v.id_version  
    JOIN Produit p ON v.id_produit = p.id_produit;  
END;  

----------------------------------------------------------------
CREATE PROCEDURE [dbo].[GetTicketsByKeywords]  
    @mots_cles NVARCHAR(MAX)  
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    DECLARE @Keywords TABLE (mot NVARCHAR(100));  
  
    IF @mots_cles IS NOT NULL AND LTRIM(RTRIM(@mots_cles)) <> ''  
    BEGIN  
        INSERT INTO @Keywords(mot)  
        SELECT LTRIM(RTRIM(value))  
        FROM STRING_SPLIT(@mots_cles, ',');  
    END  
  
    SELECT   
        t.id_ticket, t.resolution, t.probleme, t.staut, t.date_creation,  
        v.numero_version, p.nom_produit  
    FROM Ticket t  
    JOIN Version v ON t.id_version = v.id_version  
    JOIN Produit p ON v.id_produit = p.id_produit  
    WHERE EXISTS (  
        SELECT 1 FROM @Keywords k  
        WHERE t.probleme LIKE '%' + k.mot + '%'  
           OR t.resolution LIKE '%' + k.mot + '%'  
    );  
END;  


----------------------------------------------------------------
CREATE PROCEDURE [dbo].[GetTicketsByProduct]  
    @id_produit INT  
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    SELECT   
        t.id_ticket, t.resolution, t.probleme, t.staut, t.date_creation,  
        v.numero_version, p.nom_produit  
    FROM Ticket t  
    JOIN Version v ON t.id_version = v.id_version  
    JOIN Produit p ON v.id_produit = p.id_produit  
    WHERE v.id_produit = @id_produit;  
END;  


----------------------------------------------------------------
CREATE PROCEDURE [dbo].[GetTicketsByStatus]  
    @statut NVARCHAR(50)  
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    SELECT   
        t.id_ticket, t.resolution, t.probleme, t.staut, t.date_creation,  
        v.numero_version, p.nom_produit  
    FROM Ticket t  
    JOIN Version v ON t.id_version = v.id_version  
    JOIN Produit p ON v.id_produit = p.id_produit  
    WHERE t.staut = @statut;  
END;  


----------------------------------------------------------------
CREATE PROCEDURE [dbo].[ObtenirTickets]  
    @statut NVARCHAR(50) = NULL,               -- 'ouvert' 'en cours' 'résolu'  
    @id_produit INT = NULL,  
    @id_version INT = NULL,  
    @date_debut DATE = NULL,  
    @date_fin DATE = NULL,  
    @mots_cles NVARCHAR(MAX) = NULL             
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    -- Split keywords into a table variable  
    DECLARE @Keywords TABLE (mot NVARCHAR(100));  
  
    IF @mots_cles IS NOT NULL AND LTRIM(RTRIM(@mots_cles)) <> ''  
    BEGIN  
        INSERT INTO @Keywords(mot)  
        SELECT LTRIM(RTRIM(value))  
        FROM STRING_SPLIT(@mots_cles, ',');  
    END  
  
    SELECT   
        t.id_ticket,  
        t.resolution,  
        t.probleme,  
        t.staut,                    
        t.date_creation,  
        v.numero_version,  
        p.nom_produit  
    FROM Ticket t  
    JOIN Version v ON t.id_version = v.id_version  
    JOIN Produit p ON v.id_produit = p.id_produit  
    WHERE   
        (@statut IS NULL OR t.staut = @statut)  
        AND (@id_produit IS NULL OR v.id_produit = @id_produit)  
        AND (@id_version IS NULL OR t.id_version = @id_version)  
        AND (@date_debut IS NULL OR t.date_creation >= @date_debut)  
        AND (@date_fin IS NULL OR t.date_creation <= @date_fin)  
        AND (  
            -- If no keywords, skip this filter  
            NOT EXISTS (SELECT 1 FROM @Keywords)  
            -- Otherwise, check if any keyword matches probleme or resolution  
            OR EXISTS (  
                SELECT 1 FROM @Keywords k  
                WHERE t.probleme LIKE '%' + k.mot + '%'  
                   OR t.resolution LIKE '%' + k.mot + '%'  
            )  
        );  
END;  

