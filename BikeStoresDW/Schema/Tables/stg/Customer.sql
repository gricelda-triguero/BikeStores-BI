
CREATE TABLE [stg].[Customer]
(
	[customer_sk] INTEGER NOT NULL,
	[first_name] VARCHAR(255) NOT NULL,
	[last_name] VARCHAR(255) NOT NULL,
	[phone] VARCHAR(25) NULL,
	[email] VARCHAR(255) NOT NULL,
	[street] VARCHAR(255) NULL,
	[city] VARCHAR(50) NULL,
	[state] VARCHAR(25) NULL,
	[zip_code] VARCHAR(5) NULL
);
GO