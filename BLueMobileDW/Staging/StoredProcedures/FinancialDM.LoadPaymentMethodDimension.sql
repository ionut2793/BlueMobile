USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists FinancialDM.LoadPaymentMethodDimension
GO
 
CREATE PROCEDURE FinancialDM.LoadPaymentMethodDimension

AS 
BEGIN

    DECLARE @sdtDateCreated datetime=getdate()

	MERGE [BlueMobileDW].[FinancialDM].[PaymentMethodDimension] AS t
	USING [Staging].[PaymentMethods] AS tab1 ON
	t.iPaymentMethodID= tab1.iPaymentMethodID

	WHEN not matched THEN
		INSERT VALUES 
		(

		 tab1.[iPaymentMethodID]
		,tab1.[vcPaymentMethodName]
		,getdate()

		)

	WHEN matched AND
		( 
		 t.[vcPaymentMethodName]   <> tab1.[vcPaymentMethodName] 
		)

	THEN UPDATE SET

		 t.[vcPaymentMethodName]   = tab1.[vcPaymentMethodName], 
		 t.[sdtDateCreated]        = getdate();

END