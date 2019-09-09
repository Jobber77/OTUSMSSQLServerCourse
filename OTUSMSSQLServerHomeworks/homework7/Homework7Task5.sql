CREATE TABLE #customerItems ([CustomerId] INT, [StockItemId] INT, [TopCostPlace] INT) 

INSERT INTO #customerItems
SELECT DISTINCT
	c.[CustomerID],
	si.[StockItemID],
	DENSE_RANK() OVER (PARTITION BY c.[CustomerId] ORDER BY si.[UnitPrice] DESC, c.[CustomerId] ) AS [TopCostPlace]
FROM [Sales].[Customers] c 
INNER JOIN [Sales].[Invoices] i ON i.[CustomerID] = c.[CustomerID]
INNER JOIN [Sales].[InvoiceLines] il ON il.[InvoiceID] = i.[InvoiceID]
INNER JOIN [Warehouse].[StockItems] si ON si.[StockItemID] = il.[StockItemID]

select * from #customerItems order by CustomerId, TopCostPlace

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
INNER JOIN #customerItems ci ON ci.CustomerId = c.CustomerID
INNER JOIN [Warehouse].[StockItems] si ON si.[StockItemID] = ci.[StockItemId]
WHERE ci.[TopCostPlace] <= 2
ORDER BY [CustomerId]

DROP TABLE #customerItems