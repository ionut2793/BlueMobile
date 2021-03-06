USE [BlueMobile]
GO
/****** Object:  Table [FavoriteNumbers]    Script Date: 12/13/2019 3:17:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FavoriteNumbers](
	[iFavoritNumberID] [int] IDENTITY(1,1) NOT NULL,
	[iSimCardIDFK] [int] NOT NULL,
	[vcFavoriteNumber] [varchar](25) NULL,
	[sdtDateCreated] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_FavoriteNumbers] PRIMARY KEY CLUSTERED 
(
	[iFavoritNumberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [FavoriteNumbers] ADD  CONSTRAINT [DF__FavoriteN__DateC__19DFD96B]  DEFAULT (getdate()) FOR [sdtDateCreated]
GO
ALTER TABLE [FavoriteNumbers]  WITH CHECK ADD  CONSTRAINT [FK_FavoriteNumbers_SimCards] FOREIGN KEY([iSimCardIDFK])
REFERENCES [SimCards] ([iSimCardID])
GO
ALTER TABLE [FavoriteNumbers] CHECK CONSTRAINT [FK_FavoriteNumbers_SimCards]
GO
