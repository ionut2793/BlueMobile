drop procedure if exists [dbo].[sp_CalculateNumberOfSms]
go
create procedure [dbo].[sp_CalculateNumberOfSms]

@dtStartDate datetime,
@dtEndDate datetime

as 
Begin

	select

		iSubscriberIDFK,
		count(iLogTypeIDFK) as  NumarSMS
	
    into #tab1
	FROM [BlueMobile].[dbo].[SimCardLogs]
	
	where iLogTypeIDFK in(1,2) and convert(date,dtSimCardLogDateTime) between DATEFROMPARTS (year(@dtStartDate),1,1) and @dtEndDate
	group by iSubscriberIDFK

	   
select 

	A.*,
	sum(CostSMS)  over ( partition by A.iSubscriberIDFK  order by NumarLuna)   as [CostSMS-YTD],
	sum(NumarSMS) over ( partition by A.iSubscriberIDFK  order by NumarLuna )  as [NumarSMS-YTD]

from(

Select 
   
    A.iSubscriberIDFK,
    D.vcFirstName,
    D.vcLastName,
    E.vcCountry,
    E.vcState,
    count(iLogTypeIDFK) as NumarSMS,
	
    F.NumarSMS as YTD,
	month(convert(date,dtSimCardLogDateTime)) as NumarLuna, 
	datename(month,dtSimCardLogDateTime) as NumeLuna,
	case 
	when  count(iLogTypeIDFK) > 10 then (count(iLogTypeIDFK)-10)*0.03
	else 0
	end as CostSMS

 
   FROM [BlueMobile].[dbo].[SimCardLogs] as A
	inner join [BlueMobile].[dbo].[Subscribers] as D
	on A.iSubscriberIDFK=D.iSubscriberID
	inner join [BlueMobile].[dbo].[Addresses] as E
	on A.iSubscriberIDFK=E.iSubscriberIDFK
	left join #tab1 as F
	on A.iSubscriberIDFK=F.iSubscriberIDFK

  where A.iLogTypeIDFK in(1,2)  and convert(date,A.dtSimCardLogDateTime) between @dtStartDate and @dtEndDate  and E.iTypeAddressIDFK=2
  group by  A.iSubscriberIDFK, D.vcFirstName, D.vcLastName, E.vcCountry, E.vcState,  F.NumarSMS,month(convert(date,dtSimCardLogDateTime)),datename(month,dtSimCardLogDateTime)
  --order by  A.iSubscriberIDFK, month(convert(date,dtSimCardLogDateTime))
 ) as A
  
End