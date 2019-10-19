CREATE PROCEDURE [dbo].[InsertItem]
	@StoreId int,
	@ExternalId nvarchar(256),
	@ExternalName nvarchar(256),
	@ExternalLink nvarchar(256),
	@LastAddedBy int
AS
BEGIN
	
	INSERT INTO [dbo].[Items] 
	(
		[StoreId],
		[ExternalId],
		[ExternalName],
		[ExternalLink],
		[LastAddedBy]
	)
	VALUES
	(
		@StoreId,
		@ExternalId,
		@ExternalName,
		@ExternalLink,
		@LastAddedBy
	)

	SELECT SCOPE_IDENTITY()

END
