USE [BlueMobile]
GO
/****** Object:  Table [SubscribersStatus]    Script Date: 12/13/2019 3:17:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SubscribersStatus](
	[iStatusSubscriberID] [int] IDENTITY(1,1) NOT NULL,
	[vcSubscriberStatusName] [varchar](10) NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_StatusSubscribers] PRIMARY KEY CLUSTERED 
(
	[iStatusSubscriberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [SubscribersStatus] ADD  DEFAULT (getdate()) FOR [sdtDateCreated]
GO
