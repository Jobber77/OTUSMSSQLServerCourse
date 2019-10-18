CREATE TABLE [dbo].[UserChannels]
(
 [UserId]    int NOT NULL ,
 [ChannelId] int NOT NULL ,
 [Enabled]   bit NOT NULL ,


 CONSTRAINT [PK_UserChannels] PRIMARY KEY CLUSTERED ([UserId] ASC, [ChannelId] ASC),
 CONSTRAINT [FK_UserChannels_ChannelId_Channels_Id] FOREIGN KEY ([ChannelId])  REFERENCES [dbo].[Channels]([Id]),
 CONSTRAINT [FK_UserChannels_UserId_Users_Id] FOREIGN KEY ([UserId])  REFERENCES [dbo].[Users]([Id])
);
GO

-- Enabled channels will be searched for each UserNotification table insert.
CREATE NONCLUSTERED INDEX [IX_UserChannels_Enabled] ON [dbo].[UserChannels] 
 (
  [Enabled] ASC
 )

GO


EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Contains user''s channels (separate chats) for notifications', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserChannels';
GO
