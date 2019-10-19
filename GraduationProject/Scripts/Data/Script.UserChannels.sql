DECLARE @UserId int;
DECLARE @ChannelId int;

SELECT TOP 1 @UserId = [Id] FROM dbo.[Users] WHERE [ExternalId] = $(UserId1)
SELECT TOP 1 @ChannelId = [Id] FROM dbo.[Channels] WHERE [ExternalId] = $(ChannelId1)
IF NOT EXISTS (SELECT * FROM [dbo].[UserChannels] 
				WHERE [UserId] =  @UserId)
BEGIN
	EXECUTE [dbo].[InsertUserChannel] @UserId, @ChannelId, 1
END

SELECT TOP 1 @UserId = [Id] FROM dbo.[Users] WHERE [ExternalId] = $(UserId2)
SELECT TOP 1 @ChannelId = [Id] FROM dbo.[Channels] WHERE [ExternalId] = $(ChannelId2)
IF NOT EXISTS (SELECT * FROM [dbo].[UserChannels] 
				WHERE [UserId] =  @UserId)
BEGIN
	EXECUTE [dbo].[InsertUserChannel] @UserId, @ChannelId, 1
END

SELECT TOP 1 @UserId =[Id] FROM dbo.[Users] WHERE [ExternalId] = $(UserId3)
SELECT TOP 1 @ChannelId = [Id] FROM dbo.[Channels] WHERE [ExternalId] = $(ChannelId3)
IF NOT EXISTS (SELECT * FROM [dbo].[UserChannels] 
				WHERE [UserId] =  @UserId)
BEGIN
	EXECUTE [dbo].[InsertUserChannel] @UserId, @ChannelId, 1
END

GO