USE [BlueMobileDW]
GO

/****** Object:  Table [Common].[LocationDimension]    Script Date: 2/13/2020 4:00:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Common].[LocationDimension](
	[LocationKey (PK)] [int] NULL,
	[LocationAddress] [varchar](50) NULL,
	[LocationCity] [varchar](50) NULL,
	[LocationState] [varchar](50) NULL,
	[LocationCountry] [varchar](50) NULL,
	[Date_From] [datetime] NULL,
	[Date_To] [datetime] NULL
) ON [PRIMARY]
GO


