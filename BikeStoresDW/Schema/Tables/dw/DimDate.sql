CREATE TABLE [dw].[DimDate]
(
	[date_key] INTEGER NOT NULL CONSTRAINT PK_DimDate PRIMARY KEY,
	[full_date] DATE NOT NULL,
	[day_number_of_week] TINYINT NOT NULL,
	[day_name_of_week] NVARCHAR(10) NOT NULL,
	[day_number_of_month] TINYINT NOT NULL,
	[day_number_of_year] SMALLINT NOT NULL,
	[week_number_of_year] TINYINT NOT NULL,
	[month_name] NVARCHAR(10) NOT NULL,
	[month_number_of_year] TINYINT NOT NULL,
	[calendar_quarter] TINYINT NOT NULL,
	[calendar_year] SMALLINT NOT NULL,
	[calendar_semester] TINYINT NOT NULL
);
GO