SELECT DISTINCT
	c.[CustomerID],
	c.[CustomerName],
	si.[StockItemID],
	si.[StockItemName],
	si.[UnitPrice],
	(SELECT TOP 1 
		invoices.[InvoiceDate] 
	FROM [Sales].[Invoices] invoices 
	INNER JOIN [Sales].[InvoiceLines] il ON il.[InvoiceID] = invoices.[InvoiceID]
	INNER JOIN [Sales].[Customers] cust ON cust.[CustomerID] = invoices.[CustomerID]
	WHERE il.StockItemID = si.StockItemID AND cust.[CustomerID] = c.[CustomerID]
	ORDER BY invoices.[InvoiceDate] DESC) AS [LastInvoiceWithItem]
FROM [Sales].[Customers] c 
INNER JOIN [Sales].[Invoices] i ON i.[CustomerID] = c.[CustomerID]
INNER JOIN [Sales].[InvoiceLines] il ON il.[InvoiceID] = i.[InvoiceID]
CROSS APPLY (SELECT DISTINCT TOP 2 WITH TIES
				si.[StockItemID],
				si.[UnitPrice]
			FROM [Sales].[Customers] cust 
			INNER JOIN [Sales].[Invoices] i ON i.[CustomerID] = cust.[CustomerID]
			INNER JOIN [Sales].[InvoiceLines] il ON il.[InvoiceID] = i.[InvoiceID]
			INNER JOIN [Warehouse].[StockItems] si ON si.[StockItemID] = il.[StockItemID]
			WHERE cust.[CustomerID] = c.[CustomerID]
			ORDER BY si.[UnitPrice] DESC
) ci
INNER JOIN [Warehouse].[StockItems] si ON si.[StockItemID] = ci.[StockItemId]
ORDER BY [CustomerId]

-- Не понял, почему у меня получились разные даты инвойсов, по сравнению с прошлым заданием по оконным функциям (Домашнее задание 7, задача 5. Подскажете, где может быть ошибка?
/*
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
*/