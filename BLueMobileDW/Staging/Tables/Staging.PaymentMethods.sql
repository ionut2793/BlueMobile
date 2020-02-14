USE [BlueMobileDW]
GO

/****** Object:  Table [Staging].[PaymentMethods]    Script Date: 2/13/2020 3:45:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Staging].[PaymentMethods](
	[iPaymentMethodID] [int] NOT NULL,
	[vcPaymentMethodName] [varchar](25) NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO


