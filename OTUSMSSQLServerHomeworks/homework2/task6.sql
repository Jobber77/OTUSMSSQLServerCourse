CREATE PROCEDURE [dbo].[task6]
AS
BEGIN
	SELECT DISTINCT c.[CustomerID], c.[CustomerName] 
	FROM [Sales].[Customers] c
	INNER JOIN [Sales].[Orders] o ON o.[CustomerID] = c.[CustomerID]
	INNER JOIN [Sales].[OrderLines] ol ON ol.[OrderID] = o.[OrderID]
	INNER JOIN [Warehouse].StockItems si ON si.[StockItemID] = ol.[StockItemID]
	WHERE si.StockItemName = 'Chocolate frogs 250g'
END