--CTE
CREATE PROCEDURE [dbo].[Homework3Task1CTE]
AS
BEGIN
	;WITH HaveSale (Id)
	AS
	(
		SELECT DISTINCT [SalespersonPersonID] FROM Sales.Invoices
	)
	SELECT * 
	FROM [Application].[People] p
	WHERE 
		p.[PersonID] NOT IN (SELECT [Id] FROM HaveSale)
		AND p.IsSalesperson = 1
END

GO

--Nested query
CREATE PROCEDURE [dbo].[Homework3Task1NestedQuery]
AS
BEGIN
	SELECT * 
	FROM [Application].[People] p
	WHERE 
	p.[PersonID] NOT IN (SELECT DISTINCT i.[SalespersonPersonID] FROM Sales.Invoices i)
	AND p.IsSalesperson = 1
END