DELETE FROM [Sales].[Customers] 
WHERE [CustomerID] IN (SELECT TOP 1 [CustomerID]
						FROM [Sales].[Customers] c
						ORDER BY c.[ValidFrom] DESC)