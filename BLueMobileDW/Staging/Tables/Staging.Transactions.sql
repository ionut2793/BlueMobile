USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[Transactions]    Script Date: 2/13/2020 3:35:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[Transactions](
	[iTransactionID] [int] NOT NULL,
	[iDocumentIDFK] [int] NOT NULL,
	[iPaymentIDFK] [int] NULL,
	[iTransactionTypeIDFK] [int] NOT NULL,
	[dtTransactionDate] [datetime] NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


