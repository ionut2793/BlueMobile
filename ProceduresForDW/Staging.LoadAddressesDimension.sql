use [BlueMobileDW]
go

drop procedure if exists Staging.LoadAddressesDimension
go

create procedure Staging.LoadAddressesDimension

as 
Begin

	truncate  table [BlueMobileDW].[Staging].[Addresses]
    Declare @sdtDateCreated datetime=getdate()
	insert into [BlueMobileDW].[Staging].[Addresses] ([iAddressID],[iSubscriberIDFK],[vcStreet],[iHouseNumber],[vcCity],[vcState],[vcCountry],[iPhoneNumber],[nvcEmail],[cZipCode],[iTypeAddressIDFK],[sdtDateCreated])
	select

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
      ,[iTypeAddressIDFK],
	   @sdtDateCreated
      
	from [BlueMobile].[dbo].[Addresses]
End