
alter proc sp_CalculateCostMinutes
as
Begin

Begin Try
Begin Transaction


drop table  if exists tempdb.#minute
drop table  if exists tempdb.#sms

 drop table  if exists tempdb.#tmp2
 
 --1) Calculam minutele acumulate ( Numere Favorite )
  
 Select 
   A.iSubscriberIDFK,
   A.iSimCardIDFK,
   B.iDocumentID,
   A.iLogTypeIDFK,
   B.iProductIDFK,  
   C.mCostWeekdaysInside  as Cost1,
   C.mCostWeekendsInside  as Cost2,
   C.mCostWeekdaysOutside as Cost3,
   C.mCostWeekendsOutside as Cost4,
   C.mCostMinExtra as Cost5,
   C.iMinute,
   C.iMinExtra,
   A.vcPhoneNumber,
   D.vcFavoriteNumber,
   case when A.vcPhoneNumber=D.vcFavoriteNumber then 1
   else 0
   end as VerificaNrFavorit,
   DATEDIFF(SECOND,A.dtStartDateTime,A.dtEndDateTime) as SecundeVorbite,
   DATEDIFF(SECOND,A.dtStartDateTime,A.dtEndDateTime)/60.00 as MinuteVorbite,
   A.dtStartDateTime as DataApel,
   A.dtEndDateTime AS DataSfarsitApel,
   SUM( DATEDIFF(SECOND,A.dtStartDateTime,A.dtEndDateTime)/60.00) 
   OVER (partition by A.iSubscriberIDFK, A.iSimCardIDFK,  B.iProductIDFK,concat( year(B.dtStartDate),month(B.dtStartDate))  order by A.dtStartDateTime) as TotalMinVorbiteLaData,
   B.dtStartDate, 
   B.dtEndDate
    
into #tmp2

FROM [BlueMobile].[dbo].[SimCardLogs] as A
	inner join [BlueMobile].[dbo].[Documents] as B 
	  on A.iSubscriberIDFK=B.iSubscriberIDFK and A.iSimCardIDFK=B.iSimCardIDFK	  
	inner join   [BlueMobile].[dbo].[Products] as C 
	  on B.iProductIDFK=C.iProductID
	left join	[BlueMobile].[dbo].[FavoriteNumbers] as D
	  on B.iSimCardIDFK=D.iSimCardIDFK  and A.vcPhoneNumber=D.vcFavoriteNumber
    left join [dbo].[Payments] as BBB
	  on B.iDocumentID =BBB.iDocumentIDFK 

	
	where B.iDocumentTypeIDFK=1 and A.iLogTypeIDFK in (3,4) and dtSimCardLogDateTime between B.dtStartDate and dtEndDate  
	and D.vcFavoriteNumber IS NOT NULL AND BBB.iDocumentIDFK IS  NULL 
	order by DataApel 

	--select * from #tmp2 order by DataApel 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

drop table  if exists tempdb.#tmp1
 --1.1) Calculam minutele acumulate (Numerele care nu sunt la Favorite)
 Select 
   A.iSubscriberIDFK,
   A.iSimCardIDFK,
   B.iDocumentID,
   A.iLogTypeIDFK,
   B.iProductIDFK,  
   C.mCostWeekdaysInside  as Cost1,
   C.mCostWeekendsInside  as Cost2,
   C.mCostWeekdaysOutside as Cost3,
   C.mCostWeekendsOutside as Cost4,
   C.mCostMinExtra as Cost5,
   C.iMinute,
   C.iMinExtra,
   A.vcPhoneNumber,
   D.vcFavoriteNumber,
   case when A.vcPhoneNumber=D.vcFavoriteNumber then 1
   else 0
   end as VerificaNrFavorit,
   DATEDIFF(SECOND,A.dtStartDateTime,A.dtEndDateTime) as SecundeVorbite,
   DATEDIFF(SECOND,A.dtStartDateTime,A.dtEndDateTime)/60.00 as MinuteVorbite,
   A.dtStartDateTime as DataApel,
   A.dtEndDateTime AS DataSfarsitApel,
   SUM( DATEDIFF(SECOND,A.dtStartDateTime,A.dtEndDateTime)/60.00) 
   OVER (partition by A.iSubscriberIDFK, A.iSimCardIDFK,  B.iProductIDFK,concat( year(B.dtStartDate),month(B.dtStartDate))  order by A.dtStartDateTime) as TotalMinVorbiteLaData,
   B.dtStartDate, 
   B.dtEndDate
   

