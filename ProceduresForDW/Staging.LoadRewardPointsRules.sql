USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadRewardPointsRules
GO
 
CREATE PROCEDURE Staging.LoadRewardPointsRules
AS 
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[RewardPointsRules]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[RewardPointsRules] ([iRewardPointsRulesID],[mRequiredAmout],[iRewardPoint],[mRewardValue],[dtStartOffer],[dtEndOffer],[sdtDateCreated])
	SELECT

		 [iRewardPointsRulesID]
		,[mRequiredAmout]
		,[iRewardPoint]
		,[mRewardValue]
		,[dtStartOffer]
		,[dtEndOffer]
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[RewardPointsRules]
END