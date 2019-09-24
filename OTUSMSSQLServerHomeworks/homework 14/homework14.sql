-- делаю вариант 2. Взял классы отсюда: https://habr.com/ru/post/88396/

--enable CLR
EXECUTE sp_configure 'show advanced options', 1;
GO

RECONFIGURE;
GO

EXECUTE sp_configure 'clr enabled', 1;
EXECUTE sp_configure 'clr strict security', 0 
GO

RECONFIGURE;
GO

--import assembly
CREATE ASSEMBLY CLRFunctions FROM 'C:\Users\aleksey.knyazev\Documents\GitHub\OTUSMSSQLServerCourse\SqlClrClasses\bin\Debug\SqlClrClasses.dll' WITH PERMISSION_SET = SAFE;
GO

--create database function
CREATE FUNCTION [dbo].[SplitStringCLR]
(
	@text [NVARCHAR](MAX), 
	@delimiter [NCHAR](1)
)
RETURNS TABLE 
(
	[Order] INT,
	[StringPart] NVARCHAR(MAX)
)
AS
EXTERNAL NAME CLRFunctions.UserDefinedFunctions.SplitString

GO
--usage example
SELECT * FROM [dbo].[SplitStringCLR]('a,b,c,d,', ',')
