USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[Documents]    Script Date: 2/13/2020 3:49:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[Documents](
	[iDocumentID] [int] NOT NULL,
	[iDocumentTypeIDFK] [int] NOT NULL,
	[iSubscriberIDFK] [int] NOT NULL,
	[iSimCardIDFK] [int] NOT NULL,
	[iProductIDFK] [int] NOT NULL,
	[dtStartDate] [datetime] NULL,
	[dtEndDate] [datetime] NULL,
	[iDocumentStatusIDFK] [int] NULL,
	[iSubscriptionID] [int] NULL,
	[dtDueDate] [datetime] NULL,
	[dtCancelDate] [datetime] NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


