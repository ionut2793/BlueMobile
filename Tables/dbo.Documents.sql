USE [BlueMobile]
GO
/****** Object:  Table [Documents]    Script Date: 12/13/2019 3:17:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Documents](
	[iDocumentID] [int] IDENTITY(1,1) NOT NULL,
	[iDocumentTypeIDFK] [int] NOT NULL,
	[iSubscriberIDFK] [int] NOT NULL,
	[iSimCardIDFK] [int] NOT NULL,
	[iProductIDFK] [int] NOT NULL,
	[dtStartDate] [datetime] NULL,
	[dtEndDate] [datetime] NULL,
	[iDocumentStatusIDFK] [int] NULL,
	[iSubscriptionID] [int] NULL,
	[dtDueDate] [datetime] NULL,
	[dtCancelDate] [datetime] NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_Documents] PRIMARY KEY CLUSTERED 
(
	[iDocumentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Documents] ADD  CONSTRAINT [DF__Subscript__DateC__17036CC0]  DEFAULT (getdate()) FOR [sdtDateCreated]
GO
ALTER TABLE [Documents]  WITH CHECK ADD  CONSTRAINT [FK_Documents_DocumentsStatus] FOREIGN KEY([iDocumentStatusIDFK])
REFERENCES [DocumentsStatus] ([iDocumentStatusID])
GO
ALTER TABLE [Documents] CHECK CONSTRAINT [FK_Documents_DocumentsStatus]
GO
ALTER TABLE [Documents]  WITH CHECK ADD  CONSTRAINT [FK_Documents_DocumentTypes] FOREIGN KEY([iDocumentTypeIDFK])
REFERENCES [DocumentTypes] ([iDocumentTypeID])
GO
ALTER TABLE [Documents] CHECK CONSTRAINT [FK_Documents_DocumentTypes]
GO
ALTER TABLE [Documents]  WITH CHECK ADD  CONSTRAINT [FK_Documents_Products] FOREIGN KEY([iProductIDFK])
REFERENCES [Products] ([iProductID])
GO
ALTER TABLE [Documents] CHECK CONSTRAINT [FK_Documents_Products]
GO
ALTER TABLE [Documents]  WITH CHECK ADD  CONSTRAINT [FK_Documents_SimCards] FOREIGN KEY([iSimCardIDFK])
REFERENCES [SimCards] ([iSimCardID])
GO
ALTER TABLE [Documents] CHECK CONSTRAINT [FK_Documents_SimCards]
GO
ALTER TABLE [Documents]  WITH CHECK ADD  CONSTRAINT [FK_Documents_Subscribers] FOREIGN KEY([iSubscriberIDFK])
REFERENCES [Subscribers] ([iSubscriberID])
GO
ALTER TABLE [Documents] CHECK CONSTRAINT [FK_Documents_Subscribers]
GO
ALTER TABLE [Documents]  WITH CHECK ADD  CONSTRAINT [CK_Documents_dtEndDate] CHECK  (([dtStartDate]<[dtEndDate]))
GO
ALTER TABLE [Documents] CHECK CONSTRAINT [CK_Documents_dtEndDate]
GO
