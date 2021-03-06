USE [BlueMobile]
GO
/****** Object:  Table [Products]    Script Date: 12/13/2019 3:17:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Products](
	[iProductID] [int] NOT NULL,
	[vcProductTypeName] [varchar](10) NOT NULL,
	[mCostMonth] [money] NULL,
	[iSms] [int] NULL,
	[iMinute] [int] NULL,
	[iMinExtra] [money] NULL,
	[mCostMinExtra] [money] NULL,
	[mCostSms] [money] NULL,
	[mCostWeekdaysInside] [money] NULL,
	[mCostWeekdaysOutside] [money] NULL,
	[mCostWeekendsInside] [money] NULL,
	[mCostWeekendsOutside] [money] NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[iProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Products] ADD  CONSTRAINT [DF__Type of S__DateC__1BC821DD]  DEFAULT (getdate()) FOR [sdtDateCreated]
GO
