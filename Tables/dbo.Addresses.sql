USE [BlueMobile]
GO
/****** Object:  Table [Addresses]    Script Date: 12/13/2019 3:17:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Addresses](
	[iAddressID] [int] IDENTITY(1,1) NOT NULL,
	[iSubscriberIDFK] [int] NOT NULL,
	[vcStreet] [varchar](200) NULL,
	[iHouseNumber] [int] NULL,
	[vcCity] [varchar](50) NULL,
	[vcState] [varchar](50) NULL,
	[vcCountry] [varchar](50) NULL,
	[iPhoneNumber] [varchar](20) NULL,
	[nvcEmail] [varchar](100) NULL,
	[cZipCode] [char](5) NULL,
	[iTypeAddressIDFK] [int] NOT NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL,
UNIQUE NONCLUSTERED 
(
	[nvcEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[nvcEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[nvcEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Addresses] ADD  CONSTRAINT [DF__Addresses__DataC__6442E2C9]  DEFAULT (getdate()) FOR [sdtDateCreated]
GO
ALTER TABLE [Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_AddressTypes] FOREIGN KEY([iTypeAddressIDFK])
REFERENCES [AddressTypes] ([iTypeAddressID])
GO
ALTER TABLE [Addresses] CHECK CONSTRAINT [FK_Addresses_AddressTypes]
GO
ALTER TABLE [Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Subscribers] FOREIGN KEY([iSubscriberIDFK])
REFERENCES [Subscribers] ([iSubscriberID])
GO
ALTER TABLE [Addresses] CHECK CONSTRAINT [FK_Addresses_Subscribers]
GO
