CREATE TABLE [dbo].[Settings]
(
 [ApplicationKey] nvarchar(100) NOT NULL ,
 [Key]            nvarchar(100) NOT NULL ,
 [Value]          nvarchar(256) NOT NULL ,


 CONSTRAINT [PK_Settings] PRIMARY KEY CLUSTERED ([ApplicationKey] ASC, [Key] ASC)
);
GO



EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Application settings. .Net core app will use it to configure itself (reply templates, shedule, etc).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Settings';
GO
