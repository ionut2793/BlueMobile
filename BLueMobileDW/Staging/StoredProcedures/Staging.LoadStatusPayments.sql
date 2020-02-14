USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadStatusPayments
GO
 
CREATE PROCEDURE Staging.LoadStatusPayments
AS 
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[StatusPayments]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[StatusPayments] ([iStatusPaymentID],[vcStatusPayment],[sdtDateCreated])
	SELECT

		 [iStatusPaymentID]
		,[vcStatusPayment]
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[StatusPayments]
END