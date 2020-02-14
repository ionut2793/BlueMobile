USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[DocumentTypes]    Script Date: 2/13/2020 3:46:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[DocumentTypes](
	[iDocumentTypeID] [int] NOT NULL,
	[vcDocumentTypeName] [varchar](20) NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


