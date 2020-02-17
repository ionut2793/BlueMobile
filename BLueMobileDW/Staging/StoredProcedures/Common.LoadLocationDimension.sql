USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Common.LoadLocationDimension
GO
 
CREATE PROCEDURE Common.LoadLocationDimension

AS 
BEGIN

    DECLARE @sdtDateCreated datetime=getdate()
	DROP TABLE  IF exists tempdb.#tmp1

	SELECT

		   A.[iAddressID]
		  ,A.[vcStreet]
		  ,A.[vcCity]
		  ,A.[vcState]
		  ,A.[vcCountry]
		  ,B.[vcAddressTypeName]
		
	into #tmp1   
	FROM [BlueMobileDW].[Staging].[Addresses] AS A
	INNER JOIN [BlueMobileDW].[Staging].[AddressTypes] AS B
	ON A.iTypeAddressIDFK=B.iTypeAddressID


	MERGE [BlueMobileDW].[Common].[LocationDimension] AS t
	USING (	select top 100 percent *from #tmp1 order by iAddressID ) as tab1 ON
	t.iLocationID= tab1.iAddressID

	WHEN not matched THEN
		INSERT VALUES (
	
		 tab1.[iAddressID]
		,tab1.[vcStreet]
		,tab1.[vcCity]
		,tab1.[vcState]
		,tab1.[vcCountry]
		,tab1.[vcAddressTypeName]
		,getdate()
		)

	WHEN matched AND
	(
	 t.[iLocationID]	   <> tab1.[iAddressID] OR 
	 t.[vcStreet]		   <> tab1.[vcStreet]   OR 
	 t.[vcCity]            <> tab1.[vcCity]     OR
	 t.[vcState]           <> tab1.[vcState]    OR 
	 t.[vcCountry]         <> tab1.[vcCountry]  OR  
	 t.[vcAddressTypeName] <> tab1.[vcAddressTypeName]
	 )

	THEN UPDATE SET
	 t.[iLocationID]	   = tab1.[iAddressID],
	 t.[vcStreet]		   = tab1.[vcStreet], 
	 t.[vcCity]            = tab1.[vcCity],
	 t.[vcState]           = tab1.[vcState],
	 t.[vcCountry]         = tab1.[vcCountry],
	 t.[vcAddressTypeName] = tab1.[vcAddressTypeName],
     t.[sdtDateCreated]    = getdate();

	END