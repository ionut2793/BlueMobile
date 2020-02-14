USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[Addresses]    Script Date: 2/13/2020 3:52:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[Addresses](
	[iAddressID] [int] NOT NULL,
	[iSubscriberIDFK] [int] NOT NULL,
	[vcStreet] [varchar](200) NULL,
	[iHouseNumber] [int] NULL,
	[vcCity] [varchar](50) NULL,
	[vcState] [varchar](50) NULL,
	[vcCountry] [varchar](50) NULL,
	[iPhoneNumber] [varchar](20) NULL,
	[nvcEmail] [varchar](100) NULL,
	[cZipCode] [char](5) NULL,
	[iTypeAddressIDFK] [int] NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


