SELECT 
	[CustomerName],
	[AddressLine]
FROM 
(
	SELECT 
		c.[CustomerID],
		c.[CustomerName],
		c.[DeliveryAddressLine1],
		c.[DeliveryAddressLine2],
		c.[PostalAddressLine1],
		c.[PostalAddressLine2]
	FROM [Sales].[Customers] c
) AS customerData
UNPIVOT
(
	[AddressLine]
	FOR [Column] IN ([DeliveryAddressLine1], [DeliveryAddressLine2], [PostalAddressLine1], [PostalAddressLine2])
) AS customerUnpivot