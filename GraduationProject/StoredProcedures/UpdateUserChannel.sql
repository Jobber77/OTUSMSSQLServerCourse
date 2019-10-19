CREATE PROCEDURE [dbo].[UpdateUserChannel]
	@UserId int,
	@ChannelId int,
	@Enabled bit
AS
BEGIN

	UPDATE [dbo].[UserChannels] 
	SET [Enabled] = @Enabled
	WHERE 
		[UserId] = @UserId
		AND [ChannelId] = @ChannelId
		
END
