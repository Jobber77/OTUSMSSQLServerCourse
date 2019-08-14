CREATE PROCEDURE [dbo].[Homework2Task5]
AS
BEGIN
	SELECT TOP 10 
		o.[OrderID], 
		c.[CustomerName], 
		p.[FullName] AS [SalesPersonName]
	FROM [Sales].[Orders] o
	INNER JOIN [Sales].[Customers] c ON c.[CustomerID] = o.[CustomerID]
	INNER JOIN [Application].[People] p ON p.PersonID = o.[SalespersonPersonID]
	ORDER BY o.[OrderDate] DESC
END
 
