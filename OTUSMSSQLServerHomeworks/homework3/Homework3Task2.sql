--option 1
CREATE PROCEDURE [dbo].[Homework3Task2Option1]
AS
BEGIN
	SELECT [StockItemId], [StockItemName], [UnitPrice]
	FROM [WideWorldImporters].[Warehouse].[StockItems]
	WHERE [UnitPrice] <= ALL (SELECT [UnitPrice] FROM [Warehouse].[StockItems])
END

GO

--option 2
CREATE PROCEDURE [dbo].[Homework3Task2Option2]
AS
BEGIN
	SELECT [StockItemId], [StockItemName], [UnitPrice]
	FROM [WideWorldImporters].[Warehouse].[StockItems]
	WHERE [UnitPrice] = (SELECT MIN(UnitPrice) FROM [WideWorldImporters].[Warehouse].[StockItems])
END