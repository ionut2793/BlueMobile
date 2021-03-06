USE [BlueMobile]
GO
/****** Object:  Table [StatusPayments]    Script Date: 12/13/2019 3:17:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [StatusPayments](
	[iStatusPaymentID] [int] IDENTITY(1,1) NOT NULL,
	[vcStatusPayment] [varchar](10) NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_StatusPayments] PRIMARY KEY CLUSTERED 
(
	[iStatusPaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [StatusPayments] ADD  DEFAULT (getdate()) FOR [sdtDateCreated]
GO
