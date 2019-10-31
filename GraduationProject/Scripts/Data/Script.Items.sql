DECLARE @StoreId int;
DECLARE @UserId int;
SELECT TOP 1 @StoreId = [Id] FROM [Stores] WHERE [ServerAddress] = 'https://www.microsoft.com'
SELECT TOP 1 @UserId = [Id] FROM [Users] WHERE [ExternalId] = $(UserId1)

IF NOT EXISTS (SELECT * FROM [dbo].[Items] WHERE [ExternalId] =  $(ItemId1) AND [StoreId] = @StoreId)
BEGIN
	EXECUTE [dbo].[InsertItem] @StoreId, $(ItemId1), 'Whitcher 3', 'https://some.random.link', @UserId
END

IF NOT EXISTS (SELECT * FROM [dbo].[Items] WHERE [ExternalId] =  $(ItemId2) AND [StoreId] = @StoreId)
BEGIN
	EXECUTE [dbo].[InsertItem] @StoreId, $(ItemId2), 'Fallout 4', 'https://some.random.link2', @UserId
END

IF NOT EXISTS (SELECT * FROM [dbo].[Items] WHERE [ExternalId] =  $(ItemId3) AND [StoreId] = @StoreId)
BEGIN
	EXECUTE [dbo].[InsertItem] @StoreId, $(ItemId3), 'Star Wars Battlefront 2', 'https://some.random.link3', @UserId
END

GO
