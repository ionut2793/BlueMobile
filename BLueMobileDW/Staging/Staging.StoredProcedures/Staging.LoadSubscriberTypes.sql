USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadSubscriberTypes
GO
 
CREATE PROCEDURE Staging.LoadSubscriberTypes
AS
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[SubscriberTypes]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[SubscriberTypes] ([iSubscriberTypeID],[vcSubscriberTypeName],[sdtDateCreated])
	SELECT

		 [iSubscriberTypeID]
		,[vcSubscriberTypeName]
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[SubscriberTypes]
END