IF NOT EXISTS (SELECT * FROM [dbo].[Stores] WHERE [ServerAddress] = $(StoreAddress1))
BEGIN
	EXECUTE [dbo].[InsertStore] 'Xbox Store', $(StoreAddress1), 'services/api/v3/suggest'
END

IF NOT EXISTS (SELECT * FROM [dbo].[Stores] WHERE [ServerAddress]  = $(StoreAddress2))
BEGIN
	EXECUTE [dbo].[InsertStore] 'Playstation Store', $(StoreAddress2), 'api/v2/search/'
END

GO
