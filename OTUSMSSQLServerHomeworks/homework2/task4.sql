CREATE PROCEDURE [dbo].[Homework2Task4]
AS
BEGIN
	SELECT po.PurchaseOrderID, s.SupplierName, p.FullName AS [ContactPersonName]
	FROM [Purchasing].[PurchaseOrders] po
	INNER JOIN [Purchasing].[Suppliers] s ON s.[SupplierID] = po.[SupplierID]
	INNER JOIN [Application].[DeliveryMethods] dm ON dm.[DeliveryMethodID] = po.[DeliveryMethodID]
	INNER JOIN [Application].[People] p ON p.[PersonID] = po.[ContactPersonID]
	WHERE 
		(dm.DeliveryMethodName = 'Road Freight' OR dm.DeliveryMethodName = 'Post')
		AND YEAR(po.ExpectedDeliveryDate) = 2014
		AND po.[IsOrderFinalized] = 1
END