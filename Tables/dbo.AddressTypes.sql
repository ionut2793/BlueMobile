USE [BlueMobile]
GO
/****** Object:  Table [AddressTypes]    Script Date: 12/13/2019 3:17:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [AddressTypes](
	[iTypeAddressID] [int] IDENTITY(1,1) NOT NULL,
	[vcAddressTypeName] [varchar](10) NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_AddressTypes] PRIMARY KEY CLUSTERED 
(
	[iTypeAddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [AddressTypes] ADD  DEFAULT (getdate()) FOR [sdtDateCreated]
GO
