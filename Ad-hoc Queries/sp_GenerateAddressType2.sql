
drop procedure if exists dbo.sp_GenerateAddressType2
go
create proc sp_GenerateAddressType2

as
Begin

Begin Try
Begin Transaction


declare @iTypeAddressIDFK int = 0 
declare @iSubscriberIDFK int = 0
declare @iPhoneNumber varchar(100)

declare @iHouseNumber int = 0
declare @nr1 int = 1
declare @nr2 int= 400

declare @cZipCode int = 0
declare @zip1 int = 54402
declare @zip2 int = 60301

declare @Address  varchar(100)
declare @City  varchar(100)
declare @StateProvinceCode  varchar(100)
declare @Country  varchar(100)

declare @nvcEmail varchar(100)


declare @counter int
set @counter = 100000

while (@counter >= 0)
begin

	--select @iTypeAddressIDFK=FLOOR(RAND()*(@ul-@LL+1))+@LL;
	select @iTypeAddressIDFK=2;
	select @iHouseNumber=FLOOR(RAND()*(@nr2-@nr1+1))+@nr1;
	select @cZipCode=FLOOR(RAND()*(@zip2-@zip1+1))+@zip1;
    select @iSubscriberIDFK=iSubscriberIDFK,@Address=vcStreet,@City=vcCity,@StateProvinceCode=vcState,@Country=vcCountry,@nvcEmail=nvcEmail from [BlueMobile].[dbo].[Addresses] where iSubscriberIDFK=@counter
	select @iPhoneNumber=(cast( FLOOR(RAND()*(230-212+1))+212 as nvarchar(20))+'-'+ cast( FLOOR(RAND()*(500-100+1))+100 as nvarchar(20))+'-'+ cast( FLOOR(RAND()*(9999-1000+1))+1000 as nvarchar(20)));

   insert into [BlueMobile].[dbo].[Addresses] ( iSubscriberIDFK, vcStreet, iPhoneNumber,nvcEmail,iTypeAddressIDFK,iHouseNumber,cZipCode,vcCity,vcState,vcCountry)
   values (@iSubscriberIDFK, @Address, @iPhoneNumber, @nvcEmail, @iTypeAddressIDFK, @iHouseNumber, @cZipCode, @City, @StateProvinceCode, @Country)

    Set @counter = @counter-1 
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
















--delete from  [BlueMobile].[dbo].[Addresses] where iAddressID >100000

--DBCC CHECKIDENT('[BlueMobile].[dbo].[Addresses]',reseed,200000) 

