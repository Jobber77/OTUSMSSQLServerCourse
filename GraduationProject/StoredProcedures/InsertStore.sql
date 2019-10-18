CREATE PROCEDURE [dbo].[InsertStore]
	@name nvarchar(256),
	@serverAddress nvarchar(256),
	@searchEndPoint nvarchar(256)
AS
BEGIN
	
	INSERT INTO [dbo].[Stores] 
	(
		[Name],
		[ServerAddress],
		[SearchEndPoint]
	)
	VALUES
	(
		@name,
		@serverAddress,
		@searchEndPoint
	)

	SELECT SCOPE_IDENTITY()

END
