/*
updated script
Улучшил читаемость за счёт выноса подзапросов в CTE, 
вложенный подзапрос заменил джоином, 
избавился от зависимых подзапросов

На моей машине CPU time 172ms(new) vs 422(old), elapsed time 450ms(new) vs 1270ms(old)

На execution plan SQL server почему-то показывает query cost нового запроса выше, 
чем у оригинального (51%vs49%). 
Возможно, связано с тем, что старый запрос выполняется с параллельностью.

Скрин плана не могу сделать, потому что план не помещается на моник моего ноута с достаточной читаемостью ;(

Идеи по улучшению перформанса - сделать view инвойсов, 
где есть поле TotalCost каждого инвойса с индекосм на нём.
Должно хорошо помочь, потому что самая дорогая операция - скан всего индекса таблицы Invoices.
*/
CREATE PROCEDURE [dbo].[Homework3Task5]
AS
BEGIN
	DECLARE @MinInvoiceTotal INT = 27000; 

	;WITH SalesTotals
	AS
	(
		SELECT 
			[InvoiceId], 
			SUM([Quantity] * [UnitPrice]) AS TotalSumm
		FROM Sales.[InvoiceLines]
		GROUP BY [InvoiceId]
		HAVING SUM([Quantity] * [UnitPrice]) > @MinInvoiceTotal
	),
	TotalSummForPickedItems
	AS
	(
		SELECT 
			SUM(ol.PickedQuantity * ol.UnitPrice) AS TotalSummForPickedItems,
			ol.[OrderID]
		FROM Sales.OrderLines ol
		INNER JOIN Sales.[Orders] o ON o.OrderID = ol.OrderID
		WHERE o.PickingCompletedWhen IS NOT NULL
		GROUP BY ol.[OrderID]
	)
	SELECT 
		i.[InvoiceID], 
		i.[InvoiceDate], 
		p.[FullName] AS SalesPersonName, 
		SalesTotals.[TotalSumm] AS TotalSummByInvoice, 
		TotalSummForPickedItems.[TotalSummForPickedItems]
	FROM 
		Sales.[Invoices] i
		INNER JOIN [Application].[People] p ON p.[PersonID] = i.[SalespersonPersonID]
		INNER JOIN TotalSummForPickedItems ON TotalSummForPickedItems.[OrderID] = i.[OrderID]
		INNER JOIN SalesTotals ON i.[InvoiceID] = SalesTotals.[InvoiceID]
	ORDER BY SalesTotals.[TotalSumm] DESC;
END
