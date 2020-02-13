USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadLogTypes
GO
 
CREATE PROCEDURE Staging.LoadLogTypes
AS 
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[LogTypes]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[LogTypes] ([iLogTypeID],[vcCallTypeName],[sdtDateCreated])
	SELECT

		 [iLogTypeID]
		,[vcCallTypeName]
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[LogTypes]
END