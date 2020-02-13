USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadDocumentsStatus
GO
 
CREATE PROCEDURE Staging.LoadDocumentsStatus

AS 
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[DocumentsStatus]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[DocumentsStatus] ([iDocumentStatusID],[vcDocumentStatusName],[sdtDateCreated])
	SELECT

		 [iDocumentStatusID]
		,[vcDocumentStatusName]
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[DocumentsStatus]
END