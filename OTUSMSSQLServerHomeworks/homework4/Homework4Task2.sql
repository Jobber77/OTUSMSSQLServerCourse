DECLARE @MinSales INT = 10000; 

SELECT 
	YEAR(i.[InvoiceDate]) AS [Year],
	MONTH(i.[InvoiceDate]) AS [Month],
	SUM(il.[UnitPrice] * il.[Quantity]) AS [SalesAmount]
FROM [Sales].[InvoiceLines] il
INNER JOIN Sales.[Invoices] i ON i.[InvoiceID] = il.[InvoiceID]
GROUP BY YEAR(i.[InvoiceDate]), MONTH(i.[InvoiceDate])
HAVING SUM(il.[UnitPrice] * il.[Quantity]) > @MinSales
ORDER BY [Year], [Month]