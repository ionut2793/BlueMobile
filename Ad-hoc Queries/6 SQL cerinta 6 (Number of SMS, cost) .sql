alter procedure [dbo].[sp_CalculateNumberOfSms]

@dtStartDate datetime,
@dtEndDate datetime

as 
Begin

	Begin Try
		Begin Transaction

Select 
   
    A.iSubscriberIDFK,
    D.vcFirstName,
    D.vcLastName,
    E.vcCountry,
    E.vcState,
    count(iLogTypeIDFK) as NumarSMS,
    F.NumarSMS as YTD

 
   FROM [BlueMobile].[dbo].[SimCardLogs] as A
	inner join [BlueMobile].[dbo].[Subscribers] as D
	on A.iSubscriberIDFK=D.iSubscriberID
	inner join [BlueMobile].[dbo].[Addresses] as E
	on A.iSubscriberIDFK=E.iSubscriberIDFK
	left join 
	(
	select 

		iSubscriberIDFK,
		count(iLogTypeIDFK) as  NumarSMS

	FROM [BlueMobile].[dbo].[SimCardLogs]
	
	where iLogTypeIDFK in(1,2) and convert(date,dtSimCardLogDateTime) between DATEFROMPARTS (year(@dtStartDate),1,1) and @dtEndDate
	group by iSubscriberIDFK
	) as F
	on A.iSubscriberIDFK=F.iSubscriberIDFK

 
  where A.iLogTypeIDFK in(1,2)  and convert(date,A.dtSimCardLogDateTime) between @dtStartDate and @dtEndDate
  group by  A.iSubscriberIDFK, D.vcFirstName, D.vcLastName, E.vcCountry, E.vcState,  F.NumarSMS

  
			Commit Transaction

	End try
	Begin catch
		Rollback Transaction
		print 'am intrat in rollback - probleme'
	End catch
End