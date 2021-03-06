USE [BlueMobile]
GO
/****** Object:  Table [PaymentMethods]    Script Date: 12/13/2019 3:17:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PaymentMethods](
	[iPaymentMethodID] [int] IDENTITY(1,1) NOT NULL,
	[vcPaymentMethodName] [varchar](25) NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_PaymentsMethod] PRIMARY KEY CLUSTERED 
(
	[iPaymentMethodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [PaymentMethods] ADD  DEFAULT (getdate()) FOR [sdtDateCreated]
GO
