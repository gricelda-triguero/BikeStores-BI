CREATE TABLE [stg].[Staff]
(
	[staff_sk] INTEGER NOT NULL,
	[first_name] VARCHAR(50) NOT NULL,
	[last_name] VARCHAR(50) NOT NULL,
	[email] VARCHAR(255) NOT NULL,
	[phone] VARCHAR(25) NULL,
	[active] [TINYINT] NOT NULL,
	[manager_id] INTEGER NULL
);
GO
