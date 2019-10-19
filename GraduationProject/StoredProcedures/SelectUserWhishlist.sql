CREATE PROCEDURE [dbo].[SelectUserWhishlist]
	@UserId int,
	@Enabled bit = NULL
AS
BEGIN

	SELECT 
		uw.[UserId],
		uw.[ItemId],
		i.[ExternalName] AS [ItemName],
		i.[ExternalId] AS [ItemExternalId],
		i.[ExternalLink] AS [ItemLink],
		s.[Name] AS [StoreName],
		s.[Id] AS [StoreId],
		uw.[AddedAt] AS [WhishlistedAt],
		uw.[Enabled] AS [NotificationsEnabled]
	FROM 
		[dbo].[UserWishlist] uw
		INNER JOIN [dbo].[Items] i ON i.[Id] = uw.[ItemId]
		INNER JOIN [dbo].[Stores] s ON s.[Id] = i.[StoreId]
	WHERE 
		uw.[UserId] = @UserId
		AND (@Enabled IS NULL OR uw.[Enabled] = @Enabled)

END
