CREATE TABLE #customerItems ([CustomerId] INT, [StockItemId] INT, [TopCostRank] INT) 

INSERT INTO #customerItems
SELECT DISTINCT
	c.[CustomerID],
	si.[StockItemID],
	DENSE_RANK() OVER (PARTITION BY c.[CustomerId] ORDER BY si.[UnitPrice] DESC)
FROM [Sales].[Customers] c 
INNER JOIN [Sales].[Invoices] i ON i.[CustomerID] = c.[CustomerID]
INNER JOIN [Sales].[InvoiceLines] il ON il.[InvoiceID] = i.[InvoiceID]
INNER JOIN [Warehouse].[StockItems] si ON si.[StockItemID] = il.[StockItemID]

SELECT DISTINCT
	c.[CustomerID],
	c.[CustomerName],
	si.[StockItemID],
	si.[StockItemName],
	si.[UnitPrice],
	MAX(i.[InvoiceDate]) OVER (PARTITION BY c.[CustomerId], si.[StockItemID]) AS [LastInvoiceWithItem]
FROM [Sales].[Customers] c 
INNER JOIN [Sales].[Invoices] i ON i.[CustomerID] = c.[CustomerID]
INNER JOIN [Sales].[InvoiceLines] il ON il.[InvoiceID] = i.[InvoiceID]
CROSS APPLY (SELECT TOP 2 * FROM #customerItems ci WHERE ci.CustomerId = c.CustomerID ORDER BY [TopCostRank] ASC) customerItems
INNER JOIN [Warehouse].[StockItems] si ON si.[StockItemID] = customerItems.[StockItemId]
ORDER BY [CustomerId]

DROP TABLE #customerItems