USE [BlueMobileDW]
GO

/****** Object:  Table [Common].[SubscriberDimension]    Script Date: 2/13/2020 4:00:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Common].[SubscriberDimension](
	[SubscriberKey (PK)] [int] NULL,
	[SubscriberFirstName] [varchar](50) NULL,
	[SubscriberLastName] [varchar](50) NULL,
	[SubscriberContactDetail] [varchar](50) NULL,
	[SubscriberJoinDate] [datetime] NOT NULL,
	[SubscriberSubscriberType] [int] NOT NULL,
	[Date_From] [datetime] NULL,
	[Date_To] [datetime] NULL
) ON [PRIMARY]
GO


