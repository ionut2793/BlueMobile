USE [BlueMobile]
GO
/****** Object:  Table [DocumentsStatus]    Script Date: 12/13/2019 3:17:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DocumentsStatus](
	[iDocumentStatusID] [int] IDENTITY(1,1) NOT NULL,
	[vcDocumentStatusName] [varchar](10) NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_StatusSubscription] PRIMARY KEY CLUSTERED 
(
	[iDocumentStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [DocumentsStatus] ADD  CONSTRAINT [DF__StatusSub__datam__14270015]  DEFAULT (getdate()) FOR [sdtDateCreated]
GO
