CREATE SERVICE [//GraduationProject/SB/TargetServices/NewPriceTargetService]
	ON QUEUE [dbo].[NewPriceTargetQueue]
	(
		[//GraduationProject/SB/Contracts/PricesProcessingContract]
	);