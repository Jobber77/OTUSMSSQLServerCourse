CREATE TABLE [dbo].[Items]
(
 [Id]           bigint IDENTITY (1, 1) NOT NULL ,
 [StoreId]      int NOT NULL ,
 [ExternalId]   nvarchar(256) NOT NULL ,
 [ExternalName] nvarchar(256) NOT NULL ,
 [ExternalLink] nvarchar(256) NOT NULL ,
 [LastAddedBy]  int NOT NULL ,


 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED ([Id] ASC),
 CONSTRAINT [FK_Items_LastAddedBy_Users_Id] FOREIGN KEY ([LastAddedBy])  REFERENCES [dbo].[Users]([Id]) ON DELETE NO ACTION ON UPDATE CASCADE,
 CONSTRAINT [FK_Items_StoreId_Stores_Id] FOREIGN KEY ([StoreId])  REFERENCES [dbo].[Stores]([Id]) ON DELETE NO ACTION ON UPDATE CASCADE
);
GO

-- ExternalName and ExternalLink will be ofthen required together with ExternalId to send to user, but almost never will be required alone. ExternalId will be searched for each user interaction.
CREATE NONCLUSTERED INDEX [IX_Items_ExternalId_ExternalName_ExternalLink] ON [dbo].[Items] 
 (
  [ExternalId] ASC, 
  [ExternalName] ASC, 
  [ExternalLink] ASC
 )

GO

--There is common sence reccomendatation: when you have FK, there should be Index as well, for join purposes.
CREATE NONCLUSTERED INDEX [IX_Items_LastAddedBy] ON [dbo].[Items] 
 (
  [LastAddedBy] ASC
 )

GO

--There is common sence reccomendatation: when you have FK, there should be Index as well, for join purposes.
CREATE NONCLUSTERED INDEX [IX_Items_StoreId] ON [dbo].[Items] 
 (
  [StoreId] ASC
 )

GO


EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Contains trackable items in Stores.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Items';
GO
