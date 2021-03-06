USE [BlueMobile]
GO
/****** Object:  Table [CalculateRewardPoints]    Script Date: 12/13/2019 3:17:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CalculateRewardPoints](
	[iCalculRewardPointID] [int] IDENTITY(1,1) NOT NULL,
	[iRewardPointsRulesIDFK] [int] NOT NULL,
	[iDocumentIDFK] [int] NOT NULL,
	[bIsActive] [bit] NOT NULL,
	[dtEffectiveFromDate] [datetime] NOT NULL,
	[dtEffectiveToDate] [datetime] NOT NULL,
	[iRewardPointTotal] [int] NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_CalculRewardPoints] PRIMARY KEY CLUSTERED 
(
	[iCalculRewardPointID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [CalculateRewardPoints] ADD  CONSTRAINT [DF__CalculRew__sdtDa__12C8C788]  DEFAULT (getdate()) FOR [sdtDateCreated]
GO
ALTER TABLE [CalculateRewardPoints]  WITH CHECK ADD  CONSTRAINT [FK_CalculateRewardPoints_Documents] FOREIGN KEY([iDocumentIDFK])
REFERENCES [Documents] ([iDocumentID])
GO
ALTER TABLE [CalculateRewardPoints] CHECK CONSTRAINT [FK_CalculateRewardPoints_Documents]
GO
ALTER TABLE [CalculateRewardPoints]  WITH CHECK ADD  CONSTRAINT [FK_CalculRewardPoints_RewardPointRates] FOREIGN KEY([iRewardPointsRulesIDFK])
REFERENCES [RewardPointsRules] ([iRewardPointsRulesID])
GO
ALTER TABLE [CalculateRewardPoints] CHECK CONSTRAINT [FK_CalculRewardPoints_RewardPointRates]
GO
