CREATE PROCEDURE [dbo].[DeleteUserChannel]
	@UserId int,
	@ChannelId int
AS
BEGIN

	DELETE FROM [dbo].[UserChannels] 
	WHERE 
		[UserId] = @UserId
		AND [ChannelId] = @ChannelId
		
END

