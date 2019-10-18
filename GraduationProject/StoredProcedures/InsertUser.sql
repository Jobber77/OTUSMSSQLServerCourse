CREATE PROCEDURE [dbo].[InsertUser]
	@name nvarchar(256),
	@email nvarchar(256),
	@externalId nvarchar(256)
AS
BEGIN

	INSERT INTO [dbo].[Users] 
	(
		[Name],
		[Email],
		[ExternalId]
	)
	VALUES
	(
		@name,
		@email,
		@externalId
	)

	SELECT SCOPE_IDENTITY()

END
