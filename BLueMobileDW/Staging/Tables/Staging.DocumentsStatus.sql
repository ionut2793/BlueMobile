USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[DocumentsStatus]    Script Date: 2/13/2020 3:47:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[DocumentsStatus](
	[iDocumentStatusID] [int] NOT NULL,
	[vcDocumentStatusName] [varchar](10) NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