into #tmp1

 FROM [BlueMobile].[dbo].[SimCardLogs] as A
	inner join [BlueMobile].[dbo].[Documents] as B 
	  on A.iSubscriberIDFK=B.iSubscriberIDFK and A.iSimCardIDFK=B.iSimCardIDFK
	inner join   [BlueMobile].[dbo].[Products] as C 
	  on B.iProductIDFK=C.iProductID
	left join	[BlueMobile].[dbo].[FavoriteNumbers] as D
	  on B.iSimCardIDFK=D.iSimCardIDFK  and A.vcPhoneNumber=D.vcFavoriteNumber
    left join [dbo].[Payments] as BBB
	on B.iDocumentID =BBB.iDocumentIDFK 

	
	where B.iDocumentTypeIDFK=1 and A.iLogTypeIDFK in (3,4) and dtSimCardLogDateTime between B.dtStartDate and dtEndDate  
	and D.vcFavoriteNumber IS NULL and BBB.iDocumentIDFK IS  NULL 
	order by DataApel

	--select *from #tmp1 order by DataApel

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 --2) Calculez minutele pentru numerele Favorite

 drop table  if exists tempdb.#NrFav

 select

  iSubscriberIDFK,
  iSimCardIDFK,
  iDocumentID,
  sum(MinutePtFacturare_v1) as MinuteVorbite,
  sum(MinutePtFacturare_v1*CostFriends) as CostMinute,
  sum(MinutePtFacturare_v2) as MinuteExtraVorbite,
  sum(MinutePtFacturare_v2*CostFriendsExtra) as CostMinExtra

 into #NrFav

  from
  (
select
  iSubscriberIDFK,
  iSimCardIDFK,
  iDocumentID,
  iLogTypeIDFK,
  iProductIDFK,
  vcPhoneNumber,
  vcFavoriteNumber,
  VerificaNrFavorit,
  DataApel,
  case when vcPhoneNumber like '212%' then 'in retea'
  else 'in afara retelei'
  end as TipulApelului,
  DATENAME(WEEKDAY,DataApel) as Ziua,
  case 
	when  iProductIDFK=2 and VerificaNrFavorit='1'   then Cost5
	else -99
 end as CostFriends,

  case 
	 when  DATENAME(WEEKDAY,DataApel) in ('Monday','Tuesday','Wednesday','Thursday','Friday') and vcPhoneNumber like '212%' and iProductIDFK=2    then Cost1
	 when  DATENAME(WEEKDAY,DataApel) in ('Saturday','Sunday') and vcPhoneNumber like '212%'  and iProductIDFK=2   then Cost2
	 when  DATENAME(WEEKDAY,DataApel) in ('Monday','Tuesday','Wednesday','Thursday','Friday') and vcPhoneNumber not like '212%' and iProductIDFK=2  then Cost3
	 when  DATENAME(WEEKDAY,DataApel) in ('Saturday','Sunday') and vcPhoneNumber not like '212%'   and iProductIDFK=2  then Cost4   
	else -99
  end as CostFriendsExtra,

  iMinute,
  iMinExtra,
  tab.MinuteVorbite,
  tab.TotalMinVorbiteLaData,
  tab.IMinuteRamase,
  iMinuteDisponibileLaDataApel,
  case 
	when TotalMinVorbiteLaData<=iMinuteDisponibileLaDataApel and IMinuteRamase > 0 then iMinuteDisponibileLaDataApel-IMinuteRamase
	when TotalMinVorbiteLaData>iMinExtra and IMinuteRamase = 0 then iMinuteDisponibileLaDataApel - tab.IMinuteRamase
  end as MinutePtFacturare_v1,
  case 
	when TotalMinVorbiteLaData>iMinExtra then tab.MinuteVorbite-iMinuteDisponibileLaDataApel
	else 0
  end as MinutePtFacturare_v2,
  dtStartDate,
  dtEndDate
  
  	from
	(

   	select  t.*, 
		 case  
			 when iProductIDFK=2  then  LAG(t.IMinuteRamase,1,t.iMinExtra)   over ( partition by t.iSubscriberIDFK, t.iSimCardIDFK, t.iProductIDFK,concat( year(dtStartDate),month(dtStartDate)) order by DataApel)  
		 end as iMinuteDisponibileLaDataApel
		
	from
		(
		select t.*,
				 case
					when t.TotalMinVorbiteLaData<iMinExtra then t.iMinExtra-t.TotalMinVorbiteLaData
					when t.TotalMinVorbiteLaData>200 then 0
				end as IMinuteRamase

		from #tmp2 t
		) t
	) as tab 
 )tab1  
 group by iSubscriberIDFK,iSimCardIDFK,iDocumentID  
 --SELECT *FROM #NrFav order by DataApel

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
drop table  if exists tempdb.#NrNeFav
--2.1) Calculez minutele pentru numerele Nefavorite
Declare @set int = 0 
select

  iSubscriberIDFK,
  iSimCardIDFK,
  iDocumentID,
  sum(MinutePtFacturare_v1) as MinuteVorbite,
  sum(MinutePtFacturare_v1*Cost) as CostMinute,
  @set as MinuteExtraVorbite,
  @set as CostPerMinuteExtra
  
