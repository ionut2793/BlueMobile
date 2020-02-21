USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Common.LoadSubscriberDimension
GO
 
CREATE PROCEDURE Common.LoadSubscriberDimension

AS 
BEGIN

	DECLARE @dtEffectiveFromDatetime datetime=getdate()
	DECLARE @dtEffectiveToDatetime   datetime='9999-12-31'
	DECLARE @bIsActive               bit=1

	DROP TABLE  IF exists tempdb.#tmp1

	SELECT

		   A.[iSubscriberID]
		  ,A.[vcFirstName]
		  ,A.[vcLastName]
		  ,A.[vcContactDetail]
		  ,A.[dtJoinDate]
		  ,B.[vcSubscriberTypeName]
		
	into #tmp1   
	FROM [BlueMobileDW].[Staging].[Subscribers] AS A
	INNER JOIN [BlueMobileDW].[Staging].[SubscriberTypes] AS B
	ON A.iSubscriberTypeIDFK=B.iSubscriberTypeID

	select  *  from #tmp1

	INSERT INTO [BlueMobileDW].[Common].[SubscriberDimension]
	(
	    [iSubscriberID],
		[vcFirstName],
		[vcLastName],
		[vcContactDetail],
		[dtJoinDate],
		[vcSubscriberTypeName],
		[dtEffectiveFromDatetime],
		[dtEffectiveToDatetime],
		[bIsActive]
	)

	SELECT 
	    [iSubscriberID],
		[vcFirstName],
		[vcLastName],
		[vcContactDetail],
		[dtJoinDate],
		[vcSubscriberTypeName],
		@dtEffectiveFromDatetime,
		@dtEffectiveToDatetime,
		@bIsActive
	FROM
	(

	MERGE [BlueMobileDW].[Common].[SubscriberDimension] AS t
	USING (	SELECT TOP 100 PERCENT * FROM  #tmp1 ORDER BY iSubscriberID ) AS tab1 ON
	t.iSubscriberID = tab1.iSubscriberID
	 
	WHEN matched AND t.[bIsActive]=1 AND
	(
		 t.[vcFirstName]		   <> tab1.[vcFirstName]           OR 
		 t.[vcLastName]            <> tab1.[vcLastName]            OR
		 t.[vcContactDetail]       <> tab1.[vcContactDetail]       OR 
		 t.[dtJoinDate]            <> tab1.[dtJoinDate]            OR  
		 t.[vcSubscriberTypeName]  <> tab1.[vcSubscriberTypeName]
	 )

	THEN UPDATE SET

	t.[bIsActive]  = 0,
	t.[dtEffectiveToDatetime]=getdate()

	WHEN not matched THEN

	INSERT VALUES 
	(

		 tab1.[iSubscriberID]
		,tab1.[vcFirstName]
		,tab1.[vcLastName]
		,tab1.[vcContactDetail]
		,tab1.[dtJoinDate]
		,tab1.[vcSubscriberTypeName]
		,@dtEffectiveFromDatetime
		,@dtEffectiveToDatetime
		,@bIsActive

	)
	
	OUTPUT 

	     $action, 
		 tab1.[iSubscriberID],
		 tab1.[vcFirstName],
		 tab1.[vcLastName],
		 tab1.[vcContactDetail],
		 tab1.[dtJoinDate],
		 tab1.[vcSubscriberTypeName],
		 @dtEffectiveFromDatetime,
		 @dtEffectiveToDatetime,
		 @bIsActive

	) AS tab

	(
		ACTION,
	    [iSubscriberID],
		[vcFirstName],
		[vcLastName],
		[vcContactDetail],
		[dtJoinDate],
		[vcSubscriberTypeName],
		[dtEffectiveFromDatetime],
		[dtEffectiveToDatetime],
		[bIsActive] 
   )
  WHERE ACTION='UPDATE'

	

END