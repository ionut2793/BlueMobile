USE [BlueMobileDW]
GO

/****** Object:  Table [FinancialDM].[PaymentsFact]    Script Date: 2/13/2020 3:58:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [FinancialDM].[PaymentsFact](
	[PaymentsKey (PK)] [int] NULL,
	[DateDimKey (FK)] [int] NULL,
	[SubscriberDimKey (FK)] [int] NULL,
	[SubscriptionDimKey (FK)] [int] NULL,
	[ProductDimKey (FK)] [int] NULL,
	[CurrencyDimKey (FK)] [int] NULL,
	[CurrencyAmount] [money] NULL,
	[PaymentMethodKey (FK)] [int] NULL
) ON [PRIMARY]
GO


