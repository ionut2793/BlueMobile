USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadFavoriteNumbers
GO
 
CREATE PROCEDURE Staging.LoadFavoriteNumbers

AS 
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[FavoriteNumbers]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[FavoriteNumbers] ([iFavoritNumberID],[iSimCardIDFK],[vcFavoriteNumber],[sdtDateCreated])
	SELECT

		 [iFavoritNumberID]
		,[iSimCardIDFK]
		,[vcFavoriteNumber]
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[FavoriteNumbers]
END