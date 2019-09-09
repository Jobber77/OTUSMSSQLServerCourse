--window functions
--CPU time = 203 ms,  elapsed time = 662 ms.

--temp table
--cpu time = 16+203+31+125 = 375ms, elapsed time = 553+32+54+19+4=662 ms

--table var
--cpu time = 109+94 = 203ms, elapsed time = 92+551=643 ms

--результаты очень близкие. но читается c window function явно лучше :)

DECLARE @StartYear INT = 2015;

SELECT DISTINCT
	i.[InvoiceID],
	c.[CustomerName],
	i.[InvoiceDate],
	SUM(il.[Quantity] * il.[UnitPrice]) OVER (PARTITION BY il.[InvoiceID]) AS [InvoiceTotal],
	SUM(il.[Quantity] * il.[UnitPrice]) OVER (PARTITION BY MONTH(i.InvoiceDate), YEAR(i.InvoiceDate))
FROM [Sales].[InvoiceLines] il
INNER JOIN [Sales].[Invoices] i ON i.[InvoiceID] = il.[InvoiceID]
INNER JOIN [Sales].[Customers] c ON c.[CustomerID] = i.[CustomerID]
WHERE YEAR(i.[InvoiceDate]) >= @StartYear
ORDER BY i.[InvoiceDate]