CREATE PROCEDURE [dbo].[UpdateSetting]
	@ApplicationKey nvarchar(100),
	@Key nvarchar(100),
	@Value nvarchar(256)
AS
BEGIN
	
	UPDATE [dbo].[Settings] 
	SET	[Value] = @Value
	WHERE
		[ApplicationKey] = @ApplicationKey 
		AND [Key] = @Key

END
