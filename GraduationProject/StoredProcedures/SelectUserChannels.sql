CREATE PROCEDURE [dbo].[SelectUserChannels]
	@UserId int,
	@Enabled bit = NULL
AS
BEGIN

	SELECT
		c.[Id] AS [ChannelId],
		c.[ExternalId] AS [ChannelExternalId],
		uc.[Enabled] AS [Enabled],
		uc.[UserId] AS [UserId]
	FROM [dbo].[Channels] c
	INNER JOIN [dbo].[UserChannels] uc ON uc.[ChannelId] = c.[Id]
	WHERE 
		(@Enabled IS NULL OR uc.[Enabled] = @Enabled)
		AND uc.UserId = @UserId
	

END
