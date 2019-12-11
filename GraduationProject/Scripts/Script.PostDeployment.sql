/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

-- Data seeding
:setvar UserId1 100500
:setvar UserId2 500100
:setvar UserId3 111222
:setvar ChannelId1 123123
:setvar ChannelId2 456456
:setvar ChannelId3 789789
:setvar ItemId1 741741
:setvar ItemId2 852852
:setvar ItemId3 963963
:setvar StoreAddress1 'https://www.microsoft.com'
:setvar StoreAddress2 'https://store.playstation.com'

:r .\Data\Script.Users.sql
:r .\Data\Script.Stores.sql
:r .\Data\Script.Channels.sql
:r .\Data\Script.Items.sql
:r .\Data\Script.Settings.sql
:r .\Data\Script.UserChannels.sql
:r .\Data\Script.UserWhishlist.sql
:r .\Data\Script.UserNotifications.sql
:r .\Data\Script.ItemPrices.sql

-- Service broker types
:r .\ServiceBroker\Script.ServiceBrokerQueueActivations.sql
