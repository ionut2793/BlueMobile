USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[LogTypes]    Script Date: 2/13/2020 3:45:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[LogTypes](
	[iLogTypeID] [int] NOT NULL,
	[vcCallTypeName] [varchar](50) NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


