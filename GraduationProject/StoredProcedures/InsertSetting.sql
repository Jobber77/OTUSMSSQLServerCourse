CREATE PROCEDURE [dbo].[InsertSetting]
	@ApplicationKey nvarchar(100),
	@Key nvarchar(100),
	@Value nvarchar(256)
AS
BEGIN
	
	INSERT INTO [dbo].[Settings] 
	(
		[ApplicationKey],
		[Key],
		[Value]
	)
	VALUES
	(
		@ApplicationKey,
		@Key,
		@Value
	)

END
