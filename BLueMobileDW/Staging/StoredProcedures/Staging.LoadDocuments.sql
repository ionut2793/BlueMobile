USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadDocuments
GO
 
CREATE PROCEDURE Staging.LoadDocuments

AS 
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[Documents]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[Documents] ([iDocumentID],[iDocumentTypeIDFK],[iSubscriberIDFK],[iSimCardIDFK],[iProductIDFK],[dtStartDate],[dtEndDate],[iDocumentStatusIDFK],[iSubscriptionID],[dtDueDate],[dtCancelDate],[sdtDateCreated])
	SELECT

		 [iDocumentID]
		,[iDocumentTypeIDFK]
		,[iSubscriberIDFK]
		,[iSimCardIDFK]
		,[iProductIDFK]
		,[dtStartDate]
		,[dtEndDate]
		,[iDocumentStatusIDFK]
		,[iSubscriptionID]
		,[dtDueDate]
		,[dtCancelDate]
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[Documents]
END