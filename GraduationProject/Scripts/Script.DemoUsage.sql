-- DATA FROM BOT APPLICATION:
DECLARE 
	@UserName NVARCHAR(256) = 'Tom Marvolo Riddle',
	@UserEmail NVARCHAR(256) = 'tom@hogwarts.com',
	@UserExternalId NVARCHAR(256) = '111222333444',
	@UserId BIGINT,
	@ChannelExternalId NVARCHAR(50) = '123456777',
	@ChannelId BIGINT

-- SAVE USER AND HIS CHANNEL
EXECUTE [dbo].[InsertUser] @UserName, @UserEmail, @UserExternalId
EXECUTE [dbo].[InsertChannel] @ChannelExternalId

-- MAP USER TO HIS CHANNEL
SELECT @UserId = [Id] FROM [dbo].[Users] WHERE [ExternalId] = @UserExternalId
SELECT @ChannelId = [Id] FROM [dbo].[Channels] WHERE [ExternalId] = @ChannelExternalId
EXECUTE [dbo].[InsertUserChannel] @UserId, @ChannelId, @Enabled = 1