CREATE PROCEDURE [dbo].[DeleteUserWhishlist]
	@UserId int,
	@ItemId bigint
AS
BEGIN

	DELETE FROM [dbo].[UserWishlist] 
	WHERE
		[UserId] = @UserId
		AND [ItemId] = @ItemId

END
