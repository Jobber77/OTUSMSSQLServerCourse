--customer source
DECLARE @externalCustomerSource TABLE 
	(
		[CustomerName] [nvarchar](100) NOT NULL,
		[BillToCustomerID] [int] NOT NULL,
		[CustomerCategoryID] [int] NOT NULL,
		[BuyingGroupID] [int] NULL,
		[PrimaryContactPersonID] [int] NOT NULL,
		[AlternateContactPersonID] [int] NULL,
		[DeliveryMethodID] [int] NOT NULL,
		[DeliveryCityID] [int] NOT NULL,
		[PostalCityID] [int] NOT NULL,
		[CreditLimit] [decimal](18, 2) NULL,
		[AccountOpenedDate] [date] NOT NULL,
		[StandardDiscountPercentage] [decimal](18, 3) NOT NULL,
		[IsStatementSent] [bit] NOT NULL,
		[IsOnCreditHold] [bit] NOT NULL,
		[PaymentDays] [int] NOT NULL,
		[PhoneNumber] [nvarchar](20) NOT NULL,
		[FaxNumber] [nvarchar](20) NOT NULL,
		[DeliveryRun] [nvarchar](5) NULL,
		[RunPosition] [nvarchar](5) NULL,
		[WebsiteURL] [nvarchar](256) NOT NULL,
		[DeliveryAddressLine1] [nvarchar](60) NOT NULL,
		[DeliveryAddressLine2] [nvarchar](60) NULL,
		[DeliveryPostalCode] [nvarchar](10) NOT NULL,
		[DeliveryLocation] [geography] NULL,
		[PostalAddressLine1] [nvarchar](60) NOT NULL,
		[PostalAddressLine2] [nvarchar](60) NULL,
		[PostalPostalCode] [nvarchar](10) NOT NULL,
		[LastEditedBy] [int] NOT NULL
	)

--fill source
INSERT INTO @externalCustomerSource 
SELECT N'Васян2', 1, 3, 1, 1001, 1002, 3, 19586, 19586, NULL,  GETDATE(), 1, 0, 0, 7, '777777', '1777777', NULL, NULL, N'хттпс://васян2.ком', N'васян2 стрит', NULL, '1111', NULL, N'Васян2 Box 8975', NULL, '123', 1

MERGE [Sales].[Customers]  AS target  
USING (SELECT * FROM @externalCustomerSource) AS source 
ON target.[CustomerName] = source.[CustomerName]  
WHEN MATCHED THEN  
UPDATE SET 
	target.[WebsiteURL] = source.[WebsiteURL], 
	target.[DeliveryAddressLine1] = source.[DeliveryAddressLine1]
WHEN NOT MATCHED THEN  
	INSERT (
			[CustomerName]
			,[BillToCustomerID]
			,[CustomerCategoryID]
			,[BuyingGroupID]
			,[PrimaryContactPersonID]
			,[AlternateContactPersonID]
			,[DeliveryMethodID]
			,[DeliveryCityID]
			,[PostalCityID]
			,[CreditLimit]
			,[AccountOpenedDate]
			,[StandardDiscountPercentage]
			,[IsStatementSent]
			,[IsOnCreditHold]
			,[PaymentDays]
			,[PhoneNumber]
			,[FaxNumber]
			,[DeliveryRun]
			,[RunPosition]
			,[WebsiteURL]
			,[DeliveryAddressLine1]
			,[DeliveryAddressLine2]
			,[DeliveryPostalCode]
			,[DeliveryLocation]
			,[PostalAddressLine1]
			,[PostalAddressLine2]
			,[PostalPostalCode]
			,[LastEditedBy]
			) 
		VALUES 
			(
			source.[CustomerName]
			,source.[BillToCustomerID]
			,source.[CustomerCategoryID]
			,source.[BuyingGroupID]
			,source.[PrimaryContactPersonID]
			,source.[AlternateContactPersonID]
			,source.[DeliveryMethodID]
			,source.[DeliveryCityID]
			,source.[PostalCityID]
			,source.[CreditLimit]
			,source.[AccountOpenedDate]
			,source.[StandardDiscountPercentage]
			,source.[IsStatementSent]
			,source.[IsOnCreditHold]
			,source.[PaymentDays]
			,source.[PhoneNumber]
			,source.[FaxNumber]
			,source.[DeliveryRun]
			,source.[RunPosition]
			,source.[WebsiteURL]
			,source.[DeliveryAddressLine1]
			,source.[DeliveryAddressLine2]
			,source.[DeliveryPostalCode]
			,source.[DeliveryLocation]
			,source.[PostalAddressLine1]
			,source.[PostalAddressLine2]
			,source.[PostalPostalCode]
			,source.[LastEditedBy]
			);