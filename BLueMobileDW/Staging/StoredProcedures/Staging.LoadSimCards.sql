USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadSimCards
GO
 
CREATE PROCEDURE Staging.LoadSimCards
AS 
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[SimCards]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[SimCards] ([iSimCardID],[vcPhoneNumber],[vcPINNumber],[vcPUKNumber],[vcIMEINumber],[vcSerialNumber],[sdtDateCreated])
	SELECT

		 [iSimCardID]
		,[vcPhoneNumber]
		,[vcPINNumber]
		,[vcPUKNumber]
		,[vcIMEINumber]
		,[vcSerialNumber]
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[SimCards]
END