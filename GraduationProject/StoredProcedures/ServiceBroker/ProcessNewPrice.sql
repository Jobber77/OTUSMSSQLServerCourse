CREATE PROCEDURE [dbo].[ProcessNewPrice]
AS
BEGIN

	DECLARE @TargetDlgHandle UNIQUEIDENTIFIER,
			@Message NVARCHAR(4000),
			@MessageType SYSNAME,
			@ReplyMessage NVARCHAR(4000),
			@ReplyMessageName SYSNAME,
			@ItemId INT,
			@DateTime DATETIMEOFFSET(7),
			@Xml XML; 
	
	BEGIN TRAN; 

		RECEIVE TOP (1)
			@TargetDlgHandle = [conversation_handle],
			@Message = [message_body],
			@MessageType = [message_type_name]
		FROM [dbo].[NewPriceTargetQueue]; 

		IF (@MessageType = N'//GraduationProject/SB/RequestMessages/NewPriceMessage')
		BEGIN
			SET @Xml = CAST(@Message AS XML)
			SELECT 
				@ItemId = P.Price.value('@ItemId','INT'),
				@DateTime = P.Price.value('@RecordTime', 'DATETIMEOFFSET(7)')
			FROM 
				@Xml.nodes('/ItemPrice/itp') AS P(Price)
		
			EXECUTE [dbo].[CheckGenerateUserNotifications] @ItemId, @DateTime

			END CONVERSATION @TargetDlgHandle;
		END 

	COMMIT TRAN;
END