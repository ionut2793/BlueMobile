
alter procedure [dbo].[sp_purchaseSubscriptionNew]	

-- pentru Subscribers
@vcFirstName varchar(50),
@vcLastName varchar(50),
@vcPersonalCodeIdentification varchar(50),

--pentru Addresses
--@iSubscriberIDFK int,  -- trebuie sa il primeasca din subscribers
@vcStreet varchar(200),
@iHouseNumber int,
@vcCity varchar(50),
@vcState  varchar(50),
@vcCountry varchar(50),
@iPhoneNumber varchar(20),
@nvcEmail varchar(100),
@cZipCode char(5),
--@iTypeAddressIDFK int,

--pentru SimCards
@vcPhoneNumber varchar(25),
@vcPINNumber varchar(25),
@vcPUKNumber varchar(25),
--@vcSerialNumber varchar(25),

--pentru Documents
--@iDocumentTypeIDFK int,
--@iSimIDFK int,   -- il primeste din tabela SimCard atunci cand este creeat.
--@iProductIDFK int,   -- 1 standard / 2 - friends / 3 - weekend
@dtStartDate datetime
--@dtEndDate datetime
--@iDocumentStatusIDFK int,   -- 1 active / 2 - disabled / 3 - deleted / 4 - purged
--@iSubscriptionID  int, -- il puneam doar daca aveam bill


