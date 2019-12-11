CREATE PROCEDURE [dbo].[InsertItemPrice]
		@ItemId int,
		@RecordTime datetimeoffset(7),
		@Price money,
		@Currency smallint,
		@IsDiscounted bit
AS
BEGIN
	BEGIN TRAN

		SET @RecordTime = COALESCE(@RecordTime, SYSDATETIMEOFFSET())

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
			@RecordTime,
			@Price,
			@Currency,
			@IsDiscounted
		)

	EXECUTE [SendPriceForProcessing] @ItemId, @RecordTime

	COMMIT TRAN
END
