UPDATE c
SET c.[CustomerName] = N'Зельда'
FROM [Sales].[Customers] c
WHERE [CustomerID] IN (SELECT TOP 1 [CustomerID]
						FROM [Sales].[Customers] c
						ORDER BY c.[ValidFrom] DESC)