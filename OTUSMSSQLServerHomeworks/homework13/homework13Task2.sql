--Из задания, не ясно, что значит "выводящую сумму покупки". Какой конкретно покупки?
--Вывожу сумму по каждой его покупке.
CREATE PROCEDURE [dbo].[GetCustomerPurchaseSumms] 
(
	@CustomerId INT
)
AS
BEGIN

SELECT
	c.[CustomerID],
	i.[InvoiceID],
	SUM(il.[Quantity] * il.[UnitPrice]) AS [IncoiveTotal]
FROM [Sales].[Customers] c
INNER JOIN [Sales].[Invoices] i ON i.[CustomerID] = c.[CustomerID]
INNER JOIN [Sales].[InvoiceLines] il ON il.[InvoiceID] = i.[InvoiceID]
WHERE c.CustomerID = @CustomerId
GROUP BY c.[CustomerID], i.[InvoiceId]
ORDER BY [IncoiveTotal] DESC

END