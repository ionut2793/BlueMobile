USE [BlueMobile]
GO
/****** Object:  Table [SimCardLogs]    Script Date: 12/13/2019 3:17:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SimCardLogs](
	[iCallLogID] [int] IDENTITY(1,1) NOT NULL,
	[iLogTypeIDFK] [int] NOT NULL,
	[iSubscriberIDFK] [int] NOT NULL,
	[iSimCardIDFK] [int] NOT NULL,
	[vcPhoneNumber] [varchar](25) NOT NULL,
	[dtSimCardLogDateTime] [datetime] NOT NULL,
	[dtStartDateTime] [datetime2](7) NULL,
	[dtEndDateTime] [datetime2](7) NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_CallLogs] PRIMARY KEY CLUSTERED 
(
	[iCallLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [SimCardLogs] ADD  CONSTRAINT [DF__SimCardLo__sdtDa__13DCE752]  DEFAULT (getdate()) FOR [sdtDateCreated]
GO
ALTER TABLE [SimCardLogs]  WITH CHECK ADD  CONSTRAINT [FK_SimCardLogs_LogTypes] FOREIGN KEY([iLogTypeIDFK])
REFERENCES [LogTypes] ([iLogTypeID])
GO
ALTER TABLE [SimCardLogs] CHECK CONSTRAINT [FK_SimCardLogs_LogTypes]
GO
ALTER TABLE [SimCardLogs]  WITH CHECK ADD  CONSTRAINT [FK_SimCardLogs_SimCards] FOREIGN KEY([iSimCardIDFK])
REFERENCES [SimCards] ([iSimCardID])
GO
ALTER TABLE [SimCardLogs] CHECK CONSTRAINT [FK_SimCardLogs_SimCards]
GO
ALTER TABLE [SimCardLogs]  WITH CHECK ADD  CONSTRAINT [FK_SimCardLogs_Subscribers] FOREIGN KEY([iSubscriberIDFK])
REFERENCES [Subscribers] ([iSubscriberID])
GO
ALTER TABLE [SimCardLogs] CHECK CONSTRAINT [FK_SimCardLogs_Subscribers]
GO
