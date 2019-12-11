CREATE PROCEDURE [dbo].[GenerateUserNotifications]
	@ItemId INT,
	@DateTime DATETIMEOFFSET(7)
AS
BEGIN
	
	DECLARE @MinNotificationPeriodHours INT;

	SELECT 
		@MinNotificationPeriodHours = CAST([Value] AS INT)
	FROM [dbo].[Settings] 
	WHERE [Key] = 'NotificationSettings:MinNotificationPeriodHours'

	INSERT INTO [dbo].[UserNotifications]
	(
		[UserId],
		[ItemId],
		[ChannelId],
		[AddedAt]
	)
	SELECT
		u.[Id],
		@ItemId,
		uc.[ChannelId],
		SYSDATETIMEOFFSET()
		FROM
			[dbo].[Users] u
			INNER JOIN [dbo].[UserChannels] uc ON uc.[UserId] = u.[Id]
			INNER JOIN [dbo].[UserWishlist] uw ON uw.[UserId] = u.[Id] AND uw.[ItemId] = @ItemId
			OUTER APPLY (
							SELECT TOP (1) [AddedAt]
							FROM [dbo].[UserNotifications]
							WHERE 
								[ItemId] = @ItemId
								AND [UserId] = u.[Id]
							ORDER BY [AddedAt] DESC
						) lastNotification
		WHERE
			uc.[Enabled] = 1
			AND uw.[Enabled] = 1
			AND (
					lastNotification.[AddedAt] IS NULL 
					OR 
					lastNotification.[AddedAt] < DATEADD(hh, -@MinNotificationPeriodHours, SYSDATETIMEOFFSET())
				)

END
