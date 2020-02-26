USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists FinancialDM.LoadPaymentsFact
GO
 
CREATE PROCEDURE FinancialDM.LoadPaymentsFact

AS 
BEGIN

    DECLARE @sdtDateCreated datetime = getdate()
	DECLARE @dtstartDate    datetime = 
	isnull
	(
		(
		SELECT max([DateDimension].dDate) 
		FROM [BlueMobileDW].[FinancialDM].[PaymentsFact]
			INNER JOIN [Common].[DateDimension] ON [PaymentsFact].iPaymentDateKey=[DateDimension].iDateID
		),'1900-01-01'
	)
	
	DECLARE @dtEndDate      datetime = dateadd(ss,59,dateadd(mi,59,dateadd(hh,23,dateadd(ms,-1,dateadd(dd,-1,cast(datepart(mm,getdate()) as varchar) + '-' + cast(datepart(dd,getdate()) as varchar) + '-' + cast(datepart(yyyy,getdate()) as varchar))))))

	INSERT INTO [BlueMobileDW].[FinancialDM].[PaymentsFact]
	(
		[iPaymentID],
		[iPaymentMethodDimensionKey],
		[iCurrencyDimensionKey],
		[mPaymentAmount],
		[iProductDimensionKey],
		[iSubscriberDimensionKey],
		[iLocationDimensionKey],
		[iPaymentDateKey],
		[sdtDateCreated]
	)

	SELECT

		Payments.[iPaymentID],
		PaymentMethodDimension.[iPaymentMethodDimensionKey],
		CurrencyDimension.[iCurrencyDimensionKey],
		Payments.[mPaymentAmount],
		ProductDimension.[iProductDimensionKey],
		SubscriberDimension.[iSubscriberDimensionKey],
		LocationDimension.[iLocationDimensionKey],
		DateDimension.[iDateID],
	    @sdtDateCreated 
		

	FROM	    [BlueMobileDW].[Staging].[Payments]					  
    INNER JOIN  [BlueMobileDW].[FinancialDM].[PaymentMethodDimension]   ON Payments.iPaymentMethodIDFK = PaymentMethodDimension.iPaymentMethodID AND Payments.iStatusPaymentIDFK = 1
	INNER JOIN  [BlueMobileDW].[FinancialDM].[CurrencyDimension]	    ON Payments.iCurrencyIDFK      = CurrencyDimension.iCurrencyID
	INNER JOIN  [BlueMobileDW].[Staging].[Documents]					ON Payments.iDocumentIDFK      = Documents.iDocumentID AND Documents.iDocumentStatusIDFK = 1 AND Documents.iDocumentTypeIDFK = 1	
	INNER JOIN  [BlueMobileDW].[FinancialDM].[ProductDimension]         ON Documents.iProductIDFK      = ProductDimension.iProductID AND ProductDimension.bIsActive = 1
	INNER JOIN  [BlueMobileDW].[Common].[SubscriberDimension]           ON Payments.iSubscriberIDFK    = SubscriberDimension.iSubscriberID AND SubscriberDimension.bIsActive = 1
	INNER JOIN  [BlueMobileDW].[Staging].[Addresses]				    ON Payments.iSubscriberIDFK    = Addresses.iSubscriberIDFK AND Addresses.iTypeAddressIDFK = 1
	INNER JOIN  [BlueMobileDW].[Common].[LocationDimension]			    ON Addresses.iAddressID		   = LocationDimension.iLocationID
	INNER JOIN  [BlueMobileDW].[Common].[DateDimension]				    ON Payments.dPaymentDate       = DateDimension.dDate

	WHERE (Payments.dPaymentDate > @dtstartDate and Payments.dPaymentDate < @dtEndDate)

END


