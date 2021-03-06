USE [BlueMobile]
GO
/****** Object:  Table [CurrencyTypes]    Script Date: 12/13/2019 3:17:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CurrencyTypes](
	[iCurrencyID] [int] NOT NULL,
	[vcCurrencyTypeName] [varchar](25) NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_CurrencyTypes] PRIMARY KEY CLUSTERED 
(
	[iCurrencyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [CurrencyTypes] ADD  DEFAULT (getdate()) FOR [sdtDateCreated]
GO
