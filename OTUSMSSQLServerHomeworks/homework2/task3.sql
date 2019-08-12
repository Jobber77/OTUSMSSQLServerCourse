CREATE FUNCTION [dbo].[fn_GetYearThirdPart]
	(@date datetime2(7) = NULL)
	RETURNS INT
AS
BEGIN
	DECLARE @thirdPart INT = NULL
	DECLARE @month INT = NULL

	IF @date IS NULL RETURN NULL

	SET @month = DATEPART(mm, @date)

	IF (@month BETWEEN 1 AND 4)
		SET @thirdPart = 1
	ELSE IF (@month BETWEEN 5 AND 8)
		SET @thirdPart = 2
	ELSE SET @thirdPart = 3

	RETURN @thirdPart
END

GO

CREATE PROCEDURE [dbo].[Homework2Task3]
AS
BEGIN
	SELECT 
		o.[OrderID],
		FORMAT(o.[OrderDate], 'MMMM') AS [OrderMonth],
		DATEPART (qq, o.[OrderDate]) AS [OrderQuarter],
		[dbo].[fn_GetYearThirdPart](o.[OrderDate]) AS [ThirdPartOfTheYear],
		o.[OrderDate]
	FROM [Sales].[Orders] o
	INNER JOIN [Sales].OrderLines ol ON ol.[OrderID] = o.[OrderID]
	WHERE 
		o.[PickingCompletedWhen] IS NOT NULL
	GROUP BY o.OrderID, o.OrderDate
	HAVING SUM(ol.UnitPrice) > 100 OR SUM(ol.Quantity) > 20
	ORDER BY [OrderQuarter], [ThirdPartOfTheYear], o.[OrderDate]
END

GO

CREATE PROCEDURE [dbo].[Homework2Task3Pagination]
AS
BEGIN
	SELECT 
		o.[OrderID],
		FORMAT(o.[OrderDate], 'MMMM') AS [OrderMonth],
		DATEPART (qq, o.[OrderDate]) AS [OrderQuarter],
		[dbo].[fn_GetYearThirdPart](o.[OrderDate]) AS [ThirdPartOfTheYear],
		o.[OrderDate]
	FROM [Sales].[Orders] o
	INNER JOIN [Sales].OrderLines ol ON ol.[OrderID] = o.[OrderID]
	WHERE 
		o.[PickingCompletedWhen] IS NOT NULL
	GROUP BY o.OrderID, o.OrderDate
	HAVING SUM(ol.UnitPrice) > 100 OR SUM(ol.Quantity) > 20
	ORDER BY [OrderQuarter], [ThirdPartOfTheYear], o.[OrderDate]
	OFFSET 1000 ROWS FETCH NEXT 100 ROWS ONLY
END