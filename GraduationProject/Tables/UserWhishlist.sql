CREATE TABLE [dbo].[UserWishlist]
(
 [Id]      bigint IDENTITY (1, 1) NOT NULL ,
 [UserId]  int NOT NULL ,
 [ItemId]  bigint NOT NULL ,
 [AddedAt] datetimeoffset(7) NOT NULL CONSTRAINT [DF_UserWishlist_Added] DEFAULT SYSDATETIMEOFFSET() ,
 [Enabled] bit NOT NULL CONSTRAINT [DF_UserWishlist_Enabled] DEFAULT 1 ,


 CONSTRAINT [PK_UserWishlist] PRIMARY KEY CLUSTERED ([Id] ASC),
 CONSTRAINT [FK_UserWishlist_ItemId_Items_Id] FOREIGN KEY ([ItemId])  REFERENCES [dbo].[Items]([Id]),
 CONSTRAINT [FK_UserWishlist_UserId_Users_Id] FOREIGN KEY ([UserId])  REFERENCES [dbo].[Users]([Id])
);
GO

--There is common sence reccomendatation: when you have FK, there should be Index as well, for join purposes.
CREATE NONCLUSTERED INDEX [IX_UserWishlist_ItemId] ON [dbo].[UserWishlist] 
 (
  [ItemId] ASC
 )

GO

--There is common sence reccomendatation: when you have FK, there should be Index as well, for join purposes. 
--Enabled included in Index as it will be often user for updating UserNotifications table (only Enabled entries will be inserted).
CREATE NONCLUSTERED INDEX [IX_UserWishlist_UserId_Enabled] ON [dbo].[UserWishlist] 
 (
  [UserId] ASC, 
  [Enabled] ASC
 )

GO


EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Whishlisted (tracked) items for price monitoring', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserWishlist';
GO
