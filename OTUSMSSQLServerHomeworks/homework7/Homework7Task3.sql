SELECT 
	si.[StockItemID],
	si.[StockItemName],
	si.[UnitPrice],
	ROW_NUMBER() OVER (PARTITION BY SUBSTRING(si.[StockItemName],1,1) ORDER BY si.[StockItemName]) AS [NumberByFirstLetter],
	COUNT(si.[StockItemID]) OVER () AS [TotalAmountOfStockItems],
	COUNT(si.[StockItemID]) OVER (PARTITION BY SUBSTRING(si.[StockItemName],1,1)) AS [TotalAmountOfStockItemsPerFirstLetter],
	LEAD(si.[StockItemID]) OVER (ORDER BY si.[StockItemName]) AS [NextItemId],
	LAG(si.[StockItemID]) OVER (ORDER BY si.[StockItemName]) AS [PreviousItemId],
	COALESCE(
		CAST(LAG(si.[StockItemID], 2) OVER (ORDER BY si.[StockItemName]) AS VARCHAR),
		'No items') AS [2PreviousItemId],
	NTILE(30) OVER (ORDER BY si.[TypicalWeightPerUnit]) AS [GroupsByTypicalWeightPerUnit]
FROM [Warehouse].[StockItems] si
ORDER BY si.[StockItemName]