USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[SimCards]    Script Date: 2/13/2020 3:40:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[SimCards](
	[iSimCardID] [int] NOT NULL,
	[vcPhoneNumber] [varchar](25) NOT NULL,
	[vcPINNumber] [varchar](25) NOT NULL,
	[vcPUKNumber] [varchar](25) NOT NULL,
	[vcIMEINumber] [varchar](25) NOT NULL,
	[vcSerialNumber] [varchar](25) NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


