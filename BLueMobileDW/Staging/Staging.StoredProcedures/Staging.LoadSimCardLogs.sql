USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadSimCardLogs
GO
 
CREATE PROCEDURE Staging.LoadSimCardLogs
AS 
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[SimCardLogs]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[SimCardLogs] ([iCallLogID],[iLogTypeIDFK],[iSubscriberIDFK],[iSimCardIDFK],[vcPhoneNumber],[dtSimCardLogDateTime],[dtStartDateTime],[dtEndDateTime],[sdtDateCreated])
	SELECT

		 [iCallLogID]
		,[iLogTypeIDFK]
		,[iSubscriberIDFK]
		,[iSimCardIDFK]
		,[vcPhoneNumber]
		,[dtSimCardLogDateTime]
		,[dtStartDateTime]
		,[dtEndDateTime]
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[SimCardLogs]
END