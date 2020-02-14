USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadTransactions
GO
 
CREATE PROCEDURE Staging.LoadTransactions
AS
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[Transactions]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[Transactions] ([iTransactionID],[iDocumentIDFK],[iPaymentIDFK],[iTransactionTypeIDFK],[dtTransactionDate],[sdtDateCreated])
	SELECT

		 [iTransactionID]
		,[iDocumentIDFK]
		,[iPaymentIDFK]
		,[iTransactionTypeIDFK]
		,[dtTransactionDate]
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[Transactions]
END