SELECT 
	FORMAT([InvoiceMonth], 'dd.MM.yyyy') AS [InvoiceMonth],
	[2] AS [Sylvanite, MT], 
	[3] AS [Peeples Valley, AZ], 
	[4] AS [Medicine Lodge, KS], 
	[5] AS [Gasport, NY], 
	[6] AS [Jessie, ND]
FROM 
(
	SELECT 
		DATEADD(DAY, 1, EOMONTH([InvoiceDate], -1)) AS [InvoiceMonth],
		i.[InvoiceID],
		c.[CustomerID]
	FROM [Sales].[Invoices] i
	INNER JOIN [Sales].[Customers] c ON c.[CustomerID] = i.[CustomerID]
) AS salesData
PIVOT
(
	COUNT(salesData.[InvoiceID])
	FOR salesData.[CustomerID] IN ([2], [3], [4], [5], [6])
) AS customerPivot
ORDER BY CAST([InvoiceMonth] AS DATETIME)