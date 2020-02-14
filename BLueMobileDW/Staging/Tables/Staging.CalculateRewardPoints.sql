USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[CalculateRewardPoints]    Script Date: 2/13/2020 3:50:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[CalculateRewardPoints](
	[iCalculRewardPointID] [int] NOT NULL,
	[iRewardPointsRulesIDFK] [int] NOT NULL,
	[iDocumentIDFK] [int] NOT NULL,
	[bIsActive] [bit] NOT NULL,
	[dtEffectiveFromDate] [datetime] NOT NULL,
	[dtEffectiveToDate] [datetime] NOT NULL,
	[iRewardPointTotal] [int] NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


