USE [BlueMobile]
GO
/****** Object:  Table [Subscribers]    Script Date: 12/13/2019 3:17:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Subscribers](
	[iSubscriberID] [int] IDENTITY(1,1) NOT NULL,
	[vcFirstName] [varchar](50) NOT NULL,
	[vcLastName] [varchar](50) NOT NULL,
	[vcContactDetail] [varchar](50) NULL,
	[iStatusSubscriberIDFK] [int] NOT NULL,
	[iSubscriberTypeIDFK] [int] NOT NULL,
	[vcPersonalCodeIdentification] [varchar](25) NULL,
	[dtJoinDate] [datetime] NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_Subscribers] PRIMARY KEY CLUSTERED 
(
	[iSubscriberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[vcPersonalCodeIdentification] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Subscribers] ADD  CONSTRAINT [DF__Subscribe__DateC__160F4887]  DEFAULT (getdate()) FOR [sdtDateCreated]
GO
ALTER TABLE [Subscribers]  WITH CHECK ADD  CONSTRAINT [FK_Subscribers_SubscribersStatus] FOREIGN KEY([iStatusSubscriberIDFK])
REFERENCES [SubscribersStatus] ([iStatusSubscriberID])
GO
ALTER TABLE [Subscribers] CHECK CONSTRAINT [FK_Subscribers_SubscribersStatus]
GO
ALTER TABLE [Subscribers]  WITH CHECK ADD  CONSTRAINT [FK_Subscribers_SubscriberTypes] FOREIGN KEY([iSubscriberTypeIDFK])
REFERENCES [SubscriberTypes] ([iSubscriberTypeID])
GO
ALTER TABLE [Subscribers] CHECK CONSTRAINT [FK_Subscribers_SubscriberTypes]
GO
