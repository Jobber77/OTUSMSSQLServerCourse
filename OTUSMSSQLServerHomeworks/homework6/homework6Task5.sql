--export from source table
exec xp_cmdshell 'bcp "[WideWorldImporters].[Application].[DeliveryMethods]" out "D:\DeliveryMethods.txt" -T -w -t"@@@pikachurulezz@@@" -S DESKTOP-J6BSRVK'

--create temp table
CREATE TABLE #deliveryMethods
	(
		[DeliveryMethodID] [int] NOT NULL,
		[DeliveryMethodName] [nvarchar](50) NOT NULL,
		[LastEditedBy] [int] NOT NULL,
		[ValidFrom] [datetime2](7),
		[ValidTo] [datetime2](7)
	)

BULK INSERT #deliveryMethods
				FROM "D:\DeliveryMethods.txt"
				WITH 
					(
					BATCHSIZE = 100, 
					DATAFILETYPE = 'widechar',
					FIELDTERMINATOR = '@@@pikachurulezz@@@',
					ROWTERMINATOR ='\n',
					KEEPNULLS,
					TABLOCK        
					);

SELECT * FROM #deliveryMethods

DROP TABLE #deliveryMethods