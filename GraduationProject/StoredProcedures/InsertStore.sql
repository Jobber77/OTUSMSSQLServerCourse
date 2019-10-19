CREATE PROCEDURE [dbo].[InsertStore]
	@Name nvarchar(256),
	@ServerAddress nvarchar(256),
	@SearchEndPoint nvarchar(256)
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
		@Name,
		@ServerAddress,
		@SearchEndPoint
	)

	SELECT SCOPE_IDENTITY()

END
