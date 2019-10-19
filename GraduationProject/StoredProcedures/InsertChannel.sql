CREATE PROCEDURE [dbo].[InsertChannel]
	@ExternalId nvarchar(256)
AS
BEGIN
	INSERT INTO [dbo].[Channels] 
	(
		[ExternalId]
	)
	VALUES
	(
		@ExternalId
	)

	SELECT SCOPE_IDENTITY()

END
