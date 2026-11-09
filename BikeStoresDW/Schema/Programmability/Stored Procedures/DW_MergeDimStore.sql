
CREATE PROCEDURE [dbo].[DW_MergeDimStore]
AS
BEGIN

	UPDATE dc
	SET [store_name] = sc.[store_name]
	   ,[phone]     = sc.[phone]
	   ,[email]     = sc.[email]
	   ,[street]    = sc.[street]
	   ,[city]      = sc.[city]
	   ,[state]     = sc.[state]
	   ,[zip_code]   = sc.[zip_code]
	FROM [dw].[DimStore]        dc
	INNER JOIN [stg].[Store] sc ON (dc.[store_sk]=sc.[store_sk])
END
GO
