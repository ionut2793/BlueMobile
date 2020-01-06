/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
	A.iProductIDFK,
	B.vcProductTypeName,
	count(iProductIDFK) as NumarAbonamente
 
  FROM [BlueMobile].[dbo].[Documents]  as A
  inner join [BlueMobile].[dbo].[Products] as B
  on A.iProductIDFK=B.iProductID
  where iDocumentTypeIDFK=2
  group by A.iProductIDFK,B.vcProductTypeName
