USE [BlueMobileDW]
GO
 
DROP PROCEDURE IF exists FinancialDM.LoadPaymentsFact
GO
 
CREATE PROCEDURE FinancialDM.LoadPaymentsFact

AS 
BEGIN

    DECLARE @sdtDateCreated datetime=getdate()


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

		A.[iPaymentID],
		B.[iPaymentMethodDimensionKey],
		C.[iCurrencyDimensionKey],
		A.[mPaymentAmount],
		E.[iProductDimensionKey],
		F.[iSubscriberDimensionKey],
		H.[iLocationDimensionKey],
		I.iDateID,
	    @sdtDateCreated

    
	
	FROM	    [BlueMobileDW].[Staging].[Payments]					  AS A 
    INNER JOIN  [BlueMobileDW].[FinancialDM].[PaymentMethodDimension] AS B  ON A.iPaymentMethodIDFK = B.iPaymentMethodID AND A.iStatusPaymentIDFK  = 1
	INNER JOIN  [BlueMobileDW].[FinancialDM].[CurrencyDimension]	  AS C  ON A.iCurrencyIDFK      = C.iCurrencyID
	INNER JOIN  [BlueMobileDW].[Staging].Documents					  AS D	ON A.iDocumentIDFK      = D.iDocumentID	     AND D.iDocumentStatusIDFK = 1 AND D.iDocumentTypeIDFK	= 1	
	INNER JOIN  [BlueMobileDW].[FinancialDM].[ProductDimension]       AS E  ON D.iProductIDFK       = E.iProductID       AND E.bIsActive=1
	INNER JOIN  [BlueMobileDW].[Common].[SubscriberDimension]         AS F  ON A.iSubscriberIDFK    = F.iSubscriberID    AND F.bIsActive=1
	INNER JOIN  [BlueMobileDW].[Staging].[Addresses]				  AS G  ON A.iSubscriberIDFK    = G.iSubscriberIDFK  AND G.iTypeAddressIDFK=1
	INNER JOIN  [BlueMobileDW].[Common].[LocationDimension]			  AS H  ON G.iAddressID		    = H.iLocationID
	INNER JOIN  [BlueMobileDW].[Common].[DateDimension]				  AS I  ON cast(A.dtPaymentDate as date)	    = I.dDate


END