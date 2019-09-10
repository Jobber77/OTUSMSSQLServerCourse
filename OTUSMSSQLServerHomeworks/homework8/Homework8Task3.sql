SELECT 
	[CountryId],
	[CountryName],
	[Code]
FROM 
(SELECT 
	[CountryId],
	[CountryName],
	[IsoAlpha3Code],
	CAST([IsoNumericCode] AS NVARCHAR(3)) AS [IsoNumericCode]
	FROM [Application].[Countries]
) AS countries
UNPIVOT
(
	[Code]
	FOR [Codes] IN ([IsoAlpha3Code], [IsoNumericCode])
) AS codeUnpivot