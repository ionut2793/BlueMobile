USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadSubscribers
GO
 
CREATE PROCEDURE Staging.LoadSubscribers
AS 
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[Subscribers]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[Subscribers] ([iSubscriberID],[vcFirstName],[vcLastName],[vcContactDetail],[iStatusSubscriberIDFK],[iSubscriberTypeIDFK],[vcPersonalCodeIdentification],[dtJoinDate],[sdtDateCreated])
	SELECT

		 [iSubscriberID]
		,[vcFirstName]
		,[vcLastName]
		,[vcContactDetail]
		,[iStatusSubscriberIDFK]
		,[iSubscriberTypeIDFK]
		,[vcPersonalCodeIdentification]
		,[dtJoinDate]
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[Subscribers]
END