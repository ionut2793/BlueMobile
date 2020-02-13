USE [BlueMobileDW]
GO

/****** Object:  Table [FinancialDM].[CurrencyDimension]    Script Date: 2/13/2020 3:59:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [FinancialDM].[CurrencyDimension](
	[CurrencyKey (PK)] [int] NULL,
	[CurencyName] [varchar](25) NULL,
	[CurrencyAbreviation] [varchar](25) NULL,
	[Date_From] [datetime] NULL,
	[Date_To] [datetime] NULL
) ON [PRIMARY]
GO


