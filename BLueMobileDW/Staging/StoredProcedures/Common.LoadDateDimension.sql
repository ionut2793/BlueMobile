USE [BlueMobileDW]
GO

DROP PROCEDURE IF exists Common.LoadDateDimension
GO
 
CREATE PROCEDURE Common.LoadDateDimension
AS 
BEGIN


TRUNCATE TABLE [BlueMobileDW].[Common].[DateDimension] 
   

DECLARE @CurrentDate DATE = '2000-01-01'
DECLARE @EndDate     DATE = '2100-12-31'

WHILE @CurrentDate < @EndDate
BEGIN
   INSERT INTO [Common].[DateDimension] 
   (
      [iDateID],
      [dDate],
      [tiDay],
      [cDaySuffix],
      [tiWeekday],
      [vcWeekDayName],
      [cWeekDayName_Short],
      [cWeekDayName_FirstLetter],
      [tiDOWInMonth],
      [siDayOfYear],
      [tiWeekOfMonth],
      [tiWeekOfYear],
      [tiMonth],
      [vcMonthName],
      [cMonthName_Short],
      [cMonthName_FirstLetter],
      [tiQuarter],
      [vcQuarterName],
      [iYear],
      [cMMYYYY],
      [cMonthYear],
      [bIsWeekend]

    )

   SELECT 
      [iDateID]     = YEAR(@CurrentDate) * 10000 + MONTH(@CurrentDate) * 100 + DAY(@CurrentDate),
      [dDate]		= @CurrentDate,
      [tiDay]		= DAY(@CurrentDate),
      [cDaySuffix]	= CASE 
         WHEN  DAY(@CurrentDate) = 1
            OR DAY(@CurrentDate) = 21
            OR DAY(@CurrentDate) = 31
            THEN 'st'
         WHEN  DAY(@CurrentDate) = 2
            OR DAY(@CurrentDate) = 22
            THEN 'nd'
         WHEN  DAY(@CurrentDate) = 3
            OR DAY(@CurrentDate) = 23
            THEN 'rd'
         ELSE 'th'
         END,
      [tiWeekday]			   = DATEPART(dw, @CurrentDate),
      [vcWeekDayName]		   = DATENAME(dw, @CurrentDate),
      [cWeekDayName_Short]     = UPPER(LEFT(DATENAME(dw, @CurrentDate), 3)),
      [cMonthName_FirstLetter] = LEFT(DATENAME(dw, @CurrentDate), 1),
      [tiDOWInMonth]           = DAY(@CurrentDate),
      [siDayOfYear]            = DATENAME(dy, @CurrentDate),
      [tiWeekOfMonth]          = DATEPART(WEEK, @CurrentDate) - DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM, 0, @CurrentDate), 0)) + 1,
      [tiWeekOfYear]           = DATEPART(wk, @CurrentDate),
      [tiMonth]                = MONTH(@CurrentDate),
      [vcMonthName]			   = DATENAME(mm, @CurrentDate),
      [cMonthName_Short]	   = UPPER(LEFT(DATENAME(mm, @CurrentDate), 3)),
      [cMonthName_FirstLetter] = LEFT(DATENAME(mm, @CurrentDate), 1),
      [tiQuarter]              = DATEPART(q, @CurrentDate),
      [vcQuarterName]          = CASE 
         WHEN DATENAME(qq, @CurrentDate) = 1
            THEN 'First'
         WHEN DATENAME(qq, @CurrentDate) = 2
            THEN 'second'
         WHEN DATENAME(qq, @CurrentDate) = 3
            THEN 'third'
         WHEN DATENAME(qq, @CurrentDate) = 4
            THEN 'fourth'
         END,
      [Year]      = YEAR(@CurrentDate),
      [MMYYYY]    = RIGHT('0' + CAST(MONTH(@CurrentDate) AS VARCHAR(2)), 2) + CAST(YEAR(@CurrentDate) AS VARCHAR(4)),
      [MonthYear] = CAST(YEAR(@CurrentDate) AS VARCHAR(4)) + UPPER(LEFT(DATENAME(mm, @CurrentDate), 3)),
      [IsWeekend] = CASE 
         WHEN  DATENAME(dw, @CurrentDate) = 'Sunday'
            OR DATENAME(dw, @CurrentDate) = 'Saturday'
            THEN 1
         ELSE 0
         END
  

   SET @CurrentDate = DATEADD(DD, 1, @CurrentDate)
END
END