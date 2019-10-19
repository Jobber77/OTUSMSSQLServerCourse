IF NOT EXISTS (SELECT * FROM [dbo].[Channels] WHERE [ExternalId] = $(ChannelId1))
BEGIN
	EXECUTE [dbo].[InsertChannel] $(ChannelId1)
END

IF NOT EXISTS (SELECT * FROM [dbo].[Channels] WHERE [ExternalId] = $(ChannelId2))
BEGIN
	EXECUTE [dbo].[InsertChannel] $(ChannelId2)
END

IF NOT EXISTS (SELECT * FROM [dbo].[Channels] WHERE [ExternalId] = $(ChannelId3))
BEGIN
	EXECUTE [dbo].[InsertChannel] $(ChannelId3)
END

GO