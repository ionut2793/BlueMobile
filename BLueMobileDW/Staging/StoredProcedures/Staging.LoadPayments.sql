USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadPayments
GO
 
CREATE PROCEDURE Staging.LoadPayments
AS 
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[Payments]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[Payments] ([iPaymentID],[iSubscriberIDFK],[mPaymentAmount],[mPenaltyCost],[mTotalCost],[dPaymentDate],[dtPaymentDate],[iPaymentMethodIDFK],[iStatusPaymentIDFK],[iDocumentIDFK],[iRewardPointsRulesIDFK],[iCurrencyIDFK],[sdtDateCreated])
	SELECT

		 [iPaymentID]
		,[iSubscriberIDFK]
		,[mPaymentAmount]
		,[mPenaltyCost]
		,[mTotalCost]
		,cast([dtPaymentDate] as date)
		,[dtPaymentDate]
		,[iPaymentMethodIDFK]
		,[iStatusPaymentIDFK]
		,[iDocumentIDFK]
		,[iRewardPointsRulesIDFK]
		,[iCurrencyIDFK]
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[Payments]
	order by [iPaymentID]
END