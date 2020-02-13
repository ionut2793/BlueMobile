USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadDocumentTypes
GO
 
CREATE PROCEDURE Staging.LoadDocumentTypes
AS 
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[DocumentTypes]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[DocumentTypes] ([iDocumentTypeID],[vcDocumentTypeName],[sdtDateCreated])
	SELECT

		 [iDocumentTypeID]
		,[vcDocumentTypeName]
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[DocumentTypes]
END