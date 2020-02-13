USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[TransactionTypes]    Script Date: 2/13/2020 2:20:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[TransactionTypes](
	[iTransactionTypeID] [int] NOT NULL,
	[vcTransactionType] [varchar](25) NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