as 
Begin




  if exists(select nvcEmail from [dbo].[Addresses] where nvcEmail=@nvcEmail)

	Raiserror ('Email Address already exists !',16,1)

  if exists( select vcPhoneNumber  from [dbo].[SimCards] where vcPhoneNumber=@vcPhoneNumber)

	Raiserror ('Mobile number already exists !',16,1)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  --  // AICI ESTE CODUL PENTRU ADAUGAREA UNUI NOU ABONAMENT PENTRU UN USER DEJA EXISTENT //

    if (@dtStartDate <GETDATE())

	Raiserror ('You have entered an invalid date !',16,1)

	Else


  if exists( select *  FROM [BlueMobile].[dbo].[Subscribers] where  vcFirstName=@vcFirstName and vcLastName=@vcLastName and vcPersonalCodeIdentification=@vcPersonalCodeIdentification )
  Begin try
  Begin Transaction
  Declare @iSubrscriberIDforNewSubscriber int 
  
  select  @iSubrscriberIDforNewSubscriber=iSubscriberID  
	 FROM [BlueMobile].[dbo].[Subscribers] 
  where  vcFirstName=@vcFirstName and vcLastName=@vcLastName and vcPersonalCodeIdentification=@vcPersonalCodeIdentification

  if (@iSubrscriberIDforNewSubscriber IS NOT NULL )

   	begin


	Declare @vcIMEINumber varchar(25)
	Select @vcIMEINumber = ltrim(str(FLOOR(RAND()*(999999999999999-100000000000000+1))+100000000000000,25,0))

	Declare @vcSerialNumber varchar(25)
	select @vcSerialNumber=('SN'+  ltrim(str( FLOOR(RAND()*(99999999-10000000+1))+10000000,25,0)))

	insert into [BlueMobile].[dbo].[SimCards] (vcPhoneNumber,vcPINNumber,vcPUKNumber,vcIMEINumber,vcSerialNumber)  --SimCards
	values (@vcPhoneNumber,@vcPINNumber,@vcPUKNumber,@vcIMEINumber,@vcSerialNumber)
	
	DECLARE @iSimCardIDFKforNewSubscriber INT
	select  @iSimCardIDFKforNewSubscriber=SCOPE_IDENTITY()

	print 'New sim created'

	print 'id for my SIM = '+CAST(@iSimCardIDFKforNewSubscriber AS VARCHAR(50))

	Declare @iDocumentTypeIDFKforNewSubscriber int = (select iDocumentTypeID from [dbo].[DocumentTypes]  where vcDocumentTypeName='Subscription') 
	--Declare @iProductIDFKforNewSubscriber int = (select iProductID from [dbo].[Products] where vcProductTypeName='standard') 
	--Declare @iProductIDFKforNewSubscriber int = (select iProductID from [dbo].[Products] where vcProductTypeName='friends') 
	Declare @iProductIDFKforNewSubscriber int = (select iProductID from [dbo].[Products] where vcProductTypeName='weekend')
	Declare @iDocumentStatusIDFKforNewSubscriber int = (select iDocumentStatusID from [dbo].[DocumentsStatus] where vcDocumentStatusName='active')


	insert into [BlueMobile].[dbo].[Documents](iDocumentTypeIDFK,iSubscriberIDFK,iSimCardIDFK,iProductIDFK,dtStartDate,dtEndDate,iDocumentStatusIDFK,dtDueDate)  --Documents
	values(@iDocumentTypeIDFKforNewSubscriber,@iSubrscriberIDforNewSubscriber,@iSimCardIDFKforNewSubscriber,@iProductIDFKforNewSubscriber,@dtStartDate,dateadd(YEAR,2,@dtStartDate),@iDocumentStatusIDFKforNewSubscriber,@dtStartDate)

	PRINT 'New subscription for the user with ID = ' + CAST(@iSubrscriberIDforNewSubscriber AS varchar(5))


	--------------------------------------------------------------------------------------------------------------------------------------------------------------------

    DECLARE @iDocID int
	select  @iDocID=SCOPE_IDENTITY()

	Declare @iTransactionTypeIDFK int = (select iTransactionTypeID from [dbo].[TransactionTypes]  where vcTransactionType='Activation')

	insert into [BlueMobile].[dbo].[Transactions](iDocumentIDFK,iTransactionTypeIDFK,dtTransactionDate) 
	values(@iDocID,@iTransactionTypeIDFK,@dtStartDate) 	
		 
	print 'am introdus in transaction'
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

	end

		Commit Transaction
	
	End try
	Begin catch
		Rollback Transaction
		print 'am intrat in rollback - esuare adaugare abonament suplimentar'
	End catch
	
	

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	else	
	

	Begin Try
	Begin Transaction


	Declare @initStatusSubscriberID int = (select iStatusSubscriberID from   [dbo].[SubscribersStatus] where vcSubscriberStatusName='init')
	Declare @iSubscriberTypeID int = (select iSubscriberTypeID from [dbo].[SubscriberTypes]  where vcSubscriberTypeName='Authorized Person')
	--Declare @iSubscriberTypeID int = (select iSubscriberTypeID from [dbo].[SubscriberTypes]  where vcSubscriberTypeName='Enterprise')

	insert into [BlueMobile].[dbo].[Subscribers] (vcFirstName,vcLastName,iStatusSubscriberIDFK,iSubscriberTypeIDFK,vcPersonalCodeIdentification,dtJoinDate)    --Subscribers 
	values (@vcFirstName,@vcLastName,@initStatusSubscriberID,@iSubscriberTypeID,@vcPersonalCodeIdentification,GETDATE())

	print 'am introdus in subscriber'

----------------------------------------------------------------------------------------------------------------------------------------------------------------		
	DECLARE @iSubscriberIDFK INT
	select  @iSubscriberIDFK=SCOPE_IDENTITY()
	Declare @iTypeAddressIDFK int = (select iTypeAddressID from  [dbo].[AddressTypes]  where vcAddressTypeName='Home')
	--Declare @iTypeAddressIDFK int = (select iTypeAddressID from  [dbo].[AddressTypes]  where vcAddressTypeName='Billing')
	--Declare @iTypeAddressIDFK int = (select iTypeAddressID from  [dbo].[AddressTypes]  where vcAddressTypeName='Delivery')

	

	insert into [BlueMobile].[dbo].[Addresses] (iSubscriberIDFK,vcStreet,iHouseNumber,vcCity,vcState,vcCountry,iPhoneNumber,nvcEmail,cZipCode,iTypeAddressIDFK) --Addresses]
	values (@iSubscriberIDFK,@vcStreet,@iHouseNumber,@vcCity,@vcState,@vcCountry,@iPhoneNumber,@nvcEmail,@cZipCode,@iTypeAddressIDFK)

	print 'am introduse in addresses'

