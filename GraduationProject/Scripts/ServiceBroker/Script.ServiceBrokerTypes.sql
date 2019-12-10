GO

-- messages
IF NOT EXISTS (SELECT * FROM sys.service_message_types WHERE [name] = '//GraduationProject/SB/RequestMessages/NewPriceMessage')
BEGIN
	CREATE MESSAGE TYPE
		[//GraduationProject/SB/RequestMessages/NewPriceMessage]
	VALIDATION = WELL_FORMED_XML;
END

IF NOT EXISTS (SELECT * FROM sys.service_message_types WHERE [name] = '//GraduationProject/SB/ReplyMessages/PriceProcessedMessage')
BEGIN
	CREATE MESSAGE TYPE
		[//GraduationProject/SB/ReplyMessages/PriceProcessedMessage]
	VALIDATION = WELL_FORMED_XML; 
END

GO

-- contracts 
IF NOT EXISTS (SELECT * FROM sys.service_contracts WHERE [name] = '//GraduationProject/SB/Contracts/PricesProcessing')
BEGIN
	CREATE CONTRACT [//GraduationProject/SB/Contracts/PricesProcessing]
	(
		[//GraduationProject/SB/RequestMessages/NewPriceMessage]
		SENT BY INITIATOR,
		[//GraduationProject/SB/ReplyMessages/PriceProcessedMessage]
		SENT BY TARGET
    );
END

GO

-- queues 
IF NOT EXISTS (SELECT * FROM sys.service_queues WHERE [name] = 'NewPriceTargetQueue')
BEGIN
	CREATE QUEUE [dbo].[NewPriceTargetQueue];
END

IF NOT EXISTS (SELECT * FROM sys.service_queues WHERE [name] = 'NewPriceInitiatorQueue')
BEGIN
	CREATE QUEUE [dbo].[NewPriceInitiatorQueue];
END

GO

-- services
IF NOT EXISTS (SELECT * FROM sys.services WHERE [name] = '//GraduationProject/SB/TargetServices/NewPriceTargetService')
BEGIN
	CREATE SERVICE [//GraduationProject/SB/TargetServices/NewPriceTargetService]
       ON QUEUE [dbo].[NewPriceTargetQueue]
       ([//GraduationProject/SB/Contracts/PricesProcessing]);
END

IF NOT EXISTS (SELECT * FROM sys.services WHERE [name] = '//GraduationProject/SB/InitiatorServices/NewPriceInitiatorService')
BEGIN
	CREATE SERVICE [//GraduationProject/SB/InitiatorServices/NewPriceInitiatorService]
       ON QUEUE [dbo].[NewPriceInitiatorQueue]
       ([//GraduationProject/SB/Contracts/PricesProcessing]);
END

GO

-- enable queue processing
ALTER QUEUE [dbo].[NewPriceInitiatorQueue] WITH STATUS = ON , RETENTION = OFF , POISON_MESSAGE_HANDLING (STATUS = OFF) 
	, ACTIVATION (   STATUS = ON ,
        PROCEDURE_NAME = [dbo].[ConfirmProcessNewPrice], MAX_QUEUE_READERS = 1, EXECUTE AS OWNER) ; 

GO

ALTER QUEUE [dbo].[NewPriceTargetQueue]  WITH STATUS = ON , RETENTION = OFF , POISON_MESSAGE_HANDLING (STATUS = OFF)
	, ACTIVATION (  STATUS = ON ,
        PROCEDURE_NAME = [dbo].[ProcessNewPrice], MAX_QUEUE_READERS = 1, EXECUTE AS OWNER) ; 

GO
