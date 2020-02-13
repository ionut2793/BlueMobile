USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[SubscriberTypes]    Script Date: 2/13/2020 3:37:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[SubscriberTypes](
	[iSubscriberTypeID] [int] NOT NULL,
	[vcSubscriberTypeName] [varchar](30) NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


