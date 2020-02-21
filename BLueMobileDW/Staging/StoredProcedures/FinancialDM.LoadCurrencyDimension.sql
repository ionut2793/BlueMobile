USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists FinancialDM.LoadCurrencyDimension
GO
 
CREATE PROCEDURE FinancialDM.LoadCurrencyDimension

AS 
BEGIN

    DECLARE @sdtDateCreated datetime=getdate()


	MERGE [BlueMobileDW].[FinancialDM].[CurrencyDimension] AS t
	USING [BlueMobileDW].[Staging].[CurrencyTypes]         AS tab1 
	ON t.iCurrencyID= tab1.iCurrencyID

	WHEN not matched THEN
		INSERT VALUES 
		(

		 tab1.[iCurrencyID]
		,tab1.[vcCurrencyTypeName]
		,getdate()

		)

	WHEN matched AND
	(

	 t.[vcCurrencyTypeName] <> tab1.[vcCurrencyTypeName]   

	 )

	THEN UPDATE SET

	 t.[vcCurrencyTypeName] = tab1.[vcCurrencyTypeName], 
     t.[sdtDateCreated]     = getdate();

END