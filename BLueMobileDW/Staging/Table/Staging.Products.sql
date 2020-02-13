USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[Products]    Script Date: 2/13/2020 3:43:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[Products](
	[iProductID] [int] NOT NULL,
	[vcProductTypeName] [varchar](10) NOT NULL,
	[mCostMonth] [money] NULL,
	[iSms] [int] NULL,
	[iMinute] [int] NULL,
	[iMinExtra] [money] NULL,
	[mCostMinExtra] [money] NULL,
	[mCostSms] [money] NULL,
	[mCostWeekdaysInside] [money] NULL,
	[mCostWeekdaysOutside] [money] NULL,
	[mCostWeekendsInside] [money] NULL,
	[mCostWeekendsOutside] [money] NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


