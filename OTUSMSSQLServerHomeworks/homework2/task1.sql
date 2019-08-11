CREATE PROCEDURE [Homework1Task1]
AS
BEGIN
	SELECT * FROM [Warehouse].[StockItems] WHERE [StockItemName] LIKE 'Animal%'
	SELECT * FROM [Warehouse].[StockItems] WHERE [StockItemName] LIKE '%urgent%'
END