USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[FavoriteNumbers]    Script Date: 2/13/2020 3:46:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[FavoriteNumbers](
	[iFavoritNumberID] [int] NOT NULL,
	[iSimCardIDFK] [int] NOT NULL,
	[vcFavoriteNumber] [varchar](25) NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


