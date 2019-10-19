CREATE PROCEDURE [dbo].[UpdateChannel]
	@Id int,
	@ExternalId nvarchar(256)
AS
BEGIN

	UPDATE [dbo].[Channels] 
	SET [ExternalId] = @ExternalId
	WHERE [Id] = @Id

END
