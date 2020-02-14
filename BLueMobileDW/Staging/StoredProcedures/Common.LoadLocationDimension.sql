USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Common.LoadLocationDimension
GO
 
CREATE PROCEDURE Common.LoadLocationDimension

AS 
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Common].[LocationDimension]
    DECLARE @sdtDateCreated datetime=getdate()
	INSERT INTO [BlueMobileDW].[Common].[LocationDimension] ([iLocationID],[vcStreet],[vcCity],[vcState],[vcCountry],[vcAddressTypeName],[sdtDateCreated])
	SELECT

		   A.[iAddressID]
		  ,A.[vcStreet]
		  ,A.[vcCity]
		  ,A.[vcState]
		  ,A.[vcCountry]
		  ,B.[vcAddressTypeName]
		  ,@sdtDateCreated
      
	FROM [BlueMobileDW].[Staging].[Addresses] as A
	INNER JOIN [BlueMobileDW].[Staging].[AddressTypes] as B
	on A.iTypeAddressIDFK=B.iTypeAddressID
END