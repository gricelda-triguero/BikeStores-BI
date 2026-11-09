
CREATE PROCEDURE [dbo].[DW_MergeDimStaff]
AS
BEGIN

	UPDATE ds
	SET [first_name] = sc.[first_name]
	   ,[last_name]  = sc.[last_name]
	   ,[email]     = sc.[email]
	   ,[phone]     = sc.[phone]
	   ,[active]    = sc.[active]
	   ,[manager_id] = sc.[manager_id]
	FROM [dw].[DimStaff]           ds
	INNER JOIN [stg].[Staff] sc ON (ds.[staff_sk] = sc.[staff_sk])
END
GO
