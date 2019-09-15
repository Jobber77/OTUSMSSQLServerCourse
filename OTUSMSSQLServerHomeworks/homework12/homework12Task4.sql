SELECT
	si.[StockItemID],
	si.[StockItemName],
	JSON_QUERY(si.[CustomFields], '$.Tags') AS [AllTags]
FROM [Warehouse].[StockItems] si
WHERE JSON_QUERY(si.[CustomFields], '$.Tags') LIKE '%Vintage%'