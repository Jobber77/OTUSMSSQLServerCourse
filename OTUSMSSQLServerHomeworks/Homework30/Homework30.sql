-- filegroup
ALTER DATABASE [WideWorldImporters] ADD FILEGROUP [YearData]
GO

ALTER DATABASE [WideWorldImporters] ADD FILE 
( NAME = N'Years', FILENAME = N'C:\SQLServer2017Media\Yeardata.ndf' , 
SIZE = 2097152KB , FILEGROWTH = 65536KB ) TO FILEGROUP [YearData]
GO

-- partition function and schema
CREATE PARTITION FUNCTION [fn_YearPartition](DATE) AS RANGE RIGHT FOR VALUES
(
	'20130101',
	'20140101',
	'20150101',
	'20160101',
	'20170101',
	'20180101',
	'20190101',
	'20200101'
);																																																									
GO

CREATE PARTITION SCHEME [schmYearPartition] AS PARTITION [fn_YearPartition] ALL TO ([YearData])
GO

-- partitioned table
CREATE TABLE [Sales].[OrdersYears]
(
	[OrderID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[SalespersonPersonID] [int] NOT NULL,
	[PickedByPersonID] [int] NULL,
	[ContactPersonID] [int] NOT NULL,
	[BackorderOrderID] [int] NULL,
	[OrderDate] [date] NOT NULL,
	[ExpectedDeliveryDate] [date] NOT NULL,
	[CustomerPurchaseOrderNumber] [nvarchar](20) NULL,
	[IsUndersupplyBackordered] [bit] NOT NULL,
	[Comments] [nvarchar](max) NULL,
	[DeliveryInstructions] [nvarchar](max) NULL,
	[InternalComments] [nvarchar](max) NULL,
	[PickingCompletedWhen] [datetime2](7) NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL,
) ON [schmYearPartition]([OrderDate])
GO

-- partitioned PK for table
ALTER TABLE [Sales].[OrdersYears] ADD CONSTRAINT PK_Sales_OrdersYears PRIMARY KEY CLUSTERED 
(
	[OrderDate],
	[OrderID]
)
 ON [schmYearPartition] ([OrderDate]);

 GO

-- bulk copy data from non-partitioned table to partitioned
-- allow advanced options to be changed.  
EXEC sp_configure 'show advanced options', 1
GO

-- update the currently configured value for advanced options.  
RECONFIGURE;  
GO 
-- enable the xp_cmdshell feature.  
EXEC sp_configure 'xp_cmdshell', 1;  
GO  
-- update the currently configured value for this feature.  
RECONFIGURE;  
GO  
-- copy data to from non-partitioned table to file 
EXEC master..xp_cmdshell 'bcp "[WideWorldImporters].[Sales].[Orders]" out "C:\SQLServer2017Media\Orders.txt" -T -w -t "@eu&$" -S localhost'

-- insert data to partitioned table
DECLARE 
	@Path VARCHAR(256),
	@FileName VARCHAR(256),
	@Query	NVARCHAR(MAX),
	@Dbname VARCHAR(255),
	@BatchSize INT
	
	SET @Path = 'C:\SQLServer2017Media\';
	SET @FileName = 'Orders.txt';
	SELECT @Dbname = DB_NAME();
	SET @Batchsize = 1000;

BEGIN TRY

		IF @FileName IS NOT NULL
		BEGIN
			SET @query = 'BULK INSERT ['+@dbname+'].[Sales].[OrdersYears]
				   FROM "'+@path+@FileName+'"
				   WITH 
					 (
						BATCHSIZE = '+CAST(@batchsize AS VARCHAR(255))+', 
						DATAFILETYPE = ''widechar'',
						FIELDTERMINATOR = ''@eu&$'',
						ROWTERMINATOR =''\n'',
						KEEPNULLS,
						TABLOCK        
					  );'

			EXEC sp_executesql @query 
		END;
	END TRY

	BEGIN CATCH
		SELECT   
			ERROR_NUMBER() AS [ErrorNumber]  
			,ERROR_MESSAGE() AS [ErrorMessage];
	END CATCH
