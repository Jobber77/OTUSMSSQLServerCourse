CREATE PROCEDURE [Homework2Task1]
AS
BEGIN
	SELECT * FROM [Warehouse].[StockItems] 
	WHERE [StockItemName] LIKE 'Animal%' OR [StockItemName] LIKE '%urgent%'
END