CREATE TABLE [dbo].[UserNotifications]
(
 [Id]        bigint IDENTITY (1, 1) NOT NULL ,
 [UserId]    int NOT NULL ,
 [ItemId]    bigint NOT NULL ,
 [ChannelId] int NOT NULL ,
 [AddedAt]   datetimeoffset(7) NOT NULL ,
 [IsSent]    bit NOT NULL CONSTRAINT [DF_UserNotifications_IsSent] DEFAULT 0 ,
 [SentAt]    datetimeoffset(7) NULL ,


 CONSTRAINT [PK_UserNotifications] PRIMARY KEY CLUSTERED ([Id] ASC),
 CONSTRAINT [FK_UserNotifications_ChannelId_Channels_Id] FOREIGN KEY ([ChannelId])  REFERENCES [dbo].[Channels]([Id]),
 CONSTRAINT [FK_UserNotifications_ItemId_Items_Id] FOREIGN KEY ([ItemId])  REFERENCES [dbo].[Items]([Id]),
 CONSTRAINT [FK_UserNotifications_UserId_Users_Id] FOREIGN KEY ([UserId])  REFERENCES [dbo].[Users]([Id])
);
GO


CREATE NONCLUSTERED INDEX [IX_UserNotifications_ChannelId] ON [dbo].[UserNotifications] 
 (
  [ChannelId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [IX_UserNotifications_IsSent_AddedAt] ON [dbo].[UserNotifications] 
 (
  [IsSent] ASC, 
  [AddedAt] ASC
 )

GO

CREATE NONCLUSTERED INDEX [IX_UserNotifications_ItemId] ON [dbo].[UserNotifications] 
 (
  [ItemId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [IX_UserNotifications_UserId] ON [dbo].[UserNotifications] 
 (
  [UserId] ASC
 )

GO


EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Queue of Discount Notifications for Users', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserNotifications';
GO
