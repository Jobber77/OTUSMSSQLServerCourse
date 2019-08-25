;WITH EmployeeLevels ([EmployeeId], [Name], [Title], [EmployeeLevel])
AS
(
	SELECT
		[EmployeeID],
		([FirstName] + ' ' + [LastName]) AS [Name],
		[Title],
		1 AS [EmployeeLevel]
	FROM dbo.[MyEmployees] WHERE [ManagerID] IS NULL

	UNION ALL

	SELECT 
		me.[EmployeeID],
		(me.[FirstName] + ' ' + me.[LastName]) AS [Name],
		me.[Title],
		(el.[EmployeeLevel] + 1) AS [EmployeeLevel]
	FROM dbo.[MyEmployees] me
	INNER JOIN [EmployeeLevels] el ON el.[EmployeeId] = me.[ManagerID]
)
SELECT * FROM EmployeeLevels