

drop procedure if exists dbo.sp_GenerateSubscription
go
create proc sp_GenerateSubscription

as
Begin

Begin Try
Begin Transaction


Declare @limit int
select  @limit = (select count(*) FROM [BlueMobile].[dbo].[Subscribers] )

Declare @iSubscriberIDFK int
Declare @iSimCardIDFK int
Declare @iProductIDFK int 
Declare @dtStartDate datetime
Declare @iTransactionTypeIDFK int



declare @counter int
set @counter = 1

while (@counter <= @limit)
begin
	
	Declare @iDocumentTypeIDFK int = (select iDocumentTypeID from [dbo].[DocumentTypes]  where vcDocumentTypeName='Subscription') 
	select  @iProductIDFK = (ltrim(str( FLOOR(RAND()*(3-1+1))+1,25,0)))
	Declare @iDocumentStatusIDFK int = (select iDocumentStatusID from [dbo].[DocumentsStatus] where vcDocumentStatusName='active')
	select  @iSubscriberIDFK=iSubscriberID, @dtStartDate=dtJoinDate,@iSimCardIDFK=@counter FROM [BlueMobile].[dbo].[Subscribers] where iSubscriberID=@counter

	insert into [BlueMobile].[dbo].[Documents](iDocumentTypeIDFK,iSubscriberIDFK,iSimCardIDFK,iProductIDFK,dtStartDate,dtEndDate,iDocumentStatusIDFK,dtDueDate) 
	values(@iDocumentTypeIDFK,@iSubscriberIDFK,@iSimCardIDFK,@iProductIDFK,@dtStartDate,dateadd(YEAR,2,@dtStartDate),@iDocumentStatusIDFK,@dtStartDate)

	print 'am introdus in documents'

	DECLARE @iDocumentIDFK int
	select  @iDocumentIDFK=SCOPE_IDENTITY()
	Select  @iTransactionTypeIDFK =2

	insert into [BlueMobile].[dbo].[Transactions](iDocumentIDFK,iTransactionTypeIDFK,dtTransactionDate) 
	values(@iDocumentIDFK,@iTransactionTypeIDFK,@dtStartDate) 	
		 


	print 'am introdus in transaction'



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




--delete from  [BlueMobile].[dbo].[Documents] where iSimCardID >66


--DBCC CHECKIDENT('[BlueMobile].[dbo].[CalculateRewardPoints]',reseed,0)
--DBCC CHECKIDENT('[BlueMobile].[dbo].[Transactions]',reseed,0)
--DBCC CHECKIDENT('[BlueMobile].[dbo].[Payments]',reseed,0)
--DBCC CHECKIDENT('[BlueMobile].[dbo].[Documents]',reseed,0)


