USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadAddressTypes
GO
 
CREATE PROCEDURE Staging.LoadAddressTypes

AS 
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[AddressTypes]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[AddressTypes] ([iTypeAddressID],[vcAddressTypeName],[sdtDateCreated])
	SELECT
	
		 [iTypeAddressID]
		,[vcAddressTypeName]
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[AddressTypes]
END