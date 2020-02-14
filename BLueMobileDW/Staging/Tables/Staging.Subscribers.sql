USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[Subscribers]    Script Date: 2/13/2020 3:38:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[Subscribers](
	[iSubscriberID] [int] NOT NULL,
	[vcFirstName] [varchar](50) NOT NULL,
	[vcLastName] [varchar](50) NOT NULL,
	[vcContactDetail] [varchar](50) NULL,
	[iStatusSubscriberIDFK] [int] NOT NULL,
	[iSubscriberTypeIDFK] [int] NOT NULL,
	[vcPersonalCodeIdentification] [varchar](25) NULL,
	[dtJoinDate] [datetime] NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


