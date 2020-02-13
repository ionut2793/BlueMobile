USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadAddresses
GO
 
CREATE PROCEDURE Staging.LoadAddresses

AS 
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[Addresses]
    DECLARE @sdtDateCreated datetime=getdate()
	INSERT INTO [BlueMobileDW].[Staging].[Addresses] ([iAddressID],[iSubscriberIDFK],[vcStreet],[iHouseNumber],[vcCity],[vcState],[vcCountry],[iPhoneNumber],[nvcEmail],[cZipCode],[iTypeAddressIDFK],[sdtDateCreated])
	SELECT

		   [iAddressID]
		  ,[iSubscriberIDFK]
		  ,[vcStreet]
		  ,[iHouseNumber]
		  ,[vcCity]
		  ,[vcState]
		  ,[vcCountry]
		  ,[iPhoneNumber]
		  ,[nvcEmail]
		  ,[cZipCode]
		  ,[iTypeAddressIDFK]
		  ,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[Addresses]
END