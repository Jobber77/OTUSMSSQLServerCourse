--option 1
CREATE PROCEDURE [dbo].[Homework3Task3Option1]
AS
BEGIN
	SELECT c.[CustomerID], c.[CustomerName]
	FROM [Sales].[Customers] c 
	WHERE c.CustomerID IN (SELECT TOP 5 [CustomerID]
							FROM [Sales].[CustomerTransactions] 
							ORDER BY [TransactionAmount] DESC )
END

GO

--option 2
CREATE PROCEDURE [dbo].[Homework3Task3Option2]
AS
BEGIN
	SELECT c.[CustomerID], c.[CustomerName]
	FROM [Sales].[Customers] c 
	WHERE c.CustomerID = ANY (SELECT TOP 5 [CustomerID]
					FROM [Sales].[CustomerTransactions] ct
					ORDER BY [TransactionAmount] DESC)
END

GO

--option 3
CREATE PROCEDURE [dbo].[Homework3Task3Option3]
AS
BEGIN
	;WITH TopPaymentUserIds ([CustomerID])
	AS
	(
		SELECT TOP 5 [CustomerID]
		FROM [Sales].[CustomerTransactions] 
		ORDER BY [TransactionAmount] DESC 
	)
	SELECT c.[CustomerID], c.[CustomerName]
	FROM [Sales].[Customers] c 
	INNER JOIN TopPaymentUserIds ON TopPaymentUserIds.[CustomerID] = c.[CustomerID]
END