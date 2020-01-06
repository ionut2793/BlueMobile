
SELECT
       B.[iSubscriberIDFK]
	  ,C.vcFirstName
	  ,C.vcLastName
	  ,B.vcState
	  ,B.vcStreet
	  ,B.vcCity
	  ,isnull(max(DATEDIFF(SECOND,dtStartDateTime,dtEndDateTime)/60.00),0) as Durata
	
  FROM [BlueMobile].[dbo].[Addresses] as B
	  inner join [BlueMobile].[dbo].[Subscribers] as C
	  on B.iSubscriberIDFK=C.iSubscriberID
	  left join [BlueMobile].[dbo].[SimCardLogs] as A
	  on A.iSubscriberIDFK=C.iSubscriberID   and iLogTypeIDFK in(3,4)
  group by
       B.[iSubscriberIDFK]
	  ,C.vcFirstName
	  ,C.vcLastName
	  ,B.vcState
	  ,B.vcStreet
	  ,B.vcCity

order by iSubscriberIDFK asc