USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadPaymentMethods
GO
 
CREATE PROCEDURE Staging.LoadPaymentMethods
AS 
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[PaymentMethods]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[PaymentMethods] ([iPaymentMethodID],[vcPaymentMethodName],[sdtDateCreated])
	SELECT

		 [iPaymentMethodID]
		,[vcPaymentMethodName]
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[PaymentMethods]
END