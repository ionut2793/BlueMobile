USE [BlueMobile]
GO
/****** Object:  Table [LogTypes]    Script Date: 12/13/2019 3:17:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LogTypes](
	[iLogTypeID] [int] IDENTITY(1,1) NOT NULL,
	[vcCallTypeName] [varchar](50) NOT NULL,
	[stDateCreated] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_CallTypes] PRIMARY KEY CLUSTERED 
(
	[iLogTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [LogTypes] ADD  DEFAULT (getdate()) FOR [stDateCreated]
GO
