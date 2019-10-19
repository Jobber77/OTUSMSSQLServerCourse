CREATE PROCEDURE [dbo].[UpdateUserNotification]
	@Id bigint,
	@IsSent bit,
	@SentAt datetimeoffset(7)
AS
BEGIN

	UPDATE [dbo].[UserNotifications] 
	SET 
		[IsSent] = @IsSent,
		[SentAt] = @SentAt
	WHERE 
		[Id] = @Id
		
END
