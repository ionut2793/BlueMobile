/****** Script for SelectTopNRows command from SSMS  ******/
with cte as
(
SELECT
	   [iCallLogID]
      ,[iLogTypeIDFK]
      ,A.[iSubscriberIDFK]
      ,[iSimCardIDFK]
      ,[vcPhoneNumber]
      ,[dtSimCardLogDateTime]
      ,[dtStartDateTime]
      ,[dtEndDateTime]
	  ,DATEDIFF(SECOND,dtStartDateTime,dtEndDateTime)/60.00 as Durata
	  ,DENSE_RANK() over (Partition by A.[iSubscriberIDFK] order by DATEDIFF(SECOND,dtStartDateTime,dtEndDateTime)/60.00 desc) as RankDense
	  ,C.vcFirstName
	  ,C.vcLastName
	  ,B.vcState
	  ,B.vcStreet
	  ,B.vcCity
	  ,row_number() over (Partition by A.[iSubscriberIDFK] order by DATEDIFF(SECOND,dtStartDateTime,dtEndDateTime)/60.00 desc) as RowNumber
  FROM [BlueMobile].[dbo].[SimCardLogs] as A
  inner join [BlueMobile].[dbo].[Addresses] as B
  on A.iSubscriberIDFK=B.iSubscriberIDFK
  inner join [BlueMobile].[dbo].[Subscribers] as C
  on B.iSubscriberIDFK=C.iSubscriberID
  where iLogTypeIDFK in(3,4)
)
  select  iSubscriberIDFK,iCallLogID,vcFirstName,vcLastName,vcState,vcStreet,vcCity,Durata
  from cte
  where RowNumber=1
