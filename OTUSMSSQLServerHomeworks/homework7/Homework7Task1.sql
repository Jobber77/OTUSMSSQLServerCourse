--temp table
DECLARE @StartYear INT = 2015;

CREATE TABLE #SalesSum ([Year] INT, [Month] INT, [Summ] INT);

INSERT INTO #SalesSum
SELECT
	YEAR(i.InvoiceDate),
	MONTH(i.InvoiceDate),
	SUM(il.[Quantity] * il.[UnitPrice]) AS [InvoiceTotal]
FROM [Sales].[InvoiceLines] il
INNER JOIN [Sales].[Invoices] i ON i.[InvoiceID] = il.[InvoiceID]
GROUP BY MONTH(i.InvoiceDate), YEAR(i.InvoiceDate);

SELECT
	i.[InvoiceID],
	c.[CustomerName],
	i.[InvoiceDate],
	SUM(il.[Quantity] * il.[UnitPrice]) AS [InvoiceTotal],
	ss.[Summ]
FROM [Sales].[InvoiceLines] il
INNER JOIN [Sales].[Invoices] i ON i.[InvoiceID] = il.[InvoiceID]
INNER JOIN [Sales].[Customers] c ON c.[CustomerID] = i.[CustomerID]
LEFT JOIN #SalesSum ss ON MONTH(i.InvoiceDate) = ss.[Month] AND YEAR(i.InvoiceDate) = ss.[Year]
WHERE YEAR(i.[InvoiceDate]) >= @StartYear
GROUP BY i.[InvoiceID], c.[CustomerName], i.[InvoiceDate], ss.[Summ]
ORDER BY i.[InvoiceDate]

DROP TABLE #SalesSum

GO

--table var
DECLARE @StartYear INT = 2015;
DECLARE @SalesSum TABLE ([Year] INT, [Month] INT, [Summ] INT);

INSERT INTO @SalesSum
SELECT
	YEAR(i.InvoiceDate),
	MONTH(i.InvoiceDate),
	SUM(il.[Quantity] * il.[UnitPrice]) AS [InvoiceTotal]
FROM [Sales].[InvoiceLines] il
INNER JOIN [Sales].[Invoices] i ON i.[InvoiceID] = il.[InvoiceID]
GROUP BY MONTH(i.InvoiceDate), YEAR(i.InvoiceDate);

SELECT
	i.[InvoiceID],
	c.[CustomerName],
	i.[InvoiceDate],
	SUM(il.[Quantity] * il.[UnitPrice]) AS [InvoiceTotal],
	ss.[Summ]
FROM [Sales].[InvoiceLines] il
INNER JOIN [Sales].[Invoices] i ON i.[InvoiceID] = il.[InvoiceID]
INNER JOIN [Sales].[Customers] c ON c.[CustomerID] = i.[CustomerID]
LEFT JOIN @SalesSum ss ON MONTH(i.InvoiceDate) = ss.[Month] AND YEAR(i.InvoiceDate) = ss.[Year]
WHERE YEAR(i.[InvoiceDate]) >= @StartYear
GROUP BY i.[InvoiceID], c.[CustomerName], i.[InvoiceDate], ss.[Summ]
ORDER BY i.[InvoiceDate]

GO

