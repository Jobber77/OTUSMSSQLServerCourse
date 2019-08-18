CREATE PROCEDURE [dbo].[Homework3Task4]
AS
BEGIN
	;WITH TopCostItems
	AS
	(
		SELECT TOP 3 [StockItemID]
		FROM [Warehouse].[StockItems]
		ORDER BY UnitPrice DESC
	),
	OrdersWithTopCostItems
	AS
	(
		SELECT DISTINCT o.[OrderId], o.[CustomerID], o.[PickedByPersonID]
		FROM [Sales].[Orders] o
		INNER JOIN [Sales].[OrderLines] ol ON ol.[OrderId] = o.[OrderID]
		WHERE ol.StockItemID IN (SELECT * FROM TopCostItems)
	),
	CitiesWithDeliveryOfCostItems
	AS
	(
		SELECT city.[CityID], city.[CityName], p.[FullName] AS [PickedPerson]
		FROM OrdersWithTopCostItems owtci
		INNER JOIN [Sales].[Customers] c ON c.CustomerID = owtci.CustomerID 
		INNER JOIN [Application].[Cities] city ON city.CityID = c.DeliveryCityID
		LEFT OUTER JOIN [Application].People p ON p.PersonID = owtci.PickedByPersonID
	)
	SELECT * FROM CitiesWithDeliveryOfCostItems
END
