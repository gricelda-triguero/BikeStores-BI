CREATE TABLE [stg].[Orders]
(
	[order_id] INTEGER NOT NULL,
	[item_id] INTEGER NOT NULL,
	[order_date_key] INTEGER NOT NULL,
	[required_date_key] INTEGER NOT NULL,
	[shipped_date_key] INTEGER NOT NULL,
	[customer_sk] INTEGER NULL,
	[staff_sk] INTEGER NULL,
	[store_sk] INTEGER NULL,
	[product_sk] INTEGER NULL,
	[quantity] INTEGER NOT NULL,
	[list_price] DECIMAL(10, 2) NOT NULL,
	[discount] DECIMAL(10, 2) NOT NULL,
	[order_status] TINYINT NOT NULL,
	[order_date] DATE NOT NULL,
	[required_date] DATE NOT NULL,
	[shipped_date] DATE NULL
);
GO
