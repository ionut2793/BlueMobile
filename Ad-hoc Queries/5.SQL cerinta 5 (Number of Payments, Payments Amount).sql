SELECT 
	iSubscriberIDFK,
	count(iSubscriberIDFK) as NumberOfPayments,
	avg(mPaymentAmount) as [Average]
FROM [BlueMobile].[dbo].[Payments]
where iStatusPaymentIDFK=1
group by iSubscriberIDFK
