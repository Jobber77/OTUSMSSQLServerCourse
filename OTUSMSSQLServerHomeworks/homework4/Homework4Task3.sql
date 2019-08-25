DECLARE @MinAmountOfSaledItems INT = 50;

SELECT 
	si.[StockItemID], 
	si.[StockItemName], 
	YEAR(i.[InvoiceDate]) AS [Year],
	MONTH(i.[InvoiceDate]) AS [Month],
	SUM(il.[Quantity]) AS [Quantity],
	SUM(il.[UnitPrice] * il.[Quantity]) AS [SalesAmount],
	MIN(i.[InvoiceDate]) AS [FirstSaleDate]
FROM [Sales].[InvoiceLines] il
INNER JOIN Sales.[Invoices] i ON i.[InvoiceID] = il.[InvoiceID]
INNER JOIN Warehouse.[StockItems] si ON si.[StockItemID] = il.[StockItemID]
GROUP BY si.[StockItemID], si.[StockItemName], YEAR(i.[InvoiceDate]), MONTH(i.[InvoiceDate])
HAVING SUM(il.[Quantity]) < @MinAmountOfSaledItems
ORDER BY si.[StockItemID], [Year], [Month]