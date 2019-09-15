DECLARE   @SQLQuery AS NVARCHAR(MAX)
DECLARE   @PivotColumns AS NVARCHAR(MAX)

SELECT @PivotColumns = COALESCE(@PivotColumns + ',','') + QUOTENAME(c.[CustomerName])
FROM [Sales].[Customers] c
WHERE c.CustomerID IN (SELECT [CustomerID] FROM [Sales].[Invoices])

SET @SQLQuery = '
USE WideWorldImporters;
SELECT 
	FORMAT([InvoiceMonth], ''dd.MM.yyyy'') AS [InvoiceMonth],'
	+ @PivotColumns + '
FROM 
(
	SELECT 
		DATEADD(DAY, 1, EOMONTH([InvoiceDate], -1)) AS [InvoiceMonth],
		i.[InvoiceID],
		c.[CustomerName]
	FROM [Sales].[Invoices] i
	INNER JOIN [Sales].[Customers] c ON c.[CustomerID] = i.[CustomerID]
) AS salesData
PIVOT
(
	COUNT(salesData.[InvoiceID])
	FOR salesData.[CustomerName] IN ('+ @PivotColumns + ')
) AS customerPivot
ORDER BY CAST([InvoiceMonth] AS DATETIME)'

EXEC sp_executesql @SQLQuery
