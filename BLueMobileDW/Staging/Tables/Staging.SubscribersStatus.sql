USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[SubscribersStatus]    Script Date: 2/13/2020 3:37:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[SubscribersStatus](
	[iStatusSubscriberID] [int] NOT NULL,
	[vcSubscriberStatusName] [varchar](10) NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


