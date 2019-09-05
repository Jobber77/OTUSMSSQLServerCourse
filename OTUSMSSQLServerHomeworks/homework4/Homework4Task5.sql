;WITH EmployeeLevels ([EmployeeId], [Name], [Title], [EmployeeLevel])
AS
(
	SELECT
		[EmployeeID],
		CAST([FirstName] + ' ' + [LastName] AS NVARCHAR(MAX)) AS [Name],
		[Title],
		1 AS [EmployeeLevel]
	FROM dbo.[MyEmployees] WHERE [ManagerID] IS NULL

	UNION ALL

	SELECT 
		me.[EmployeeID],
		(
			CAST
			(
				(CASE 
					WHEN el.[EmployeeLevel] = 1 THEN '|'
					WHEN el.[EmployeeLevel] = 2 THEN '||'
					WHEN el.[EmployeeLevel] = 3 THEN '|||'
				END) + ' ' + me.[FirstName] + ' ' + me.[LastName]
			AS NVARCHAR(MAX)
			)
		) AS [Name],
		me.[Title],
		(el.[EmployeeLevel] + 1) AS [EmployeeLevel]
	FROM dbo.[MyEmployees] me
	INNER JOIN [EmployeeLevels] el ON el.[EmployeeId] = me.[ManagerID]
)
SELECT * FROM EmployeeLevels
