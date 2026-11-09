CREATE PROCEDURE [dbo].[DW_MergeDimProduct]
AS
BEGIN

	UPDATE dc
	SET [product_name]  = sc.[product_name]
	   ,[brand_name]    = sc.[brand_name]
	   ,[category_name] = sc.[category_name]
	   ,[model_year]    = sc.[model_year]
	   ,[list_price]    = sc.[list_price]
	FROM [dw].[DimProduct]         dc
	INNER JOIN [stg].[Product] sc ON (dc.[product_sk]=sc.[product_sk])
END
GO