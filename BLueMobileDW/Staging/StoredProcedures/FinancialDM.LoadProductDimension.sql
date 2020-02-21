USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists FinancialDM.LoadProductDimension
GO
 
CREATE PROCEDURE  FinancialDM.LoadProductDimension

AS 
BEGIN

   	DECLARE @dtEffectiveFromDatetime datetime=getdate()
   	DECLARE @dtEffectiveToDatetime   datetime='9999-12-31'
	DECLARE @bIsActive               bit=1

	
	
	INSERT INTO [BlueMobileDW].[FinancialDM].[ProductDimension]
	(
		[iProductID], 
		[vcProductTypeName],
		[mCostMonth],
		[iSms],
		[iMinute],
		[iMinExtra],
		[mCostMinExtra],
		[mCostSms],
		[mCostWeekdaysInside],
		[mCostWeekdaysOutside],
		[mCostWeekendsInside],
		[mCostWeekendsOutside],
		[dtEffectiveFromDatetime],
		[dtEffectiveToDatetime],
		[bIsActive]
	)

	SELECT 
		[iProductID], 
		[vcProductTypeName],
		[mCostMonth],
		[iSms],
		[iMinute],
		[iMinExtra],
		[mCostMinExtra],
		[mCostSms],
		[mCostWeekdaysInside],
		[mCostWeekdaysOutside],
		[mCostWeekendsInside],
		[mCostWeekendsOutside],
		@dtEffectiveFromDatetime,
		@dtEffectiveToDatetime,
		@bIsActive
	FROM
	(

	MERGE [BlueMobileDW].[FinancialDM].[ProductDimension] AS t
	USING [BlueMobileDW].[Staging].[Products] AS tab1 
	ON    t.iProductID= tab1.iProductID

	WHEN matched AND t.[bIsActive]=1 AND
	(
		 t.[vcProductTypeName]	     <> tab1.[vcProductTypeName]	   OR		
		 t.[mCostMonth]		         <> tab1.[mCostMonth]	           OR
	     t.[iSms]				     <> tab1.[iSms]			           OR	 	
		 t.[iMinute]			     <> tab1.[iMinute]				   OR
	     t.[iMinExtra]		         <> tab1.[iMinExtra]			   OR
		 t.[mCostMinExtra]		     <> tab1.[mCostMinExtra]		   OR
		 t.[mCostSms]			     <> tab1.[mCostSms]			       OR
		 t.[mCostWeekdaysInside]     <> tab1.[mCostWeekdaysInside]     OR
		 t.[mCostWeekdaysOutside]    <> tab1.[mCostWeekdaysOutside]    OR
	     t.[mCostWeekendsInside]     <> tab1.[mCostWeekendsInside]     OR
	     t.[mCostWeekendsOutside]    <> tab1.[mCostWeekendsOutside]  
	
	 )

	THEN UPDATE SET

	t.[bIsActive]  = 0,
	t.[dtEffectiveToDatetime]=getdate()
	

	WHEN not matched THEN

	INSERT VALUES 
		(
		 tab1.[iProductID],
		 tab1.[vcProductTypeName],
		 tab1.[mCostMonth],
	     tab1.[iSms],
		 tab1.[iMinute],
	     tab1.[iMinExtra],
		 tab1.[mCostMinExtra],
		 tab1.[mCostSms],
		 tab1.[mCostWeekdaysInside],
		 tab1.[mCostWeekdaysOutside],
	     tab1.[mCostWeekendsInside],
	     tab1.[mCostWeekendsOutside],
		 @dtEffectiveFromDatetime,
		 @dtEffectiveToDatetime,
		 @bIsActive
		 )
	
	OUTPUT 
	    $action, 
		tab1.[iProductID], 
		tab1.[vcProductTypeName],
		tab1.[mCostMonth],
		tab1.[iSms],
		tab1.[iMinute],
		tab1.[iMinExtra],
		tab1.[mCostMinExtra],
		tab1.[mCostSms],
		tab1.[mCostWeekdaysInside],
		tab1.[mCostWeekdaysOutside],
		tab1.[mCostWeekendsInside],
		tab1.[mCostWeekendsOutside],
		@dtEffectiveFromDatetime,
		@dtEffectiveToDatetime,
		@bIsActive 

	) AS tab
  
  (
    ACTION,
    [iProductID], 
    [vcProductTypeName],
    [mCostMonth],
    [iSms],
    [iMinute],
	[iMinExtra],
    [mCostMinExtra],
	[mCostSms],
    [mCostWeekdaysInside],
	[mCostWeekdaysOutside],
	[mCostWeekendsInside],
	[mCostWeekendsOutside],
	[dtEffectiveFromDatetime],
	[dtEffectiveToDatetime],
	[bIsActive] 
  )
  WHERE ACTION='UPDATE'

END
