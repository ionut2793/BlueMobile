USE [BlueMobile]
drop procedure if exists dbo.sp_Create_Logs_SimCards
go

create procedure sp_Create_Logs_SimCards

as 
Begin

 	Begin Try
		Begin Transaction

declare @LL int
set @LL=1         
declare @ul int
set @ul =2

declare @aa int
set @aa=3            
declare @bb int
set @bb = 4

declare @iLogTypeIDFK12 int = 0
declare @iLogTypeIDFK34 int = 0
declare @iSubscriberIDFK int = 0
declare @iSimCardIDFK int =0
declare @vcPhoneNumber varchar(50)
declare @dtSimCardLogDateTime12 datetime
declare @dtSimCardLogDateTime34 datetime
declare @dtStartDateTime datetime
declare @dtEndDateTime datetime

declare @counter int
set @counter =1

declare @counter1 int
set @counter1 =1

declare @counter2 int
set @counter2 =1

--declare @limit int

drop table  if exists tempdb.#tmp1
drop table  if exists tempdb.#tmp2

SELECT iDocumentID--,iSubscriberIDFK, iSimCardIDFK, dtStartDate
	into #tmp1
	FROM [BlueMobile].[dbo].[Documents] 
where iDocumentStatusIDFK=1 and iDocumentTypeIDFK=2

Select ROW_NUMBER() over (order by iSubscriberIDFK) as id, iSubscriberIDFK,iSimCardIDFK,dtStartDate,dtEndDate
into #tmp2
	from [BlueMobile].[dbo].[Documents] as A
	inner join  #tmp1 as B
	on A.iDocumentID=B.iDocumentID
where iDocumentStatusIDFK=1 and iDocumentTypeIDFK=2

select *from #tmp2

declare @limit int
select @limit = (select count(*) from #tmp2)



while (@counter <= @limit)
begin

set @counter1 =1
set @counter2 =1

	while (@counter1 <=10)
	begin	

    select @iSubscriberIDFK=iSubscriberIDFK,@iSimCardIDFK=iSimCardIDFK,@dtStartDateTime=dtStartDate,@dtEndDateTime=dtEndDate  
	from #tmp2 
	where id=@counter



	select @iLogTypeIDFK12=Round(((@ul-@LL)*RAND()+1),0)
	--select @iLogTypeIDFK34=Round(((@bb-@aa)*RAND()+1),0)
	select @vcPhoneNumber=( cast( FLOOR(RAND()*(213-212+1))+212 as nvarchar(20))+'-'+ cast( FLOOR(RAND()*(500-100+1))+100 as nvarchar(20))+'-' + cast( FLOOR(RAND()*(9999-1000+1))+1000 as nvarchar(20)))

	SELECT    @dtSimCardLogDateTime12   = 
    DATEADD(day, ROUND(DATEDIFF(day, @dtStartDateTime, dateadd( MONTH,3,@dtStartDateTime)) * RAND(CHECKSUM(NEWID())), 0),
    DATEADD(second, CHECKSUM(NEWID()) % 48000, @dtStartDateTime))
			   
   insert into [BlueMobile].[dbo].[SimCardLogs] (iLogTypeIDFK, iSubscriberIDFK,iSimCardIDFK,vcPhoneNumber,dtSimCardLogDateTime)            -- aici introduce sms - uri
   values (@iLogTypeIDFK12,@iSubscriberIDFK,@iSimCardIDFK,@vcPhoneNumber,@dtSimCardLogDateTime12)

   set @counter1 = @counter1+1;

   end
   
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   while (@counter2 <=10)
   begin	

   	select @iSubscriberIDFK=iSubscriberIDFK,@iSimCardIDFK=iSimCardIDFK,@dtStartDateTime=dtStartDate,@dtEndDateTime=dtEndDate  
	from #tmp2 
	where id=@counter

	--select @iLogTypeIDFK12=Round(((@ul-@LL)*RAND()+1),0)
    select @iLogTypeIDFK34=Round(((@bb-@aa)*RAND()+3),0)
	select @vcPhoneNumber=( cast( FLOOR(RAND()*(213-212+1))+212 as nvarchar(20))+'-'+ cast( FLOOR(RAND()*(500-100+1))+100 as nvarchar(20))+'-' + cast( FLOOR(RAND()*(9999-1000+1))+1000 as nvarchar(20)))
	
   SELECT    @dtSimCardLogDateTime34   = 
   DATEADD(day, ROUND(DATEDIFF(day, @dtStartDateTime, dateadd( MONTH,3,@dtStartDateTime)) * RAND(CHECKSUM(NEWID())), 0),
   DATEADD(second, CHECKSUM(NEWID()) % 48000, @dtStartDateTime))
   declare @randminute int
   select  @randminute=Round(((50-5)*RAND()+1),0)
   select  @randminute
    
   insert into [BlueMobile].[dbo].[SimCardLogs] (iLogTypeIDFK, iSubscriberIDFK,iSimCardIDFK,vcPhoneNumber,dtSimCardLogDateTime,dtStartDateTime,dtEndDateTime)                         -- aici introduce  minute 
   values (@iLogTypeIDFK34,@iSubscriberIDFK,@iSimCardIDFK,@vcPhoneNumber,@dtSimCardLogDateTime34,@dtSimCardLogDateTime34,dateadd( MINUTE,@randminute,@dtSimCardLogDateTime34))


	set @counter2 = @counter2+1;
	end 


     Set @counter = @counter+1 
 end
			Commit Transaction

	End try
	Begin catch
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


