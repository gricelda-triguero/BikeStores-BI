CREATE PROCEDURE [dbo].[DW_MergeDimCustomer]
AS
BEGIN

	UPDATE dc
	SET [first_name] = sc.[first_name]
	   ,[last_name]  = sc.[last_name]
	   ,[phone]     = sc.[phone]
	   ,[email]     = sc.[email]
	   ,[street]    = sc.[street]
	   ,[city]      = sc.[city]
	   ,[state]     = sc.[state]
	   ,[zip_code]   = sc.[zip_code]
	FROM [dw].[DimCustomer]        dc
	INNER JOIN [stg].[Customer] sc ON (dc.[customer_sk]=sc.[customer_sk])
END
GO