into #NrNeFav

  from
  (
select
  iSubscriberIDFK,
  iSimCardIDFK,
  iDocumentID,
  iLogTypeIDFK,
  iProductIDFK,
  vcPhoneNumber,
  vcFavoriteNumber,
  VerificaNrFavorit,
  DataApel,
  case when vcPhoneNumber like '212%' then 'in retea'
  else 'in afara retelei'
  end as TipulApelului,
  DATENAME(WEEKDAY,DataApel) as Ziua,
  case when  DATENAME(WEEKDAY,DataApel) in ('Monday','Tuesday','Wednesday','Thursday','Friday') and vcPhoneNumber like '212%'    then Cost1
	   when  DATENAME(WEEKDAY,DataApel) in ('Saturday','Sunday') and vcPhoneNumber like '212%'    then Cost2
	   when  DATENAME(WEEKDAY,DataApel) in ('Monday','Tuesday','Wednesday','Thursday','Friday') and vcPhoneNumber not like '212%' then Cost3
	   when  DATENAME(WEEKDAY,DataApel) in ('Saturday','Sunday') and vcPhoneNumber not like '212%'    then Cost4
	   else -99
  end as Cost,
  iMinute,
  iMinExtra,
  tab.MinuteVorbite,
  tab.TotalMinVorbiteLaData,
  tab.IMinuteRamase,
  iMinuteDisponibileLaDataApel,
 case 
	when TotalMinVorbiteLaData<=iMinuteDisponibileLaDataApel then 0
	when TotalMinVorbiteLaData>iMinute then tab.MinuteVorbite-iMinuteDisponibileLaDataApel
  end as MinutePtFacturare_v1,
  dtStartDate,
  dtEndDate
  
  from
	(
   	select  t.*, 
		 case  
		 when iProductIDFK in (1,3) then  LAG(t.IMinuteRamase,1,t.iMinute)   over ( partition by t.iSubscriberIDFK, t.iSimCardIDFK, t.iProductIDFK,concat( year(dtStartDate),month(dtStartDate)) order by DataApel)  
		 when iProductIDFK=2        then  LAG(t.IMinuteRamase,1,t.iMinute) over ( partition by t.iSubscriberIDFK, t.iSimCardIDFK, t.iProductIDFK,concat( year(dtStartDate),month(dtStartDate)) order by DataApel)
		 end as iMinuteDisponibileLaDataApel
	from
		(
		select t.*,
				 case
					when t.TotalMinVorbiteLaData<iMinute then t.iMinute-t.TotalMinVorbiteLaData
					when t.TotalMinVorbiteLaData>20 then 0
				end as IMinuteRamase

		from #tmp1 t
		) t
	) as tab 
 )tab1  
 group by iSubscriberIDFK,iSimCardIDFK,iDocumentID
 
 --select *from #NrNeFav order by DataApel
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--3) aici imi face costul minutelor pe SIM si Subscriber
drop table  if exists tempdb.#minute

 select 
	D.iSubscriberIDFK,
	D.iSimCardIDFK,
	D.iDocumentID,
	D.MinuteVorbite,
	D.CostMinute,
	D.MinuteExtraVorbite,
	D.CostMinExtra


