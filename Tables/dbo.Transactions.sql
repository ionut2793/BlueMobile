USE [BlueMobile]
GO
/****** Object:  Table [Transactions]    Script Date: 12/13/2019 3:17:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Transactions](
	[iTransactionID] [int] IDENTITY(1,1) NOT NULL,
	[iDocumentIDFK] [int] NOT NULL,
	[iPaymentIDFK] [int] NULL,
	[iTransactionTypeIDFK] [int] NOT NULL,
	[dtTransactionDate] [datetime] NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_SubscriptionTransactions] PRIMARY KEY CLUSTERED 
(
	[iTransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Transactions] ADD  CONSTRAINT [DF__Transacti__DataC__662B2B3B]  DEFAULT (getdate()) FOR [sdtDateCreated]
GO
ALTER TABLE [Transactions]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionTransactions_Documents] FOREIGN KEY([iDocumentIDFK])
REFERENCES [Documents] ([iDocumentID])
GO
ALTER TABLE [Transactions] CHECK CONSTRAINT [FK_SubscriptionTransactions_Documents]
GO
ALTER TABLE [Transactions]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionTransactions_Payments] FOREIGN KEY([iPaymentIDFK])
REFERENCES [Payments] ([iPaymentID])
GO
ALTER TABLE [Transactions] CHECK CONSTRAINT [FK_SubscriptionTransactions_Payments]
GO
ALTER TABLE [Transactions]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionTransactions_TransactionTypes] FOREIGN KEY([iTransactionTypeIDFK])
REFERENCES [TransactionTypes] ([iTransactionTypeID])
GO
ALTER TABLE [Transactions] CHECK CONSTRAINT [FK_SubscriptionTransactions_TransactionTypes]
GO
