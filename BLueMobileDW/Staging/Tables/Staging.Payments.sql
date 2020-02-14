USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[Payments]    Script Date: 2/13/2020 3:43:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[Payments](
	[iPaymentID] [int] NOT NULL,
	[iSubscriberIDFK] [int] NOT NULL,
	[mPaymentAmount] [money] NULL,
	[mPenaltyCost] [money] NULL,
	[mTotalCost] [money] NULL,
	[dtPaymentDate] [datetime] NOT NULL,
	[iPaymentMethodIDFK] [int] NULL,
	[iStatusPaymentIDFK] [int] NOT NULL,
	[iDocumentIDFK] [int] NOT NULL,
	[iRewardPointsRulesIDFK] [int] NOT NULL,
	[iCurrencyIDFK] [int] NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


