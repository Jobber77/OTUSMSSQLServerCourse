CREATE PROCEDURE [dbo].[InsertChannel]
	@externalId nvarchar(256)
AS
BEGIN
	INSERT INTO [dbo].[Channels] 
	(
		[ExternalId]
	)
	VALUES
	(
		@externalId
	)

	SELECT SCOPE_IDENTITY()
END
