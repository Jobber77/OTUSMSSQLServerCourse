--Function itself.
CREATE FUNCTION [dbo].[GetCustomerFirstPurchaseDate] 
(
	@CustomerId INT
)
RETURNS DATE
BEGIN

DECLARE @Date DATE;

SELECT TOP 1
	@Date = i.[InvoiceDate]
FROM [Sales].[Customers] c
INNER JOIN [Sales].[Invoices] i ON i.[CustomerID] = c.[CustomerID]
WHERE c.CustomerID = @CustomerId
ORDER BY i.[InvoiceDate] ASC

RETURN @Date

END

GO

--Function usage example
SELECT
	c.[CustomerID],
	c.[CustomerName],
	[dbo].[GetCustomerFirstPurchaseDate](c.[CustomerID]) AS [FirstPurchaseDate]
FROM [Sales].[Customers] c