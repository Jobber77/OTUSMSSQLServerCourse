CREATE PROCEDURE [dbo].[SelectItem]
	@Id int
AS
BEGIN
	
	SELECT 
		[Id],
		[StoreId],
		[ExternalId],
		[ExternalName],
		[ExternalLink],
		[LastAddedBy]
	FROM [dbo].[Items]
	WHERE [Id] = @Id

END
