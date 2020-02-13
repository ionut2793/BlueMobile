USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[AddressTypes]    Script Date: 2/13/2020 3:52:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[AddressTypes](
	[iTypeAddressID] [int] NOT NULL,
	[vcAddressTypeName] [varchar](10) NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


