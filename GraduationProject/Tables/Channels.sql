CREATE TABLE [dbo].[Channels]
(
 [Id]         int NOT NULL ,
 [ExternalId] nvarchar(50) NOT NULL ,


 CONSTRAINT [PK_Channels] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

-- This field will be often searched to find user's channels Ids.
CREATE UNIQUE NONCLUSTERED INDEX [IX_Channels_ExternalId] ON [dbo].[Channels] 
 (
  [ExternalId] ASC
 )

GO


EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Channels dictionary', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Channels';
GO
