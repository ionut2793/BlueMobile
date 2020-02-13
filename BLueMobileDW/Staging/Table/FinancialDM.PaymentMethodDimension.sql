USE [BlueMobileDW]
GO

/****** Object:  Table [FinancialDM].[PaymentMethodDimension]    Script Date: 2/13/2020 3:59:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [FinancialDM].[PaymentMethodDimension](
	[PaymentMethodKey (PK)] [int] NULL,
	[PaymentMethodName] [varchar](25) NULL,
	[Date_From] [datetime] NULL,
	[Date_To] [datetime] NULL
) ON [PRIMARY]
GO


