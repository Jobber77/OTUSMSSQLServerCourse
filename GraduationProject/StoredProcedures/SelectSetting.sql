CREATE PROCEDURE [dbo].[SelectSetting]
	@ApplicationKey nvarchar(100),
	@Key nvarchar(100)
AS
BEGIN
	
	SELECT 
		[ApplicationKey],
		[Key],
		[Value]
	FROM [dbo].[Settings] 
	WHERE
		[ApplicationKey] = @ApplicationKey
		AND [Key] = @Key

END
