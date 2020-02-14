USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadCurrencyTypes
GO
 
CREATE PROCEDURE Staging.LoadCurrencyTypes

AS 
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[CurrencyTypes]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[CurrencyTypes] ([iCurrencyID],[vcCurrencyTypeName],[sdtDateCreated])
	SELECT

		 [iCurrencyID]
		,[vcCurrencyTypeName]
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[CurrencyTypes]
END