
ALTER TABLE [dbo].[Users] ADD CONSTRAINT PK_Users_Id  PRIMARY KEY CLUSTERED (Id)
GO
ALTER TABLE [dbo].[Stores] ADD CONSTRAINT PK_Stores_Id  PRIMARY KEY CLUSTERED (Id)
GO
ALTER TABLE [dbo].[Items] ADD CONSTRAINT PK_Items_Id  PRIMARY KEY CLUSTERED (Id)
GO
ALTER TABLE [dbo].[Items] ADD CONSTRAINT FK_Items_StoreId_Stores_Id FOREIGN KEY ([StoreId]) REFERENCES [dbo].[Stores] ([Id])
GO
ALTER TABLE [dbo].[Items] ADD CONSTRAINT FK_Items_LastAddedBy_Users_Id FOREIGN KEY ([LastAddedBy]) REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UserWishlist] ADD CONSTRAINT PK_UserWishlist_Id  PRIMARY KEY CLUSTERED (Id)
GO
ALTER TABLE [dbo].[UserWishlist] ADD CONSTRAINT FK_UserWishlist_UserId_Users_Id FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UserWishlist] ADD CONSTRAINT FK_UserWishlist_StoreId_Users_Id FOREIGN KEY ([UserId]) REFERENCES [dbo].[Stores] ([Id])
GO
