DECLARE @UserId int;
DECLARE @ItemId bigint;
DECLARE @Date DATETIMEOFFSET(7) = SYSDATETIMEOFFSET();
DECLARE @ChannelId int;

SELECT TOP 1 @UserId = [Id] FROM dbo.[Users] WHERE [ExternalId] = $(UserId1)
SELECT TOP 1 @ItemId = [Id] FROM dbo.[Items] WHERE [ExternalId] = $(ItemId1)
SELECT TOP 1 @ChannelId = [Id] FROM dbo.[Channels] WHERE [ExternalId] = $(ChannelId1)
IF NOT EXISTS (SELECT * FROM [dbo].[UserNotifications] 
				WHERE [UserId] =  @UserId 
				AND [ItemId] = @ItemId
				AND [ChannelId] = @ChannelId)
BEGIN
	INSERT INTO [dbo].[UserNotifications] ([UserId], [ItemId], [ChannelId], [AddedAt], [IsSent], [SentAt]) 
	VALUES (@UserId, @ItemId, @ChannelId, @Date, 0, NULL)
END

GO
