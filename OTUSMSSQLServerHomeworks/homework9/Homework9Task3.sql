CREATE NONCLUSTERED INDEX IX_Users_ExternalId ON [dbo].[Users] ([ExternalId]);
GO
CREATE NONCLUSTERED INDEX IX_Users_Email ON [dbo].[Users] ([Email]);
GO
CREATE NONCLUSTERED INDEX IX_Items_ExternalId ON [dbo].[Items] ([ExternalId]);
GO
CREATE NONCLUSTERED INDEX IX_Items_ExternalName ON [dbo].[Items] ([ExternalName]);
GO
CREATE NONCLUSTERED INDEX IX_Stores_Name ON [dbo].[Stores] ([Name]);
GO
CREATE NONCLUSTERED INDEX IX_UserWishList_UserId ON [dbo].[UserWishList] ([UserId]);
GO
CREATE NONCLUSTERED INDEX IX_UserWishList_ItemId ON [dbo].[UserWishList] ([ItemId]);
GO
