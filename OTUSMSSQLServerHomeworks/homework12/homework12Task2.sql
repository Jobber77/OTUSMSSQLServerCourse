DECLARE @query VARCHAR(1000), @fileName VARCHAR(50),  @sqlCmd VARCHAR(1000);
SET @query = 'USE WideWorldImporters; SELECT [StockItemName] AS ''@Name'', [SupplierID], (SELECT [UnitPackageID], [OuterPackageID], [QuantityPerOuter], [TypicalWeightPerUnit] FROM [Warehouse].[StockItems] siSub WHERE siSub.[StockItemID] = si.[StockItemID] FOR XML PATH(''Package''), TYPE), [LeadTimeDays], [IsChillerStock], [TaxRate], [UnitPrice] FROM [Warehouse].[StockItems] si FOR XML PATH(''Item''), ROOT(''StockItems''), ELEMENTS;'

SET @fileName = 'D:\bcptest.xml';

SET @sqlCmd = 'bcp "' + @query + '" queryout ' + @fileName + ' -w -T'

EXEC xp_cmdshell @sqlCmd