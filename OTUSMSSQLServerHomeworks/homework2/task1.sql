CREATE PROCEDURE [Homework2Task1]
AS
BEGIN
	SELECT * FROM [Warehouse].[StockItems] WHERE [StockItemName] LIKE 'Animal%'
	SELECT * FROM [Warehouse].[StockItems] WHERE [StockItemName] LIKE '%urgent%'
END