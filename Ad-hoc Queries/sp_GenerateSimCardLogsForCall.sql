drop procedure if exists dbo.sp_GenerateSimCardLogsForCall
go
create proc sp_GenerateSimCardLogsForCall

@firstparam int,
@secondparam int

as
Begin

Begin Try
Begin Transaction


drop table  if exists tempdb.#tmp1
drop table  if exists tempdb.#tmp2

;with subscribers as (

Select ROW_NUMBER() over (order by iSubscriberIDFK) as id, iSubscriberIDFK,iSimCardIDFK,dtStartDate,dtEndDate
from [BlueMobile].[dbo].[Documents]
where iDocumentStatusIDFK=1 and iDocumentTypeIDFK=2

 )
 select *
 into #tmp1
 from subscribers where id between @firstparam and @secondparam

-- select * from #tmp1

    ; with random as
   (
    	select 1 as id, phone= ( cast( FLOOR(RAND(checksum(newid()))*(219-210+1))+210 as nvarchar(20))+'-'+ cast( FLOOR(RAND(checksum(newid()))*(500-100+1))+100 as nvarchar(20))+'-' + cast( FLOOR(RAND(checksum(newid()))*(9999-1000+1))+1000 as nvarchar(20))),
		iLogTypeIDFK12=Round(((4-3)*RAND(checksum(newid()))+3),0)
		union all
		select ID+1 as id, phone= ( cast( FLOOR(RAND(checksum(newid()))*(219-210+1))+210 as nvarchar(20))+'-'+ cast( FLOOR(RAND(checksum(newid()))*(500-100+1))+100 as nvarchar(20))+'-' + cast( FLOOR(RAND(checksum(newid()))*(9999-1000+1))+1000 as nvarchar(20))),
		iLogTypeIDFK12=Round(((4-3)*RAND(checksum(newid()))+3),0)
		from random
		where id<1000000
   )
   select *
   into #tmp2
   from random
   where id between (@firstparam*10)-9  and @secondparam*10
   option ( MAXRECURSION 0)

   --select * from #tmp2

 insert into [BlueMobile].[dbo].[SimCardLogs] (iLogTypeIDFK, iSubscriberIDFK,iSimCardIDFK,vcPhoneNumber,dtSimCardLogDateTime,dtStartDateTime,dtEndDateTime)
 select
 A.iLogTypeIDFK12,A.iSubscriberIDFK,A.iSimCardIDFK,A.phone,A.dtSimCardLogDateTime34,A.dtSimCardLogDateTime34, dateadd(MINUTE,randminute,A.dtSimCardLogDateTime34)
 from(


 select nr.iLogTypeIDFK12,  t.iSubscriberIDFK, t.iSimCardIDFK, nr.phone,
	dtSimCardLogDateTime34   = 
    DATEADD(day, ROUND(DATEDIFF(day, dtStartDate, dateadd( MONTH,24,dtStartDate)) * RAND(CHECKSUM(NEWID())), 0),
    DATEADD(second, CHECKSUM(NEWID()) % 48000, dtStartDate)),
	randminute = Round(((50-5)*RAND()+1),0)

	
from #tmp1 t
cross apply
	( 
	  select *
	  from #tmp2 n
	  where n.id >(t.id-1)*10 and n.id<=t.id*10
	  ) nr
) A
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
        End catch
End 

