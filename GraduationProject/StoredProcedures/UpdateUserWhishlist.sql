CREATE PROCEDURE [dbo].[UpdateUserWhishlist]
	@UserId int,
	@ItemId bigint,
	@Enabled bit
AS
BEGIN

	UPDATE [dbo].[UserWishlist] 
	SET	[Enabled] = @Enabled
	WHERE
		[UserId] = @UserId
		AND [ItemId] = @ItemId

END