into #minute	
 from(
   select * from #NrFav
   Union
   select * from #NrNeFav) as D
  
  -- select * from #minute
     
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--4) aici imi aduce costul sms -urilor pe SIM si Subscriber

select
	tab1.*,
	mCostSms*SMStoPaid as CostSmsToPaid
into #sms

from
(

Select
  tab.*,
  case when NumarSMS>iSms then NumarSms-iSms
  else 0
  end as SMStoPaid

  
from
 (

Select 
   
   A.iSubscriberIDFK,
   A.iSimCardIDFK,
   B.iDocumentID,
  -- A.iLogTypeIDFK,
   count(iLogTypeIDFK) as NumarSMS,
   B.iProductIDFK,
   C.iSms,
   C.mCostSms
 
 
  FROM [BlueMobile].[dbo].[SimCardLogs] as A
	inner join [BlueMobile].[dbo].[Documents] as B
	on A.iSubscriberIDFK=B.iSubscriberIDFK and A.iSimCardIDFK=B.iSimCardIDFK
	inner join   [BlueMobile].[dbo].[Products] as C 
	on B.iProductIDFK=C.iProductID
	left join [dbo].[Payments] as BBB
	on B.iDocumentID =BBB.iDocumentIDFK 
  where B.iDocumentTypeIDFK=1 and (A.iLogTypeIDFK=1 or A.iLogTypeIDFK=2) and dtSimCardLogDateTime between B.dtStartDate and dtEndDate and BBB.iDocumentIDFK IS  NULL
  group by  A.iSubscriberIDFK,B.iProductIDFK,C.iSms,C.mCostSms, A.iSimCardIDFK,B.iDocumentID
  ) as tab
  ) as tab1

  --select * from #sms
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--5) imi face calculul total (sms + minute) pe SIM si Subscriber    +CostMinExtra
select
iSubscriberIDFK,iSimCardIDFK,iDocumentID,sum(CostTotal) as CostSmsMinute
from
(

select iSubscriberIDFK,iSimCardIDFK,iDocumentID,sum(CostMinute+CostMinExtra) as CostTotal from #minute group by iSubscriberIDFK,iSimCardIDFK,iDocumentID
union all
select iSubscriberIDFK,iSimCardIDFK,iDocumentID,sum(CostSmsToPaid) as CostTotal from #sms group by iSubscriberIDFK,iSimCardIDFK,iDocumentID
) as A
group by iSubscriberIDFK,iSimCardIDFK,iDocumentID




		Commit Transaction
	End try
	Begin catch
 -- report exception
        EXEC usp_report_error;
        
        -- Test if the transaction is uncommittable.  
        IF (XACT_STATE()) = -1  
        BEGIN  
            PRINT  N'The transaction is in an uncommittable state.' +  
                    'Rolling back transaction.'  
            ROLLBACK TRANSACTION;  
        END;  
        
        ---- Test if the transaction is committable.  
        --IF (XACT_STATE()) = 1  
        --BEGIN  
        --    PRINT N'The transaction is committable.' +  
        --        'Committing transaction.'  
        --    COMMIT TRANSACTION;     
        --END;  
	End catch
End
