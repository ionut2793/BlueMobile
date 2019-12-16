drop procedure if exists dbo.sp_CreatePayments
go

create procedure sp_CreatePayments
as 
Begin

		
 Begin Try
 Begin Transaction


  DROP TABLE IF EXISTS #CalculateCostMinutes
  create table #CalculateCostMinutes
  (
  iSubscriberIDFK int,
  iSimCardIDFK int,
  iDocumentID int,
  CostSmsMinute money
  )
 insert into #CalculateCostMinutes exec sp_CalculateCostMinutes

--select *from #CalculateCostMinutes

  DROP TABLE IF EXISTS #docfortran
  create table #docfortran
  (
  iDocumentIDFK int,
  iPaymentID int,
  mPaymentAmount money
   )

 Declare @iCurrencyIDFK int = (select iCurrencyID from [dbo].[CurrencyTypes]  where vcCurrencyTypeName='USD')
 --Declare @iPaymentMethodIDFK int = (select iPaymentMethodID from [dbo].[PaymentMethods]  where vcPaymentMethodName='Cash')
 Declare @iStatusPaymentIDFK int = (select iStatusPaymentID from [dbo].[StatusPayments]  where vcStatusPayment='Paid')
 Declare @iRewardPointsRulesIDFK int = (select iRewardPointsRulesID from [dbo].[RewardPointsRules]  where iRewardPointsRulesID=1)

insert into [BlueMobile].[dbo].[Payments] (iSubscriberIDFK,iDocumentIDFK,iStatusPaymentIDFK,iCurrencyIDFK,iRewardPointsRulesIDFK,dtPaymentDate,mPaymentAmount)
output inserted.iDocumentIDFK,inserted.iPaymentID,inserted.mPaymentAmount into #docfortran

 select 
          C.iSubscriberIDFK,
		  --C.iSimCardIDFK,
		  C.iDocumentID,
		  iStatusPaymentIDFK,
		  iCurrencyIDFK,
		  iRewardPointsRulesIDFK,
		  getdate(),
		 -- C.mCostMonth,
		 -- C.CostSmsMinute,
		  sum(mCostMonth+Cost1) as Total

 from
 (

   	SELECT
          A.iSubscriberIDFK,
		  A.iSimCardIDFK,
		  A.iDocumentID,
		  @iStatusPaymentIDFK AS iStatusPaymentIDFK,
		  @iCurrencyIDFK AS iCurrencyIDFK,
		  @iRewardPointsRulesIDFK AS iRewardPointsRulesIDFK,
		  A.dtStartDate,
		  A.dtEndDate,
		  A.iProductIDFK,
		  B.mCostMonth,
		  BB.CostSmsMinute,
		  case
		  when CostSmsMinute is Null then 0
		  else CostSmsMinute
		  end as Cost1

		 		 					  
	FROM [BlueMobile].[dbo].[Documents]  AS A
	INNER JOIN [dbo].[Products] AS B
    on A.iProductIDFK=B.iProductID
	left join #CalculateCostMinutes as BB
	on BB.iSubscriberIDFK=A.iSubscriberIDFK and BB.iSimCardIDFK = A.iSimCardIDFK  and BB.iDocumentID=A.iDocumentID
	left join [dbo].[Payments] as BBB
	on A.iDocumentID =BBB.iDocumentIDFK 
	where (iDocumentTypeIDFK=1 and iDocumentStatusIDFK=1 and BBB.iDocumentIDFK IS  NULL )
    group by A.iSubscriberIDFK,A.iProductIDFK,B.mCostMonth,A.iSimCardIDFK, BB.CostSmsMinute,A.dtStartDate,A.dtEndDate ,A.iDocumentID
	
) as C
	group by  C.iSubscriberIDFK,
			  C.iSimCardIDFK,
			  C.iDocumentID,
			  iStatusPaymentIDFK,
			  iCurrencyIDFK,
			  iRewardPointsRulesIDFK,
			  C.mCostMonth,
			  C.CostSmsMinute
	order by iDocumentID

print'Am introdus in Payments'

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 --- adaug in transactions fiecare Payments---

Declare @iTransactionTypeID int = (select iTransactionTypeID from [dbo].[TransactionTypes]  where vcTransactionType='Payment')
Declare @dtTransactionDate datetime = getdate()
insert into [BlueMobile].[dbo].[Transactions](iDocumentIDFK,iPaymentIDFK,iTransactionTypeIDFK,dtTransactionDate) 
select iDocumentIDFK,iPaymentID,@iTransactionTypeID,@dtTransactionDate from #docfortran

print 'Am introdus si in Transactions - billurile respective.'

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- adaug in CalculateRewardPoints fiecare Payments---

 if exists(select iStatusPaymentIDFK from [dbo].[Payments]  where iStatusPaymentIDFK=1)  
  Begin

	Declare @iRewardPointsRulesID int = 1
	Declare @bIsActive bit = 1
	insert into [dbo].[CalculateRewardPoints](iDocumentIDFK,iRewardPointsRulesIDFK,bIsActive,dtEffectiveFromDate,dtEffectiveToDate,iRewardPointTotal) 
	select iDocumentIDFK,@iRewardPointsRulesID,@bIsActive,dtStartOffer,dtEndOffer,mPaymentAmount*1 from #docfortran as A
	inner join [dbo].[RewardPointsRules] as B on B.iRewardPointsRulesID=@iRewardPointsRulesID

	print 'Am calculat punctele pentru RewardPointsRules'

  end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 --- adaug in transactions fiecare CalculateRewardPoints ---

Declare @iTran int = (select iTransactionTypeID from [dbo].[TransactionTypes]  where vcTransactionType='Reward Points')
insert into [BlueMobile].[dbo].[Transactions](iDocumentIDFK,iTransactionTypeIDFK,dtTransactionDate) 
select iDocumentIDFK,@iTran,@dtTransactionDate from #docfortran

print 'Am introdus si in Transactions - punctele pentru CalculateRewardPoints.'

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
        --    ROLLBACK TRANSACTION;     
        --END;  
	End catch
End





