
CREATE PROCEDURE [dbo].[DW_MergeFactOrders]
AS
BEGIN

	UPDATE dc
	SET [order_date_key]    = sc.[order_date_key]
	   ,[required_date_key] = sc.[required_date_key]
	   ,[shipped_date_key]  = sc.[shipped_date_key]
       ,[customer_sk]      = sc.[customer_sk]
	   ,[staff_sk]         = sc.[staff_sk]
	   ,[store_sk]         = sc.[store_sk]
	   ,[product_sk]       = sc.[product_sk]
	   ,[quantity]        = sc.[quantity]
	   ,[list_price]       = sc.[list_price]
	   ,[discount]        = sc.[discount]
	   ,[order_status]     = sc.[order_status]
	   ,[order_date]       = sc.[order_date] 
	   ,[required_date]    = sc.[required_date]
	   ,[shipped_date]     = sc.[shipped_date]
	FROM [dw].[FactOrders]         dc
	INNER JOIN [stg].[Orders] sc ON (dc.[order_id] = sc.[order_id] AND dc.[item_id] = sc.[item_id])
END
GO

