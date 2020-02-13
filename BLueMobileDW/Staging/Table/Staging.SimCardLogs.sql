USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[SimCardLogs]    Script Date: 2/13/2020 3:42:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[SimCardLogs](
	[iCallLogID] [int] NOT NULL,
	[iLogTypeIDFK] [int] NOT NULL,
	[iSubscriberIDFK] [int] NOT NULL,
	[iSimCardIDFK] [int] NOT NULL,
	[vcPhoneNumber] [varchar](25) NOT NULL,
	[dtSimCardLogDateTime] [datetime] NOT NULL,
	[dtStartDateTime] [datetime2](7) NULL,
	[dtEndDateTime] [datetime2](7) NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


