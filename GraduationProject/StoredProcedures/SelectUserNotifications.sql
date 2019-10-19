CREATE PROCEDURE [dbo].[SelectUserNotifications]
	@UserId int,
	@IsSent bit = NULL
AS
BEGIN

	SELECT
		un.[Id],
		un.[UserId],
		un.[ItemId],
		un.[ChannelId],
		un.[AddedAt],
		un.[IsSent],
		un.[SentAt]
	FROM [dbo].[UserNotifications] un
	WHERE
		[UserId] = @UserId
		AND (@IsSent IS NULL OR [IsSent] = @IsSent)

END
