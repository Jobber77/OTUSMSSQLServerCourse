SELECT 
	si.[StockItemID], 
	si.[StockItemName], 
	YEAR(i.[InvoiceDate]) AS [Year],
	MONTH(i.[InvoiceDate]) AS [Month],
	AVG(il.[UnitPrice]) AS AveragePrice,
	SUM(il.[UnitPrice] * il.[Quantity]) AS [SalesAmount]
FROM [Sales].[InvoiceLines] il
INNER JOIN Sales.[Invoices] i ON i.[InvoiceID] = il.[InvoiceID]
INNER JOIN Warehouse.[StockItems] si ON si.[StockItemID] = il.[StockItemID]
GROUP BY si.[StockItemID], si.[StockItemName], YEAR(i.[InvoiceDate]), MONTH(i.[InvoiceDate])
ORDER BY si.[StockItemID], [Year], [Month]