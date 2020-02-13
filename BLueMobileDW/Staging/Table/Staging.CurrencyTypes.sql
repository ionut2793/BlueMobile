USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[CurrencyTypes]    Script Date: 2/13/2020 3:49:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[CurrencyTypes](
	[iCurrencyID] [int] NOT NULL,
	[vcCurrencyTypeName] [varchar](25) NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


