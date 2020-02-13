USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[StatusPayments]    Script Date: 2/13/2020 3:39:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[StatusPayments](
	[iStatusPaymentID] [int] NOT NULL,
	[vcStatusPayment] [varchar](10) NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


