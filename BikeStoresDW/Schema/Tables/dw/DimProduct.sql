CREATE TABLE [dw].[DimProduct]
(
	[product_sk] INTEGER IDENTITY(1,1) NOT NULL CONSTRAINT PK_DimProduct PRIMARY KEY,
	[product_id] INTEGER NOT NULL,
	[product_name] VARCHAR(255) NOT NULL,
	[brand_name] VARCHAR(255) NOT NULL,
	[category_name] VARCHAR(255) NOT NULL,
	[model_year] SMALLINT NOT NULL,
	[list_price] DECIMAL(10, 2) NOT NULL
);
GO

