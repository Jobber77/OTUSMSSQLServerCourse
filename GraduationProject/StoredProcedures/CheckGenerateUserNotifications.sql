CREATE PROCEDURE [dbo].[CheckGenerateUserNotifications]
	@ItemId INT,
	@DateTime DATETIMEOFFSET(7)
AS
BEGIN
	
	DECLARE	@IsDiscounted BIT;

	SELECT
		@IsDiscounted = itp.[IsDiscounted]
	FROM
		[dbo].[ItemPrices] itp
	WHERE
		itp.[ItemId] = @ItemId
		AND itp.[RecordTime] = @DateTime

	IF (@IsDiscounted = 1)
	BEGIN
		
		DECLARE 
			@CurrentPrice MONEY,
			@FullPrice MONEY,
			@MinDiscountPercent DECIMAL

		SELECT 
			@CurrentPrice = itpCurrent.[Price],
			@FullPrice = itpFullPrice.[Price]
		FROM
			[dbo].[ItemPrices] itpCurrent
			OUTER APPLY (
							SELECT TOP (1) [Price]
							FROM [dbo].[ItemPrices]
							WHERE 
								[IsDiscounted] = 0
								AND [ItemId] = itpCurrent.[ItemId]
							ORDER BY [RecordTime] DESC
						) itpFullPrice
		WHERE
			itpCurrent.[ItemId] = @ItemId
			AND itpCurrent.[RecordTime] = @DateTime

		SELECT 
			@MinDiscountPercent = CAST ([Value] AS DECIMAL)
		FROM [dbo].[Settings] 
		WHERE [Key] = 'NotificationSettings:MinDiscountPercent'

		IF (@FullPrice IS NULL 
			OR 
			((1 - (@CurrentPrice / @FullPrice)) * 100) > @MinDiscountPercent )
		BEGIN
			EXECUTE [dbo].[GenerateUserNotifications] @ItemId, @DateTime
		END
	END
END
