CREATE TABLE [dbo].[ItemPrices]
(
 [ItemId]       bigint NOT NULL ,
 [RecordTime]   datetimeoffset(7) NOT NULL ,
 [Price]        money NOT NULL ,
 [Currency]     smallint NOT NULL ,
 [IsDiscounted] bit NOT NULL CONSTRAINT [DF_ItemPrices_IsDiscounted] DEFAULT 0 ,


 CONSTRAINT [PK_ItemsPrices] PRIMARY KEY CLUSTERED ([ItemId] ASC, [RecordTime] ASC),
 CONSTRAINT [FK_ItemsPrices_ItemId_Items_id] FOREIGN KEY ([ItemId])  REFERENCES [dbo].[Items]([Id])
);
GO

--This index will be ofthen used to find item on sale. If item on sale, Price and Currency will be always fetched as well.
CREATE NONCLUSTERED INDEX [IX_ItemPrices_IsDiscounted_Price_Currency] ON [dbo].[ItemPrices] 
 (
  [IsDiscounted] ASC, 
  [Price] ASC, 
  [Currency] ASC
 )

GO

--Price will be often monitored to caculate average price. Most of the time, when you look for the price, you would get Currency as well.
CREATE NONCLUSTERED INDEX [IX_ItemPrices_Price_Currency] ON [dbo].[ItemPrices] 
 (
  [Price] ASC, 
  [Currency] ASC
 )

GO


EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Historical data for items prices', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ItemPrices';
GO
