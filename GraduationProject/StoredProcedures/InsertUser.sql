CREATE PROCEDURE [dbo].[InsertUser]
	@Name nvarchar(256),
	@Email nvarchar(256),
	@ExternalId nvarchar(256)
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
		@Name,
		@Email,
		@ExternalId
	)

	SELECT SCOPE_IDENTITY()

END
