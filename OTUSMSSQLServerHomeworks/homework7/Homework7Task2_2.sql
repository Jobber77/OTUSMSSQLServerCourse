DECLARE @TopSaleRanks TABLE ([Year] INT,  [Month] INT, [StockItemID] INT, [TopSaleRank] BIGINT);
DECLARE @MinYear INT = 2016;

INSERT INTO @TopSaleRanks
SELECT
	YEAR(i.[InvoiceDate]), 
	MONTH(i.[InvoiceDate]),
	si.[StockItemID],
	DENSE_RANK() OVER (PARTITION BY YEAR(i.[InvoiceDate]), MONTH(i.[InvoiceDate]) ORDER BY SUM(il.[Quantity]) DESC)
FROM [Sales].[InvoiceLines] AS il
INNER JOIN [Sales].[Invoices] AS i ON i.[InvoiceID] = il.[InvoiceID]
INNER JOIN [Warehouse].[StockItems] AS si ON si.[StockItemID] = il.[StockItemID]
GROUP BY YEAR(i.[InvoiceDate]), MONTH(i.[InvoiceDate]), si.[StockItemID]

SELECT 
	tsr.[Year],
	tsr.[Month],
	tsr.[StockItemID],
	si.[StockItemName],
	tsr.[TopSaleRank]
FROM @TopSaleRanks tsr
INNER JOIN [Warehouse].[StockItems] si ON si.[StockItemID] = tsr.[StockItemID]
WHERE tsr.TopSaleRank <= 2 AND tsr.[Year] >= 2016
