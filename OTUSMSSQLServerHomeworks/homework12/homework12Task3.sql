SELECT
	si.[StockItemID],
	si.[StockItemName],
	JSON_VALUE(si.[CustomFields], '$.CountryOfManufacture') AS [CountryOfManufacture],
	JSON_VALUE(si.[CustomFields], '$.Range') AS [Range]
FROM [Warehouse].[StockItems] si