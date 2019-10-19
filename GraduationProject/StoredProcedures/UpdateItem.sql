CREATE PROCEDURE [dbo].[UpdateItem]
	@Id bigint,
	@ExternalId nvarchar(256),
	@ExternalName nvarchar(256),
	@ExternalLink nvarchar(256),
	@LastAddedBy int
AS
BEGIN
	
	UPDATE [dbo].[Items] 
	SET
		[ExternalId] = @ExternalId,
		[ExternalName] = @ExternalName,
		[ExternalLink] = @ExternalLink,
		[LastAddedBy] = @LastAddedBy
	WHERE [Id] = @Id

END
