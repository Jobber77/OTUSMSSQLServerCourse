CREATE TABLE #totalInvoiceSales ([InvoiceId] INT, [TotalSale] DECIMAL) 

INSERT INTO #totalInvoiceSales ([InvoiceId], [TotalSale])
SELECT 
	i.[InvoiceID], 
	SUM(il.[UnitPrice] * il.[Quantity])
FROM [Sales].[Invoices] i
INNER JOIN Sales.[InvoiceLines] il ON il.[InvoiceID] = i.[InvoiceID]
GROUP BY i.[InvoiceID]

SELECT DISTINCT
	p.[PersonID] AS [SalePersonId],
	p.[FullName] AS [SalePersonName],
	FIRST_VALUE(c.[CustomerID]) OVER (PARTITION BY p.[PersonId] ORDER BY i.[InvoiceDate] DESC)  AS [LastSaleCustomerId],
	FIRST_VALUE(c.[CustomerName]) OVER (PARTITION BY p.[PersonId] ORDER BY i.[InvoiceDate] DESC) AS [LastSaleCustomerName],
	FIRST_VALUE(i.[InvoiceDate]) OVER (PARTITION BY p.[PersonId] ORDER BY i.[InvoiceDate] DESC) AS [LastSaleDate],
	FIRST_VALUE(i.[InvoiceId]) OVER (PARTITION BY p.[PersonId] ORDER BY i.[InvoiceDate] DESC) AS [LastSaleInvoiceId],
	FIRST_VALUE(tis.[TotalSale]) OVER (PARTITION BY p.[PersonId] ORDER BY i.[InvoiceDate] DESC) AS [LastSaleTotalSale]
FROM [Application].[People] p
INNER JOIN [Sales].[Invoices] i ON i.[SalespersonPersonID] = p.[PersonID]
INNER JOIN [Sales].[Customers] c ON c.[CustomerID] = i.[CustomerID]
INNER JOIN #totalInvoiceSales tis ON tis.[InvoiceID] = i.[InvoiceID]
ORDER BY [SalePersonId]

DROP TABLE #totalInvoiceSales