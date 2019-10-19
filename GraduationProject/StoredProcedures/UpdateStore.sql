CREATE PROCEDURE [dbo].[UpdateStore]
	@Id int,
	@Name nvarchar(256),
	@ServerAddress nvarchar(256),
	@SearchEndPoint nvarchar(256)
AS
BEGIN
	
	UPDATE [dbo].[Stores] 
	SET
		[Name] = @Name,
		[ServerAddress] = @ServerAddress,
		[SearchEndPoint] = @SearchEndPoint
	WHERE
		[Id] = @Id

END
