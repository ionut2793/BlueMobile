USE [BlueMobileDW]
GO

/****** Object:  Table [FinancialDM].[ProductDimension]    Script Date: 2/13/2020 3:56:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [FinancialDM].[ProductDimension](
	[ProductKey (PK)] [int] NULL,
	[ProductDescription] [varchar](25) NULL,
	[ProductCategory] [varchar](25) NULL,
	[Date_From] [datetime] NULL,
	[Date_To] [datetime] NULL,
	[CurrentRowIndicator] [varchar](25) NULL
) ON [PRIMARY]
GO


