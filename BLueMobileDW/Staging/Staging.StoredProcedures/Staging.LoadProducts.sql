USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists Staging.LoadProducts
GO
 
CREATE PROCEDURE Staging.LoadProducts
AS 
BEGIN

	TRUNCATE TABLE [BlueMobileDW].[Staging].[Products]
    DECLARE @sdtDateCreated datetime=getdate()

	INSERT INTO [BlueMobileDW].[Staging].[Products] ([iProductID],[vcProductTypeName],[mCostMonth],[iSms],[iMinute],[iMinExtra],[mCostMinExtra],[mCostSms],[mCostWeekdaysInside],[mCostWeekdaysOutside],[mCostWeekendsInside],[mCostWeekendsOutside],[sdtDateCreated])
	SELECT

		 [iProductID]
		,[vcProductTypeName]
		,[mCostMonth]
		,[iSms]
		,[iMinute]
		,[iMinExtra]
		,[mCostMinExtra]
		,[mCostSms]
		,[mCostWeekdaysInside]
		,[mCostWeekdaysOutside]
		,[mCostWeekendsInside]
		,[mCostWeekendsOutside]
		,@sdtDateCreated
      
	FROM [BlueMobile].[dbo].[Products]
END