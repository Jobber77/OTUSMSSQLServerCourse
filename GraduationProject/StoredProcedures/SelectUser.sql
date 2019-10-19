CREATE PROCEDURE [dbo].[SelectUser]
	@Id int
AS
BEGIN

	SELECT 
		[Id],
		[Name],
		[Email],
		[ExternalId]
	FROM [dbo].[Users] 
	WHERE [Id] = @Id

END
