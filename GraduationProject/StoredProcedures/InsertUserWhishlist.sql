CREATE PROCEDURE [dbo].[InsertUserWhishlist]
	@UserId int,
	@ItemId bigint,
	@AddedAt datetimeoffset(7),
	@Enabled bit
AS
BEGIN

	INSERT INTO [dbo].[UserWishlist] 
	(
		[UserId],
		[ItemId],
		[AddedAt],
		[Enabled]
	)
	VALUES
	(
		@UserId,
		@ItemId,
		COALESCE(@AddedAt, SYSDATETIMEOFFSET()),
		@Enabled
	)

	SELECT SCOPE_IDENTITY();

END
