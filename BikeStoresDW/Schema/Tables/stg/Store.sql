CREATE TABLE [stg].[Store]
(
	[store_sk] INTEGER NOT NULL,
	[store_name] VARCHAR(255) NOT NULL,
	[phone] VARCHAR(25) NULL,
	[email] VARCHAR(255) NULL,
	[street] VARCHAR(255) NULL,
	[city] VARCHAR(255) NULL,
	[state] VARCHAR(10) NULL,
	[zip_code] VARCHAR(5) NULL
);
GO
