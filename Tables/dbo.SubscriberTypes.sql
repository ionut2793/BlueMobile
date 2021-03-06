USE [BlueMobile]
GO
/****** Object:  Table [SubscriberTypes]    Script Date: 12/13/2019 3:17:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SubscriberTypes](
	[iSubscriberTypeID] [int] IDENTITY(1,1) NOT NULL,
	[vcSubscriberTypeName] [varchar](30) NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_SubscriberTypes] PRIMARY KEY CLUSTERED 
(
	[iSubscriberTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [SubscriberTypes] ADD  DEFAULT (getdate()) FOR [sdtDateCreated]
GO
