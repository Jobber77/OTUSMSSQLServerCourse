CREATE PROCEDURE [dbo].[SelectStore]
	@Id int
AS
BEGIN
	
	SELECT 
		[Id],
		[Name],
		[ServerAddress],
		[SearchEndPoint]
	FROM [dbo].[Stores] 
	WHERE [Id] = @Id

END

