USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadCalculateRewardPoints
GO
 
CREATE PROCEDURE Staging.LoadCalculateRewardPoints

AS 
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[CalculateRewardPoints]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[CalculateRewardPoints] ([iCalculRewardPointID],[iRewardPointsRulesIDFK],[iDocumentIDFK],[bIsActive],[dtEffectiveFromDate],[dtEffectiveToDate],[iRewardPointTotal],[sdtDateCreated])
	SELECT

		 [iCalculRewardPointID]
		,[iRewardPointsRulesIDFK]
		,[iDocumentIDFK]
		,[bIsActive]
		,[dtEffectiveFromDate]
		,[dtEffectiveToDate]
		,[iRewardPointTotal]
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[CalculateRewardPoints]
END