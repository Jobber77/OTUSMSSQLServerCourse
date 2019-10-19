CREATE PROCEDURE [dbo].[UpdateUser]
	@Id int,
	@Name nvarchar(256),
	@Email nvarchar(256)
AS
BEGIN

	UPDATE [dbo].[Users] 
	SET 
		[Name] = @Name,
		[Email] = @Email
	WHERE [Id] = @Id

END
