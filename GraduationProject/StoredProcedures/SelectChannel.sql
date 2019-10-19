CREATE PROCEDURE [dbo].[SelectChannel]
	@Id int
AS
BEGIN

	SELECT 
		[Id],
		[ExternalId]
	FROM [dbo].[Channels] 
	WHERE [Id] = @Id

END

