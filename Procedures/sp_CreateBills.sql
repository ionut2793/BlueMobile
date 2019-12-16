drop procedure if exists dbo.sp_CreateBills
go

create procedure sp_CreateBills	

as 
Begin
  ------------------------------------------------------------------------------------------------------------------------------------------------------------------
  		Begin Try
		Begin Transaction
    
  DROP TABLE IF EXISTS #docfortran
  create table #docfortran
  (
  iDocumentID int
  )
  
-- pentru primul insert
  Declare @iDocumentTypeIDFK int = (select iDocumentTypeID from [dbo].[DocumentTypes]  where vcDocumentTypeName='Bill')

  if not exists(select iDocumentTypeIDFK from [dbo].[Documents]  where iDocumentTypeIDFK=1)  
  Begin
    
   insert into [BlueMobile].[dbo].[Documents](iDocumentTypeIDFK,iSubscriberIDFK,iSimCardIDFK,iProductIDFK,dtStartDate,dtEndDate,iDocumentStatusIDFK,iSubscriptionID)
   output inserted.iDocumentID into #docfortran
   SELECT
          @iDocumentTypeIDFK,
		  iSubscriberIDFK,
		  iSimCardIDFK,
		  iProductIDFK,
		  dtStartDate,
		  dateadd(month,1,dtStartDate),
		  iDocumentStatusIDFK,
		  iDocumentID
		  
	FROM [BlueMobile].[dbo].[Documents] 
	where (iDocumentTypeIDFK=2 and iDocumentStatusIDFK=1 and dtStartDate <=cast(GETDATE() as date))

	print 'am introdus in BillingJob'

	end 
else
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--pentru update bill 

  if exists(select iDocumentTypeIDFK from [dbo].[Documents]  where iDocumentTypeIDFK=1)  
  Begin

  insert into [BlueMobile].[dbo].[Documents](iDocumentTypeIDFK,iSubscriberIDFK,iSimCardIDFK,iProductIDFK,dtStartDate,dtEndDate,iDocumentStatusIDFK,iSubscriptionID)
  output inserted.iDocumentID into #docfortran
  select  
    	   @iDocumentTypeIDFK,
		   iSubscriberIDFK,
		   iSimCardIDFK,
		   iProductIDFK,
		   dateA,
		   dateadd(month,1,dateA),
		   iDocumentStatusIDFK,
		   iSubscriptionID
  from
  (
		SELECT
	       C.iSubscriberIDFK,
		   C.iSimCardIDFK,
		   C.iProductIDFK,
		   max(dtEndDate) as dateA,
		   C.iDocumentStatusIDFK,
		   D.iDocumentID as iSubscriptionID,                             -- isi ia pt care face update si nu pt abonament.          
		   dateadd(month,1,max(dtEndDate)) as dateB
		FROM [BlueMobile].[dbo].[Documents] as C
		inner join(
		Select
			iDocumentID,
			iSubscriberIDFK,
			iSimCardIDFK,
			iProductIDFK
		
			from [BlueMobile].[dbo].[Documents]
			where iDocumentTypeIDFK=2 and iSubscriptionID IS  NULL 
			) as D  
			on C.iSubscriberIDFK=D.iSubscriberIDFK and C.iSimCardIDFK=D.iSimCardIDFK and C.iProductIDFK=D.iProductIDFK
			where iDocumentTypeIDFK=1 and iDocumentStatusIDFK=1
			group by C.iSubscriberIDFK, C.iSimCardIDFK,C.iProductIDFK, C.iDocumentStatusIDFK,  D.iDocumentID
	) as E 
	where cast(dateB as date)< cast(getdate() as Date)

	print'am introdus update bill - luna noua'

	end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- update cand se genereaza un nou bill pentru dtDueDate--- 
 
	update  D set D.dtDueDate=F.LastDueDate
	from [BlueMobile].[dbo].[Documents] as D
		inner join (  
		select 
				iSubscriberIDFK,
				iSimCardIDFK, 
				max(dtStartDate) as LastDueDate
		from [BlueMobile].[dbo].[Documents]
		where iDocumentTypeIDFK=1 
		group by iSubscriberIDFK,iSimCardIDFK) as F on 
		D.iSubscriberIDFK=F.iSubscriberIDFK and D.iSimCardIDFK=F.iSimCardIDFK
	where D.iDocumentTypeIDFK=2
	
    print'am actualizat dtDueDate la fiecare subscriptie'

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 --- adaug in transactions fiecare bill---

	  declare @dataTran datetime = getdate()
	  Declare @iT int = (select iTransactionTypeID from [dbo].[TransactionTypes]  where vcTransactionType='Bill')
	  insert into [BlueMobile].[dbo].[Transactions] (iDocumentIDFK,iTransactionTypeIDFK,dtTransactionDate) 
	  select iDocumentID,@iT,@dataTran from #docfortran

	  print'am adaugat in [Transactions]'
	 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

		Commit Transaction

	End try
	Begin catch
		Rollback Transaction
		print 'am intrat in rollback - problemee'
	End catch
End



--sp_BillingJob

