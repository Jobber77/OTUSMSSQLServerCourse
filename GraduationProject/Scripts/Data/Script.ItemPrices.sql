DECLARE @ItemId int;
DECLARE @Iterations int = 10;
DECLARE @Date datetimeoffset(7) = DATEADD(DAY, -@Iterations, SYSDATETIMEOFFSET());

SELECT TOP 1 @ItemId = [Id] FROM dbo.[Items] WHERE [ExternalId] = $(ItemId1)
IF NOT EXISTS (SELECT * FROM [dbo].[ItemPrices]
				WHERE [ItemId] =  @ItemId)
BEGIN
	WHILE @Iterations > 1
	BEGIN
		EXECUTE [dbo].[InsertItemPrice] @ItemId, @Date, 100, 1, 0
		SET @Iterations = @Iterations - 1;
		SET @Date = DATEADD(DAY, 1, @Date);
	END
	SET @Date = DATEADD(DAY, 1, @Date);
	EXECUTE [dbo].[InsertItemPrice] @ItemId, @Date, 50, 1, 1
END

GO
