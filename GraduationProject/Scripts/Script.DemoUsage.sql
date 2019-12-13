-- DATA FROM BOT APPLICATION, WHEN INTERACT WITH USER:
DECLARE 
	@UserName NVARCHAR(256) = 'Tom Marvolo Riddle',
	@UserEmail NVARCHAR(256) = 'tom@hogwarts.com',
	@UserExternalId NVARCHAR(256) = '111222333444',
	@UserId BIGINT,
	@ChannelExternalId NVARCHAR(50) = '123456777',
	@ChannelId BIGINT,
	@StoreId BIGINT,
	@StoreName NVARCHAR(256) = 'Xbox Store',
	@ItemId BIGINT,
	@ItemExternalId NVARCHAR(256) = '30004000',
	@ItemExternalName NVARCHAR(256) = 'Cyberpunk 2077',
	@ItemExternalLink NVARCHAR(256) = 'https://www.xbox.com/ru-ru/games/cyberpunk-2077',
	@DateTime DATETIMEOFFSET(7)

-- SAVE USER AND HIS CHANNEL
EXECUTE [dbo].[InsertUser] @UserName, @UserEmail, @UserExternalId
EXECUTE [dbo].[InsertChannel] @ChannelExternalId

-- MAP USER TO HIS CHANNEL
SELECT @UserId = [Id] FROM [dbo].[Users] WHERE [ExternalId] = @UserExternalId
SELECT @ChannelId = [Id] FROM [dbo].[Channels] WHERE [ExternalId] = @ChannelExternalId
EXECUTE [dbo].[InsertUserChannel] @UserId, @ChannelId, @Enabled = 1

-- ADD ITEM FOR TRACKING
SELECT @StoreId = [Id] FROM [dbo].[Stores] WHERE [Name] = @StoreName
EXECUTE [dbo].[InsertItem] @StoreId, @ItemExternalId, @ItemExternalName, @ItemExternalLink, @UserId

-- ADD ITEM TO USER WHISHLIST
SELECT @ItemId = [Id] FROM [dbo].[Items] WHERE [ExternalId] = @ItemExternalId
SET @DateTime = SYSDATETIMEOFFSET()
EXECUTE [dbo].[InsertUserWhishlist] @UserId, @ItemId, @DateTime, @Enabled = 1

-- NOW APPLICATION BACKGROUND SERVER CHECK PRICES AND INSERT HISTORY PERIODICALLY
SET @DateTime = SYSDATETIMEOFFSET()
EXECUTE [dbo].[InsertItemPrice] @ItemId, @DateTime, @Price = 10, @Currency = 1, @IsDiscounted = 1

-- SERVICE BROKER SERVICES PROCESS NEW PRICES AND GENERATE NOTIFICATIONS
-- APPLICATION PERIODICALLY FETCH LIST OF AWAITING NOTIFICATIONS AND SEND THEM