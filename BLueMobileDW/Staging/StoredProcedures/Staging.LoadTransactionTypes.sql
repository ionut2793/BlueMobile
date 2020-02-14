USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadTransactionTypes
GO
 
CREATE PROCEDURE Staging.LoadTransactionTypes
AS
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[TransactionTypes]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[TransactionTypes] ([iTransactionTypeID],[vcTransactionType],[sdtDateCreated])
	SELECT

		 [iTransactionTypeID]
		,[vcTransactionType]	
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[TransactionTypes]
END