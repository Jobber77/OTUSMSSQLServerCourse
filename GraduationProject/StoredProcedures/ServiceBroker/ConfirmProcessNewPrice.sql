CREATE PROCEDURE [dbo].[ConfirmProcessNewPrice]
AS
BEGIN

	DECLARE @InitiatorReplyDlgHandle UNIQUEIDENTIFIER,
			@ReplyReceivedMessage NVARCHAR(4000),
			@MessageType SYSNAME;
	
	BEGIN TRAN; 

		RECEIVE TOP (1)
			@InitiatorReplyDlgHandle = [conversation_handle],
			@ReplyReceivedMessage = [message_body],
			@MessageType = [message_type_name]
		FROM [dbo].[NewPriceInitiatorQueue]; 

		IF @MessageType=N'//GraduationProject/SB/ReplyMessages/PriceProcessedMessage'
		BEGIN
			END CONVERSATION @InitiatorReplyDlgHandle;
		END

	COMMIT TRAN;
END
