CREATE SERVICE [//GraduationProject/SB/InitiatorServices/NewPriceInitiatorService]
	ON QUEUE [dbo].[NewPriceInitiatorQueue]
    (
		[//GraduationProject/SB/Contracts/PricesProcessingContract]
	);