CREATE PROCEDURE [dbo].[InsertItemPrice]
		@ItemId int,
		@RecordTime datetimeoffset(7),
		@Price money,
		@Currency smallint,
		@IsDiscounted bit
AS
BEGIN

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

END
