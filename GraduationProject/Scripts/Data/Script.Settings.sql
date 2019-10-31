IF NOT EXISTS (SELECT * FROM [dbo].[Settings])
BEGIN
	EXECUTE [dbo].[InsertSetting] 'BOT', 'RandomKey1', 'RandomValue1'
	EXECUTE [dbo].[InsertSetting] 'BOT', 'RandomKey2', 'RandomValue2'
	EXECUTE [dbo].[InsertSetting] 'BOT', 'RandomKey3', 'RandomValue3'
END

GO
