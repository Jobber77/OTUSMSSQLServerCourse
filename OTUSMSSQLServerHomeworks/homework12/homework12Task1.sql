DECLARE @StockItemsXml XML;

SET @StockItemsXml = (SELECT * FROM OPENROWSET
  (BULK 
  'C:\Users\joale\source\repos\OTUSMSSQLServerCourse\OTUSMSSQLServerHomeworks\homework12\StockItemsSource.xml',
   SINGLE_BLOB) 
   AS xmlfile)

MERGE [Warehouse].[StockItems] AS target  
USING (
SELECT
	xmldata.[itemNode].value('@Name', 'NVARCHAR(MAX)') AS [StockItemName], 
	xmldata.[itemNode].value('SupplierID[1]', 'INT') AS [SupplierID],
	xmldata.[itemNode].value('(Package/UnitPackageID)[1]', 'INT') AS [UnitPackageID],
	xmldata.[itemNode].value('(Package/OuterPackageID)[1]', 'INT') AS [OuterPackageID],
	xmldata.[itemNode].value('(Package/QuantityPerOuter)[1]', 'INT') AS [QuantityPerOuter],
	xmldata.[itemNode].value('(Package/TypicalWeightPerUnit)[1]', 'DECIMAL(9,3)') AS [TypicalWeightPerUnit],
	xmldata.[itemNode].value('LeadTimeDays[1]', 'INT') AS [LeadTimeDays],
	xmldata.[itemNode].value('IsChillerStock[1]', 'INT') AS [IsChillerStock],
	xmldata.[itemNode].value('TaxRate[1]', 'DECIMAL(9,3)') AS [TaxRate],
	xmldata.[itemNode].value('UnitPrice[1]', 'DECIMAL(9,6)') AS [UnitPrice]
FROM @StockItemsXml.nodes('/StockItems/Item') AS xmldata([itemNode])
) AS source 
ON (target.[StockItemName] = source.[StockItemName])  
WHEN MATCHED THEN
    UPDATE SET 
		[SupplierID] = source.[SupplierID],
		[UnitPackageID] = source.[UnitPackageID],
		[OuterPackageID] = source.[OuterPackageID],
		[QuantityPerOuter] = source.[QuantityPerOuter],
		[TypicalWeightPerUnit] = source.[TypicalWeightPerUnit],
		[LeadTimeDays] = source.[LeadTimeDays],
		[IsChillerStock] = source.[IsChillerStock],
		[TaxRate] = source.[TaxRate],
		[UnitPrice] = source.[UnitPrice]
WHEN NOT MATCHED THEN  
    INSERT
	(
		[StockItemName],
		[SupplierID],
		[UnitPackageID],
		[OuterPackageID],
		[QuantityPerOuter],
		[TypicalWeightPerUnit],
		[LeadTimeDays],
		[IsChillerStock],
		[TaxRate],
		[UnitPrice],
		[LastEditedBy]
	)  
    VALUES 
	(
		source.[StockItemName],
		source.[SupplierID],
		source.[UnitPackageID],
		source.[OuterPackageID],
		source.[QuantityPerOuter],
		source.[TypicalWeightPerUnit],
		source.[LeadTimeDays],
		source.[IsChillerStock],
		source.[TaxRate],
		source.[UnitPrice],
		1 -- default user
	);