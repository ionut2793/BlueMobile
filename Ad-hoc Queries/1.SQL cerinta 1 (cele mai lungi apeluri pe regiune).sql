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
	  ,B.vcState
	  ,DENSE_RANK() over (Partition by vcState order by DATEDIFF(SECOND,dtStartDateTime,dtEndDateTime)/60.00 desc) as RankDense	  
  FROM [BlueMobile].[dbo].[SimCardLogs] as A
  inner join [BlueMobile].[dbo].[Addresses] as B
  on A.iSubscriberIDFK=B.iSubscriberIDFK
  where iLogTypeIDFK in(3,4)
)
  select  distinct Durata,vcState from cte
  where RankDense between 1 and 3
  order  by  Durata desc
  