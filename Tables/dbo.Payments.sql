USE [BlueMobile]
GO
/****** Object:  Table [Payments]    Script Date: 12/13/2019 3:17:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Payments](
	[iPaymentID] [int] IDENTITY(1,1) NOT NULL,
	[iSubscriberIDFK] [int] NOT NULL,
	[mPaymentAmount] [money] NULL,
	[mPenaltyCost] [money] NULL,
	[mTotalCost] [money] NULL,
	[dtPaymentDate] [datetime] NOT NULL,
	[iPaymentMethodIDFK] [int] NULL,
	[iStatusPaymentIDFK] [int] NOT NULL,
	[iDocumentIDFK] [int] NOT NULL,
	[iRewardPointsRulesIDFK] [int] NOT NULL,
	[iCurrencyIDFK] [int] NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_Payments] PRIMARY KEY CLUSTERED 
(
	[iPaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Payments] ADD  CONSTRAINT [DF__Payments__sdtDat__35C7EB02]  DEFAULT (getdate()) FOR [sdtDateCreated]
GO
ALTER TABLE [Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_CurrencyTypes] FOREIGN KEY([iCurrencyIDFK])
REFERENCES [CurrencyTypes] ([iCurrencyID])
GO
ALTER TABLE [Payments] CHECK CONSTRAINT [FK_Payments_CurrencyTypes]
GO
ALTER TABLE [Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_Documents] FOREIGN KEY([iDocumentIDFK])
REFERENCES [Documents] ([iDocumentID])
GO
ALTER TABLE [Payments] CHECK CONSTRAINT [FK_Payments_Documents]
GO
ALTER TABLE [Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_PaymentMethods] FOREIGN KEY([iPaymentMethodIDFK])
REFERENCES [PaymentMethods] ([iPaymentMethodID])
GO
ALTER TABLE [Payments] CHECK CONSTRAINT [FK_Payments_PaymentMethods]
GO
ALTER TABLE [Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_StatusPayments] FOREIGN KEY([iStatusPaymentIDFK])
REFERENCES [StatusPayments] ([iStatusPaymentID])
GO
ALTER TABLE [Payments] CHECK CONSTRAINT [FK_Payments_StatusPayments]
GO
ALTER TABLE [Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_Subscribers] FOREIGN KEY([iSubscriberIDFK])
REFERENCES [Subscribers] ([iSubscriberID])
GO
ALTER TABLE [Payments] CHECK CONSTRAINT [FK_Payments_Subscribers]
GO
