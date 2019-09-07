INSERT INTO [Sales].[Customers] 
	( 
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
SELECT N'Васян', 1, 3, 1, 1001, 1002, 3, 19586, 19586, NULL,  GETDATE(), 1, 0, 0, 7, '777777', '1777777', NULL, NULL, N'хттпс://васян.ком', N'васян стрит', NULL, '1111', NULL, N'Васян Box 8975', NULL, '123', 1
UNION ALL
SELECT N'Петросян', 2, 4, 2, 1001, 1002, 3, 19586, 19586, NULL,  GETDATE(), 1, 0, 0, 7, '666', '1666', NULL, NULL, N'хттпс://Петросян.ком', N'Петросян стрит', NULL, '1111', NULL, N'Петросян Box 8975', NULL, '123', 1
UNION ALL
SELECT N'Гарри', 2, 4, 2, 1001, 1002, 3, 19586, 19586, NULL,  GETDATE(), 1, 0, 0, 7, '555', '1555', NULL, NULL, N'хттпс://Гарри.ком', N'Гарри стрит', NULL, '1111', NULL, N'Гарри Box 8975', NULL, '123', 1
UNION ALL
SELECT N'Сириус', 2, 4, 2, 1001, 1002, 3, 19586, 19586, NULL,  GETDATE(), 1, 0, 0, 7, '4444', '14444', NULL, NULL, N'хттпс://Сириус.ком', N'Сириус стрит', NULL, '1111', NULL, N'Сириус Box 8975', NULL, '123', 1
UNION ALL
SELECT N'Хагрид', 2, 4, 2, 1001, 1002, 3, 19586, 19586, NULL,  GETDATE(), 1, 0, 0, 7, '3333', '13333', NULL, NULL, N'хттпс://Хагрид.ком', N'Хагрид стрит', NULL, '1111', NULL, N'Хагрид Box 8975', NULL, '123', 1