------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Declare @vcIMEINumberr varchar(25)
	Select @vcIMEINumberr = ltrim(str(FLOOR(RAND()*(999999999999999-100000000000000+1))+100000000000000,25,0))

	Declare @vcSerialNumberr varchar(25)
	select @vcSerialNumberr=('SN'+  ltrim(str( FLOOR(RAND()*(99999999-10000000+1))+10000000,25,0)))



	insert into [BlueMobile].[dbo].[SimCards] (vcPhoneNumber,vcPINNumber,vcPUKNumber,vcIMEINumber,vcSerialNumber)  --SimCards
	values (@vcPhoneNumber,@vcPINNumber,@vcPUKNumber,@vcIMEINumberr,@vcSerialNumberr)
	print'am introdus in sim'
 -------------------------------------------------------------------------------------------------------------------------------------------------------------------
	DECLARE @iSimCardIDFK int
	select @iSimCardIDFK=SCOPE_IDENTITY()
	Declare @iDocumentTypeIDFK int = (select iDocumentTypeID from [dbo].[DocumentTypes]  where vcDocumentTypeName='Subscription')    
	--Declare @iProductIDFK int = (select iProductID from [dbo].[Products] where vcProductTypeName='standard') 
	--Declare @iProductIDFK int = (select iProductID from [dbo].[Products] where vcProductTypeName='friends') 
	Declare @iProductIDFK int = (select iProductID from [dbo].[Products] where vcProductTypeName='weekend')
	Declare @iDocumentStatusIDFK int = (select iDocumentStatusID from [dbo].[DocumentsStatus] where vcDocumentStatusName='active')


	insert into [BlueMobile].[dbo].[Documents](iDocumentTypeIDFK,iSubscriberIDFK,iSimCardIDFK,iProductIDFK,dtStartDate,dtEndDate,iDocumentStatusIDFK,dtDueDate)  --Documents
	values(@iDocumentTypeIDFK,@iSubscriberIDFK,@iSimCardIDFK,@iProductIDFK,@dtStartDate,dateadd(YEAR,2,@dtStartDate),@iDocumentStatusIDFK,@dtStartDate)

	print 'am introdus in documents'

	DECLARE @iDocumentIDFK int
	select  @iDocumentIDFK=SCOPE_IDENTITY()
	print '@iDocumentIDFK este ' + cast(@iDocumentIDFK as varchar(25))

--------------------------------------------------------------------------------------------------------------------------------------------------------------------


	Declare @activeStatusSubscriberID int = (select iStatusSubscriberID from   [dbo].[SubscribersStatus] where vcSubscriberStatusName='active')          -- daca tot este in regula, activez userul(active)
	update  [dbo].[Subscribers]  set iStatusSubscriberIDFK =@activeStatusSubscriberID	where iSubscriberID=@iSubscriberIDFK

	print'l-am activat'
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

	--Declare @iTransactionTypeIDFK int = (select iTransactionTypeID from [dbo].[TransactionTypes]  where vcTransactionType='Activation')

	insert into [BlueMobile].[dbo].[Transactions](iDocumentIDFK,iTransactionTypeIDFK,dtTransactionDate) 
	values(@iDocumentIDFK,@iTransactionTypeIDFK,@dtStartDate) 	
		 


	print 'am introdus in transaction'
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

		Commit Transaction

	End try
	Begin catch
		Rollback Transaction
		print 'am intrat in rollback - problemee'
	End catch
End
