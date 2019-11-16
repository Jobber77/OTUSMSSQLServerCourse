DECLARE @SupplierId INT = 12;
DECLARE @MinCostPerCustomerPerOrder INT = 250000;

SELECT
	o.[CustomerID], 
	ol.[StockItemID], 
	SUM(ol.[UnitPrice]) AS [TotalCost], 
	SUM(ol.[Quantity]) AS [TotalAmount], 
	COUNT(o.[OrderID]) AS [TotalOrders]
FROM 
	Sales.[Orders] AS o
	INNER JOIN Sales.[OrderLines] AS ol ON ol.[OrderID] = o.[OrderID]
	INNER JOIN Sales.[Invoices] AS i ON i.[OrderID] = o.[OrderID]
	INNER JOIN Sales.[CustomerTransactions] AS t ON t.[InvoiceID] = i.[InvoiceID]
	INNER JOIN Warehouse.[StockItemTransactions] AS it ON it.[StockItemID] = ol.[StockItemID]
	INNER JOIN Warehouse.[StockItems] si ON si.[StockItemID] = ol.[StockItemID]
	CROSS APPLY (SELECT SUM(total.[UnitPrice] * total.[Quantity]) AS [Cost]
				FROM 
					Sales.[OrderLines] AS total 
					INNER JOIN Sales.[Orders] AS ordTotal ON ordTotal.[OrderID] = total.[OrderID]
				WHERE ordTotal.[CustomerID] = i.[CustomerID]) costPerCustomerPerOrder
WHERE 
	i.[BillToCustomerID] != o.[CustomerID] 
	AND si.[SupplierId] = @SupplierId
	AND costPerCustomerPerOrder.[Cost] > @MinCostPerCustomerPerOrder 
	AND DATEDIFF(dd, i.[InvoiceDate], o.[OrderDate]) = 0 
GROUP BY o.[CustomerID], ol.[StockItemID] 
ORDER BY o.[CustomerID], ol.[StockItemID]