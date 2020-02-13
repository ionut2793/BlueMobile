USE [BlueMobileDW]
GO

/****** Object:  Table [Common].[DateDimension]    Script Date: 2/13/2020 4:01:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Common].[DateDimension](
	[DateKey (PK)] [int] NULL,
	[Day] [datetime] NULL,
	[month] [datetime] NULL,
	[year] [datetime] NULL
) ON [PRIMARY]
GO


