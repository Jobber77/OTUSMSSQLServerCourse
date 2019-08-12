CREATE PROCEDURE [dbo].[Homework2Task5]
AS
BEGIN
	SELECT TOP 10 
		po.[PurchaseOrderId], 
		c.[CustomerName], 
		p.[FullName] AS [SalesPersonName]
	FROM [Purchasing].[PurchaseOrders] po
	INNER JOIN [Sales].[Orders] o ON o.[OrderId] = po.[PurchaseOrderID]
	LEFT OUTER JOIN [Sales].[Customers] c ON c.[CustomerID] = o.[CustomerID]
	LEFT OUTER JOIN [Application].[People] p ON p.PersonID = o.[SalespersonPersonID]
	WHERE po.IsOrderFinalized = 1
	ORDER BY po.[OrderDate] DESC
END
 
