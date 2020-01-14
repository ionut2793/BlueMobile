
drop procedure if exists dbo.sp_GenerateSIM
go
create proc sp_GenerateSIM


as
Begin

Begin Try
Begin Transaction


declare @counter int
set @counter = 1


Declare @limit int
select @limit = (select count(*) FROM [BlueMobile].[dbo].[Subscribers] where iSubscriberID >101  )


while (@counter <= @limit)
begin

	Declare @vcIMEINumberr varchar(25)
	Select  @vcIMEINumberr = ltrim(str(FLOOR(RAND()*(999999999999999-100000000000000+1))+100000000000000,25,0))

	Declare @vcSerialNumberr varchar(25)
	select  @vcSerialNumberr=('SN'+  ltrim(str( FLOOR(RAND()*(99999999-10000000+1))+10000000,25,0)))

	Declare @vcPhoneNumber varchar(25)
	select  @vcPhoneNumber=(ltrim(str(FLOOR(RAND()*(219-210+1))+210,25,0))+'-'+ cast( FLOOR(RAND()*(999-100+1))+100 as nvarchar(20))+'-'+ cast( FLOOR(RAND()*(999999-100000+1))+100000 as nvarchar(20)));

	Declare @vcPINNumber varchar(25)
	select  @vcPINNumber=(ltrim(str( FLOOR(RAND()*(9999-1000+1))+1000,25,0)))

	Declare @vcPUKNumber varchar(25)
	select  @vcPUKNumber=(ltrim(str( FLOOR(RAND()*(99999999-10000000+1))+10000000,25,0)))

	

	insert into [BlueMobile].[dbo].[SimCards] (vcPhoneNumber,vcPINNumber,vcPUKNumber,vcIMEINumber,vcSerialNumber)  --SimCards
	values (@vcPhoneNumber,@vcPINNumber,@vcPUKNumber,@vcIMEINumberr,@vcSerialNumberr)
	


set @counter=@counter+1

end

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

