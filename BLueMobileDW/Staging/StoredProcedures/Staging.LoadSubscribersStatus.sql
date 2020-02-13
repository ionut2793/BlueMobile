USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadSubscribersStatus
GO
 
CREATE PROCEDURE Staging.LoadSubscribersStatus
AS 
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[SubscribersStatus]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[SubscribersStatus] ([iStatusSubscriberID],[vcSubscriberStatusName],[sdtDateCreated])
	SELECT

		 [iStatusSubscriberID]
		,[vcSubscriberStatusName]
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[SubscribersStatus]
END