CREATE TABLE [dbo].[Stores]
(
 [Id]             int IDENTITY (1, 1) NOT NULL ,
 [Name]           nvarchar(256) NOT NULL ,
 [ServerAddress]  nvarchar(256) NOT NULL ,
 [SearchEndPoint] nvarchar(256) NOT NULL ,


 CONSTRAINT [PK_Stores] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO



EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Contains available for price tracking stores.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Stores';
GO
