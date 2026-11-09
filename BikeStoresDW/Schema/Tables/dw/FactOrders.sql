CREATE TABLE [dw].[FactOrders]
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
	[shipped_date] DATE NULL,
	
	PRIMARY KEY ([order_id], [item_id]),
	CONSTRAINT [FK_DimCustomer] FOREIGN KEY([customer_sk]) REFERENCES [dw].[DimCustomer] ([customer_sk]),
	CONSTRAINT [FK_DimProduct] FOREIGN KEY([product_sk]) REFERENCES [dw].[DimProduct] ([product_sk]),
	CONSTRAINT [FK_DimStaff] FOREIGN KEY([staff_sk]) REFERENCES [dw].[DimStaff] ([staff_sk]),
	CONSTRAINT [FK_DimStore] FOREIGN KEY([store_sk]) REFERENCES [dw].[DimStore] ([store_sk]),
	CONSTRAINT [FK_DimDate_OrderDate] FOREIGN KEY([order_date_key]) REFERENCES [dw].[DimDate] ([date_key]),
	CONSTRAINT [FK_DimDate_RequiredDate] FOREIGN KEY([required_date_key]) REFERENCES [dw].[DimDate] ([date_key]),
	CONSTRAINT [FK_DimDate_ShippedDate] FOREIGN KEY([shipped_date_key]) REFERENCES [dw].[DimDate] ([date_key])	
);
GO
