
CREATE TABLE [stg].[Product]
(
	[product_sk] INTEGER NOT NULL,
	[product_name] VARCHAR(255) NOT NULL,
	[brand_name] VARCHAR(255) NULL,
	[category_name] VARCHAR(255) NULL,
	[model_year] SMALLINT NULL,
	[list_price] DECIMAL(10, 2) NULL
);
GO