CREATE PROCEDURE [Homework1Task2]
AS
BEGIN
	SELECT s.[SupplierID], s.[SupplierName]
	FROM [Purchasing].[Suppliers] s
	LEFT OUTER JOIN [Purchasing].[SupplierTransactions] st ON st.[SupplierID] = s.[SupplierID]
	WHERE st.[SupplierTransactionID] IS NULL
END