USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[RewardPointsRules]    Script Date: 2/13/2020 3:42:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[RewardPointsRules](
	[iRewardPointsRulesID] [int] NOT NULL,
	[mRequiredAmout] [money] NOT NULL,
	[iRewardPoint] [int] NOT NULL,
	[mRewardValue] [money] NOT NULL,
	[dtStartOffer] [datetime] NULL,
	[dtEndOffer] [datetime] NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


