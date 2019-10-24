DECLARE @UserId int;
DECLARE @ItemId bigint;
DECLARE @Date DATETIMEOFFSET(7) = SYSDATETIMEOFFSET();

SELECT TOP 1 @UserId = [Id] FROM dbo.[Users] WHERE [ExternalId] = $(UserId1)
SELECT TOP 1 @ItemId = [Id] FROM dbo.[Items] WHERE [ExternalId] = $(ItemId1)
IF NOT EXISTS (SELECT * FROM [dbo].[UserWishlist] 
				WHERE [UserId] =  @UserId 
				AND [ItemId] = @ItemId)
BEGIN
	EXECUTE [dbo].[InsertUserWhishlist] @UserId, @ItemId, @Date, 1
END

SELECT TOP 1 @ItemId = [Id] FROM dbo.[Items] WHERE [ExternalId] = $(ItemId2)
IF NOT EXISTS (SELECT * FROM [dbo].[UserWishlist] 
				WHERE [UserId] =  @UserId 
				AND [ItemId] = @ItemId)
BEGIN
	EXECUTE [dbo].[InsertUserWhishlist] @UserId, @ItemId, @Date, 1
END

SELECT TOP 1 @ItemId = [Id] FROM dbo.[Items] WHERE [ExternalId] = $(ItemId3)
IF NOT EXISTS (SELECT * FROM [dbo].[UserWishlist] 
				WHERE [UserId] =  @UserId 
				AND [ItemId] = @ItemId)
BEGIN
	EXECUTE [dbo].[InsertUserWhishlist] @UserId, @ItemId, @Date, 1
END

GO