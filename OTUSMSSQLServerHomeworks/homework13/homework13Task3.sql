CREATE FUNCTION [dbo].[GetSalesPersonWithMaxSaleForCustomer] 
(
	@CustomerId INT
)
RETURNS TABLE
AS
RETURN
SELECT TOP 1
	p.[PersonID],
	p.[FullName],
	SUM(il.[UnitPrice] * il.[Quantity]) OVER (PARTITION BY i.[InvoiceId]) AS [MaxSaleTotal]
FROM [Sales].[Customers] c
INNER JOIN [Sales].[Invoices] i ON i.[CustomerID] = c.[CustomerID]
INNER JOIN [Application].[People] p ON p.[PersonID] = i.[SalespersonPersonID]
INNER JOIN [Sales].[InvoiceLines] il ON il.[InvoiceID] = i.[InvoiceID]
WHERE c.[CustomerID] = @CustomerId
ORDER BY [MaxSaleTotal] DESC

GO

CREATE PROCEDURE [dbo].[GetSalesPersonWithMaxSaleForCustomerStoreProc] 
(
	@CustomerId INT
)
AS
SELECT TOP 1
	p.[PersonID],
	p.[FullName],
	SUM(il.[UnitPrice] * il.[Quantity]) OVER (PARTITION BY i.[InvoiceId]) AS [MaxSaleTotal]
FROM [Sales].[Customers] c
INNER JOIN [Sales].[Invoices] i ON i.[CustomerID] = c.[CustomerID]
INNER JOIN [Application].[People] p ON p.[PersonID] = i.[SalespersonPersonID]
INNER JOIN [Sales].[InvoiceLines] il ON il.[InvoiceID] = i.[InvoiceID]
WHERE c.[CustomerID] = @CustomerId
ORDER BY [MaxSaleTotal] DESC

GO

SET STATISTICS TIME ON
SET STATISTICS IO ON
SELECT * FROM [dbo].[GetSalesPersonWithMaxSaleForCustomer] (833)
EXEC [dbo].[GetSalesPersonWithMaxSaleForCustomerStoreProc] @CustomerId = 833

/*
Планы абсолютно одинаковые, как и их стоимость.
IO статистика абсолютно одинаковая.
По времени:
для Function CPU Time примерно 30-31 секунды, elapsed time 130-140
для SProcedure CPU Time примерно 30-31 секунды, elapsed time 380-390

Гугл говорит, что table-valued Functions работают примерно также (иногда лучше), чем Stored Procedures, если говорить о скорости.
А вот Scalar-Valued функции часто работают сильно хуже, чем Stored Procedures.
 */