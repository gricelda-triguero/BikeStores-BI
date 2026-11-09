CREATE TABLE [dw].[DimStaff]
(
	[staff_sk] INTEGER IDENTITY(1,1) NOT NULL CONSTRAINT PK_DimStaff PRIMARY KEY,
	[staff_id] INTEGER NOT NULL,
	[first_name] VARCHAR(50) NOT NULL,
	[last_name] VARCHAR(50) NOT NULL,
	[email] VARCHAR(255) NOT NULL,
	[phone] VARCHAR(25) NULL,
	[active] TINYINT NOT NULL,
	[manager_id] INTEGER NULL
);
GO
