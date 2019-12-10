CREATE PROCEDURE [dbo].[InsertItemPrice]
		@ItemId int,
		@RecordTime datetimeoffset(7),
		@Price money,
		@Currency smallint,
		@IsDiscounted bit
AS
BEGIN
	BEGIN TRAN

		INSERT INTO [dbo].[ItemPrices] 
		(
			[ItemId],
			[RecordTime],
			[Price],
			[Currency],
			[IsDiscounted]
		)
		VALUES
		(
			@ItemId,
			COALESCE(@RecordTime, SYSDATETIMEOFFSET()),
			@Price,
			@Currency,
			@IsDiscounted
		)

	EXECUTE [SendPriceForProcessing] @ItemId, @RecordTime

	COMMIT TRAN
END
