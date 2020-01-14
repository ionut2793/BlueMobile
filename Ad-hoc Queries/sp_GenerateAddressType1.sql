
drop procedure if exists dbo.sp_GenerateAddressType1
go
create proc sp_GenerateAddressType1


as
Begin

Begin Try
Begin Transaction



declare @iTypeAddressIDFK int = 0 
declare @LL int = 1

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


	drop table  if exists tempdb.#Add
	select  replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(AddressLine1,'0',''),'1',''),'2',''),'3',''),'4',''),'5',''),'6',''),'7',''),'8',''),'9',''),'#',''),',','') as [Address], 
	        City, StateProvinceCode,[Name] as Country
    into #Add
 	from [AdventureWorks2017].[Person].[Address] as A	
	inner join [AdventureWorks2017].[Person].[StateProvince] as B 
	on A.StateProvinceID=B.StateProvinceID  
	
	drop table  if exists tempdb.#Add1
	select top 100000 ROW_NUMBER() over (order by (select null)) as ID, fn.[Address], ln.City,fn.StateProvinceCode,fn.Country
	into #Add1
	from
	(select distinct [Address],StateProvinceCode,Country from #Add) fn
	cross join
	(select distinct City  from #Add) ln

	--select  * from #Add1 

declare @counter int
set @counter = 1

while (@counter <= 100000)
begin

	--select @iTypeAddressIDFK=FLOOR(RAND()*(@ul-@LL+1))+@LL;
	select @iTypeAddressIDFK=1;
	select @iHouseNumber=FLOOR(RAND()*(@nr2-@nr1+1))+@nr1;
	select @cZipCode=FLOOR(RAND()*(@zip2-@zip1+1))+@zip1;
	select @nvcEmail = (select  vcFirstName+'.'+vcLastName+''+cast( FLOOR(RAND()*(99999-10000+1))+10000 as nvarchar(20))+'@adventure-works.com' as Email FROM [BlueMobile].[dbo].[Subscribers] where iSubscriberID=@counter)
	select @iSubscriberIDFK=ID,@Address=[Address],@City=City,@StateProvinceCode=StateProvinceCode,@Country=Country from #Add1 where ID=@counter
	select @iPhoneNumber=(cast( FLOOR(RAND()*(218-212+1))+212 as nvarchar(20))+'-'+ cast( FLOOR(RAND()*(500-100+1))+100 as nvarchar(20))+'-'+ cast( FLOOR(RAND()*(9999-1000+1))+1000 as nvarchar(20)));

   insert into [BlueMobile].[dbo].[Addresses] ( iSubscriberIDFK, vcStreet, iPhoneNumber,nvcEmail,iTypeAddressIDFK,iHouseNumber,cZipCode,vcCity,vcState,vcCountry)
   values (@iSubscriberIDFK, @Address, @iPhoneNumber, @nvcEmail, @iTypeAddressIDFK, @iHouseNumber, @cZipCode, @City, @StateProvinceCode, @Country)

    Set @counter = @counter+1 
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






