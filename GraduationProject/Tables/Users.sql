CREATE TABLE [dbo].[Users]
(
 [Id]         int IDENTITY (1, 1) NOT NULL ,
 [Name]       nvarchar(256) NOT NULL ,
 [Email]      nvarchar(256) NULL ,
 [ExternalId] nvarchar(256) NOT NULL ,


 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

-- this index will speed up match users from Bot Messages to application users
CREATE NONCLUSTERED INDEX [IX_Users_ExternalId] ON [dbo].[Users] 
 (
  [ExternalId] ASC
 )

GO

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Contains application users. All application users are Telegram users.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Users';
GO
