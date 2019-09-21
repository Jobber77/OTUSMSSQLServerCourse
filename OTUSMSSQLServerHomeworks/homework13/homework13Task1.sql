CREATE FUNCTION [dbo].[GetClientWithBiggestPurchase] ()
RETURNS INT
AS
BEGIN

DECLARE @ClientId INT

SELECT TOP 1
	@ClientId = c.[CustomerID]
FROM [Sales].[Customers] c
INNER JOIN [Sales].[Invoices] i ON i.[CustomerID] = c.[CustomerID]
INNER JOIN [Sales].[InvoiceLines] il ON il.[InvoiceID] = i.[InvoiceID]
GROUP BY c.[CustomerID], i.[InvoiceId]
ORDER BY SUM(il.[Quantity] * il.[UnitPrice]) DESC

RETURN @ClientId

END