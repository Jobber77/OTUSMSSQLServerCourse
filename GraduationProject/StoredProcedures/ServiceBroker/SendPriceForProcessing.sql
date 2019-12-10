CREATE PROCEDURE [dbo].[SendPriceForProcessing]
	@ItemId INT,
	@RecordTime DATETIMEOFFSET(7)
AS
BEGIN
	DECLARE @InitDlgHandle UNIQUEIDENTIFIER;
	DECLARE @RequestMessage NVARCHAR(4000);
	
	BEGIN TRAN

		SELECT @RequestMessage = (SELECT 
										itp.[ItemId], 
										itp.[RecordTime]
									FROM [dbo].[ItemPrices] AS itp
									WHERE 
										itp.[ItemId] = @ItemId
										AND itp.[RecordTime] = @RecordTime
									FOR XML AUTO, root('ItemPrice')); 
	
		BEGIN DIALOG @InitDlgHandle
		FROM SERVICE
			[//GraduationProject/SB/InitiatorServices/NewPriceInitiatorService]
		TO SERVICE
			'//GraduationProject/SB/TargetServices/NewPriceTargetService'
		ON CONTRACT
			[//GraduationProject/SB/Contracts/PricesProcessing]
		WITH ENCRYPTION=OFF; 

		SEND ON CONVERSATION @InitDlgHandle
		MESSAGE TYPE
			[//GraduationProject/SB/RequestMessages/NewPriceMessage]
		(@RequestMessage);

	COMMIT TRAN

END
