USE [BlueMobile]
GO
/****** Object:  Table [RewardPointsRules]    Script Date: 12/13/2019 3:17:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RewardPointsRules](
	[iRewardPointsRulesID] [int] IDENTITY(1,1) NOT NULL,
	[mRequiredAmout] [money] NOT NULL,
	[iRewardPoint] [int] NOT NULL,
	[mRewardValue] [money] NOT NULL,
	[dtStartOffer] [datetime] NULL,
	[dtEndOffer] [datetime] NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_RewardPointRates] PRIMARY KEY CLUSTERED 
(
	[iRewardPointsRulesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [RewardPointsRules] ADD  CONSTRAINT [DF__RewardPoi__stDat__4589517F]  DEFAULT (getdate()) FOR [sdtDateCreated]
GO
