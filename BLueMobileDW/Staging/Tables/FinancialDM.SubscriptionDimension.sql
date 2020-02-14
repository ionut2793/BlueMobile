USE [BlueMobileDW]
GO

/****** Object:  Table [FinancialDM].[SubscriptionDimension]    Script Date: 2/13/2020 3:56:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [FinancialDM].[SubscriptionDimension](
	[SubscriptionKey (PK)] [int] NULL,
	[SubscriptionType] [int] NULL,
	[SubscriptionDescription] [varchar](50) NULL,
	[Date_From] [datetime] NULL,
	[Date_To] [datetime] NULL
) ON [PRIMARY]
GO


