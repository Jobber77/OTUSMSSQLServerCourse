CREATE PROCEDURE [dbo].[InsertUserChannel]
	@UserId int,
	@ChannelId int,
	@Enabled bit
AS
BEGIN

	INSERT INTO [dbo].[UserChannels] 
	(
		[UserId],
		[ChannelId],
		[Enabled]
	)
	VALUES
	(
		@UserId,
		@ChannelId,
		@Enabled
	)

END
