/*
Script de implementación para BikeStoresDW1

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BikeStoresDW1"
:setvar DefaultFilePrefix "BikeStoresDW1"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detectar el modo SQLCMD y deshabilitar la ejecución del script si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Creando [dw]...';


GO
CREATE SCHEMA [dw]
    AUTHORIZATION [dbo];


GO
PRINT N'Creando [stg]...';


GO
CREATE SCHEMA [stg]
    AUTHORIZATION [dbo];


GO
PRINT N'Creando [dw].[FactOrders]...';


GO
CREATE TABLE [dw].[FactOrders] (
    [order_id]          INT             NOT NULL,
    [item_id]           INT             NOT NULL,
    [order_date_key]    INT             NOT NULL,
    [required_date_key] INT             NOT NULL,
    [shipped_date_key]  INT             NOT NULL,
    [customer_sk]       INT             NULL,
    [staff_sk]          INT             NULL,
    [store_sk]          INT             NULL,
    [product_sk]        INT             NULL,
    [quantity]          INT             NOT NULL,
    [list_price]        DECIMAL (10, 2) NOT NULL,
    [discount]          DECIMAL (10, 2) NOT NULL,
    [order_status]      TINYINT         NOT NULL,
    [order_date]        DATE            NOT NULL,
    [required_date]     DATE            NOT NULL,
    [shipped_date]      DATE            NULL,
    PRIMARY KEY CLUSTERED ([order_id] ASC, [item_id] ASC)
);


GO
PRINT N'Creando [dw].[DimStore]...';


GO
CREATE TABLE [dw].[DimStore] (
    [store_sk]   INT           IDENTITY (1, 1) NOT NULL,
    [store_id]   INT           NOT NULL,
    [store_name] VARCHAR (255) NOT NULL,
    [phone]      VARCHAR (25)  NULL,
    [email]      VARCHAR (255) NULL,
    [street]     VARCHAR (255) NULL,
    [city]       VARCHAR (255) NULL,
    [state]      VARCHAR (10)  NULL,
    [zip_code]   VARCHAR (5)   NULL,
    CONSTRAINT [PK_DimStore] PRIMARY KEY CLUSTERED ([store_sk] ASC)
);


GO
PRINT N'Creando [dw].[DimStaff]...';


GO
CREATE TABLE [dw].[DimStaff] (
    [staff_sk]   INT           IDENTITY (1, 1) NOT NULL,
    [staff_id]   INT           NOT NULL,
    [first_name] VARCHAR (50)  NOT NULL,
    [last_name]  VARCHAR (50)  NOT NULL,
    [email]      VARCHAR (255) NOT NULL,
    [phone]      VARCHAR (25)  NULL,
    [active]     TINYINT       NOT NULL,
    [manager_id] INT           NULL,
    CONSTRAINT [PK_DimStaff] PRIMARY KEY CLUSTERED ([staff_sk] ASC)
);


GO
PRINT N'Creando [dw].[DimProduct]...';


GO
CREATE TABLE [dw].[DimProduct] (
    [product_sk]    INT             IDENTITY (1, 1) NOT NULL,
    [product_id]    INT             NOT NULL,
    [product_name]  VARCHAR (255)   NOT NULL,
    [brand_name]    VARCHAR (255)   NOT NULL,
    [category_name] VARCHAR (255)   NOT NULL,
    [model_year]    SMALLINT        NOT NULL,
    [list_price]    DECIMAL (10, 2) NOT NULL,
    CONSTRAINT [PK_DimProduct] PRIMARY KEY CLUSTERED ([product_sk] ASC)
);


GO
PRINT N'Creando [dw].[DimDate]...';


GO
CREATE TABLE [dw].[DimDate] (
    [date_key]             INT           NOT NULL,
    [full_date]            DATE          NOT NULL,
    [day_number_of_week]   TINYINT       NOT NULL,
    [day_name_of_week]     NVARCHAR (10) NOT NULL,
    [day_number_of_month]  TINYINT       NOT NULL,
    [day_number_of_year]   SMALLINT      NOT NULL,
    [week_number_of_year]  TINYINT       NOT NULL,
    [month_name]           NVARCHAR (10) NOT NULL,
    [month_number_of_year] TINYINT       NOT NULL,
    [calendar_quarter]     TINYINT       NOT NULL,
    [calendar_year]        SMALLINT      NOT NULL,
    [calendar_semester]    TINYINT       NOT NULL,
    CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED ([date_key] ASC)
);


GO
PRINT N'Creando [dw].[DimCustomer]...';


GO
CREATE TABLE [dw].[DimCustomer] (
    [customer_sk] INT           IDENTITY (1, 1) NOT NULL,
    [customer_id] INT           NOT NULL,
    [first_name]  VARCHAR (255) NOT NULL,
    [last_name]   VARCHAR (255) NOT NULL,
    [phone]       VARCHAR (25)  NULL,
    [email]       VARCHAR (255) NOT NULL,
    [street]      VARCHAR (255) NULL,
    [city]        VARCHAR (50)  NULL,
    [state]       VARCHAR (25)  NULL,
    [zip_code]    VARCHAR (5)   NULL,
    CONSTRAINT [PK_DimCustomer] PRIMARY KEY CLUSTERED ([customer_sk] ASC)
);


GO
PRINT N'Creando [stg].[Store]...';


GO
CREATE TABLE [stg].[Store] (
    [store_sk]   INT           NOT NULL,
    [store_name] VARCHAR (255) NOT NULL,
    [phone]      VARCHAR (25)  NULL,
    [email]      VARCHAR (255) NULL,
    [street]     VARCHAR (255) NULL,
    [city]       VARCHAR (255) NULL,
    [state]      VARCHAR (10)  NULL,
    [zip_code]   VARCHAR (5)   NULL
);


GO
PRINT N'Creando [stg].[Staff]...';


GO
CREATE TABLE [stg].[Staff] (
    [staff_sk]   INT           NOT NULL,
    [first_name] VARCHAR (50)  NOT NULL,
    [last_name]  VARCHAR (50)  NOT NULL,
    [email]      VARCHAR (255) NOT NULL,
    [phone]      VARCHAR (25)  NULL,
    [active]     TINYINT       NOT NULL,
    [manager_id] INT           NULL
);


GO
PRINT N'Creando [stg].[Product]...';


GO
CREATE TABLE [stg].[Product] (
    [product_sk]    INT             NOT NULL,
    [product_name]  VARCHAR (255)   NOT NULL,
    [brand_name]    VARCHAR (255)   NULL,
    [category_name] VARCHAR (255)   NULL,
    [model_year]    SMALLINT        NULL,
    [list_price]    DECIMAL (10, 2) NULL
);


GO
PRINT N'Creando [stg].[Orders]...';


GO
CREATE TABLE [stg].[Orders] (
    [order_id]          INT             NOT NULL,
    [item_id]           INT             NOT NULL,
    [order_date_key]    INT             NOT NULL,
    [required_date_key] INT             NOT NULL,
    [shipped_date_key]  INT             NOT NULL,
    [customer_sk]       INT             NULL,
    [staff_sk]          INT             NULL,
    [store_sk]          INT             NULL,
    [product_sk]        INT             NULL,
    [quantity]          INT             NOT NULL,
    [list_price]        DECIMAL (10, 2) NOT NULL,
    [discount]          DECIMAL (10, 2) NOT NULL,
    [order_status]      TINYINT         NOT NULL,
    [order_date]        DATE            NOT NULL,
    [required_date]     DATE            NOT NULL,
    [shipped_date]      DATE            NULL
);


GO
PRINT N'Creando [stg].[Customer]...';


GO
CREATE TABLE [stg].[Customer] (
    [customer_sk] INT           NOT NULL,
    [first_name]  VARCHAR (255) NOT NULL,
    [last_name]   VARCHAR (255) NOT NULL,
    [phone]       VARCHAR (25)  NULL,
    [email]       VARCHAR (255) NOT NULL,
    [street]      VARCHAR (255) NULL,
    [city]        VARCHAR (50)  NULL,
    [state]       VARCHAR (25)  NULL,
    [zip_code]    VARCHAR (5)   NULL
);


GO
PRINT N'Creando [dbo].[PackageConfig]...';


GO
CREATE TABLE [dbo].[PackageConfig] (
    [PackageID]      INT          IDENTITY (1, 1) NOT NULL,
    [TableName]      VARCHAR (50) NOT NULL,
    [LastRowVersion] BIGINT       NULL,
    CONSTRAINT [PK_PackageConfig] PRIMARY KEY CLUSTERED ([PackageID] ASC)
);


GO
PRINT N'Creando [dw].[FK_DimCustomer]...';


GO
ALTER TABLE [dw].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_DimCustomer] FOREIGN KEY ([customer_sk]) REFERENCES [dw].[DimCustomer] ([customer_sk]);


GO
PRINT N'Creando [dw].[FK_DimProduct]...';


GO
ALTER TABLE [dw].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_DimProduct] FOREIGN KEY ([product_sk]) REFERENCES [dw].[DimProduct] ([product_sk]);


GO
PRINT N'Creando [dw].[FK_DimStaff]...';


GO
ALTER TABLE [dw].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_DimStaff] FOREIGN KEY ([staff_sk]) REFERENCES [dw].[DimStaff] ([staff_sk]);


GO
PRINT N'Creando [dw].[FK_DimStore]...';


GO
ALTER TABLE [dw].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_DimStore] FOREIGN KEY ([store_sk]) REFERENCES [dw].[DimStore] ([store_sk]);


GO
PRINT N'Creando [dw].[FK_DimDate_OrderDate]...';


GO
ALTER TABLE [dw].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_DimDate_OrderDate] FOREIGN KEY ([order_date_key]) REFERENCES [dw].[DimDate] ([date_key]);


GO
PRINT N'Creando [dw].[FK_DimDate_RequiredDate]...';


GO
ALTER TABLE [dw].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_DimDate_RequiredDate] FOREIGN KEY ([required_date_key]) REFERENCES [dw].[DimDate] ([date_key]);


GO
PRINT N'Creando [dw].[FK_DimDate_ShippedDate]...';


GO
ALTER TABLE [dw].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_DimDate_ShippedDate] FOREIGN KEY ([shipped_date_key]) REFERENCES [dw].[DimDate] ([date_key]);


GO
PRINT N'Creando [dbo].[DW_MergeDimCustomer]...';


GO
CREATE PROCEDURE [dbo].[DW_MergeDimCustomer]
AS
BEGIN

	UPDATE dc
	SET [first_name] = sc.[first_name]
	   ,[last_name]  = sc.[last_name]
	   ,[phone]     = sc.[phone]
	   ,[email]     = sc.[email]
	   ,[street]    = sc.[street]
	   ,[city]      = sc.[city]
	   ,[state]     = sc.[state]
	   ,[zip_code]   = sc.[zip_code]
	FROM [dw].[DimCustomer]        dc
	INNER JOIN [stg].[Customer] sc ON (dc.[customer_sk]=sc.[customer_sk])
END
GO
PRINT N'Creando [dbo].[DW_MergeDimProduct]...';


GO
CREATE PROCEDURE [dbo].[DW_MergeDimProduct]
AS
BEGIN

	UPDATE dc
	SET [product_name]  = sc.[product_name]
	   ,[brand_name]    = sc.[brand_name]
	   ,[category_name] = sc.[category_name]
	   ,[model_year]    = sc.[model_year]
	   ,[list_price]    = sc.[list_price]
	FROM [dw].[DimProduct]         dc
	INNER JOIN [stg].[Product] sc ON (dc.[product_sk]=sc.[product_sk])
END
GO
PRINT N'Creando [dbo].[DW_MergeDimStaff]...';


GO

CREATE PROCEDURE [dbo].[DW_MergeDimStaff]
AS
BEGIN

	UPDATE ds
	SET [first_name] = sc.[first_name]
	   ,[last_name]  = sc.[last_name]
	   ,[email]     = sc.[email]
	   ,[phone]     = sc.[phone]
	   ,[active]    = sc.[active]
	   ,[manager_id] = sc.[manager_id]
	FROM [dw].[DimStaff]           ds
	INNER JOIN [stg].[Staff] sc ON (ds.[staff_sk] = sc.[staff_sk])
END
GO
PRINT N'Creando [dbo].[DW_MergeDimStore]...';


GO

CREATE PROCEDURE [dbo].[DW_MergeDimStore]
AS
BEGIN

	UPDATE dc
	SET [store_name] = sc.[store_name]
	   ,[phone]     = sc.[phone]
	   ,[email]     = sc.[email]
	   ,[street]    = sc.[street]
	   ,[city]      = sc.[city]
	   ,[state]     = sc.[state]
	   ,[zip_code]   = sc.[zip_code]
	FROM [dw].[DimStore]        dc
	INNER JOIN [stg].[Store] sc ON (dc.[store_sk]=sc.[store_sk])
END
GO
PRINT N'Creando [dbo].[DW_MergeFactOrders]...';


GO

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
PRINT N'Creando [dbo].[GetLastPackageRowVersion]...';


GO
CREATE PROCEDURE [dbo].[GetLastPackageRowVersion]
  (
	@tableName VARCHAR(50)
  )
  AS
  BEGIN
	SELECT LastRowVersion
	FROM [dbo].[PackageConfig]
	WHERE TableName = @tableName;
  END
GO
PRINT N'Creando [dbo].[UpdateLastPackageRowVersion]...';


GO

CREATE PROCEDURE [dbo].[UpdateLastPackageRowVersion]
  (
	@tableName VARCHAR(50)
	,@lastRowVersion BIGINT
  )
  AS
  BEGIN
	UPDATE [dbo].[PackageConfig]
	SET LastRowVersion = @lastRowVersion
	WHERE TableName = @tableName;
  END
GO
/*
Plantilla de script posterior a la implementación							
--------------------------------------------------------------------------------------
 Este archivo contiene instrucciones de SQL que se anexarán al script de compilación.		
 Use la sintaxis de SQLCMD para incluir un archivo en el script posterior a la implementación.			
 Ejemplo:      :r .\miArchivo.sql								
 Use la sintaxis de SQLCMD para hacer referencia a una variable en el script posterior a la implementación.		
 Ejemplo:      :setvar TableName miTabla							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
			  WHERE [TableName] = 'Customer')
 BEGIN
	INSERT [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES ('Customer', 0)
 END
GO
IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
			  WHERE [TableName] = 'Staff')
 BEGIN
	INSERT [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES ('Staff', 0)
 END
GO
IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
			  WHERE [TableName] = 'Store')
 BEGIN
  INSERT [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES ('Store', 0)
 END
GO
IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
			  WHERE [TableName] = 'Product')
 BEGIN
	INSERT [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES ('Product', 0)
 END
GO
IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
			  WHERE [TableName] = 'Orders')
 BEGIN
	INSERT [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES ('Orders', 0)
 END
GO
IF NOT EXISTS(SELECT TOP(1) 1
              FROM dw.DimDate)
 BEGIN
	BEGIN TRAN 
		DECLARE @startdate DATE = '2016-01-01',
				@enddate   DATE = '2019-01-01';
		DECLARE @datelist TABLE(full_date DATE);

	IF @startdate IS NULL
		BEGIN
			SELECT TOP 1 
				   @startdate = full_date
			FROM dw.DimDate 
			ORDER By date_key ASC;
		END

	WHILE (@startdate <= @enddate)
	BEGIN 
		INSERT INTO @datelist(full_date)
		SELECT @startdate

		SET @startdate = DATEADD(dd,1,@startdate);
	END

	 INSERT INTO dw.DimDate(date_key
							,full_date 
							,day_number_of_week 
							,day_name_of_week 
							,day_number_of_month 
							,day_number_of_year 
							,week_number_of_year 
							,month_name 
							,month_number_of_year 
							,calendar_quarter 
							,calendar_year 
							,calendar_semester)

	SELECT date_key           = CONVERT(INT,CONVERT(VARCHAR,dl.full_date,112))
		  ,full_date          = dl.full_date
		  ,day_number_of_week   = DATEPART(dw,dl.full_date)
		  ,day_name_of_week     = DATENAME(WEEKDAY,dl.full_date) 
		  ,day_number_of_month  = DATEPART(d,dl.full_date)
		  ,day_number_of_year   = DATEPART(dy,dl.full_date)
		  ,week_number_of_year  = DATEPART(wk, dl.full_date)
		  ,month_name       = DATENAME(MONTH,dl.full_date) 
		  ,month_number_of_year = MONTH(dl.full_date)
		  ,calendar_quarter   = DATEPART(qq, dl.full_date)
		  ,calendar_year      = YEAR(dl.full_date)
		  ,calendar_semester  = CASE DATEPART(qq, dl.full_date)
										WHEN 1 THEN 1
										WHEN 2 THEN 1
										WHEN 3 THEN 2
										WHEN 4 THEN 2
								  END
		FROM @datelist              dl 
		LEFT OUTER JOIN dw.DimDate dd ON (dl.full_date = dd.full_date)
		WHERE dd.full_date IS NULL;
	COMMIT TRAN
END
GO
IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dw].[DimDate]
			  WHERE [date_key] = 0)
BEGIN

    INSERT INTO [dw].[DimDate]
               ([date_key]
               ,[full_date]
               ,[day_number_of_week]
               ,[day_name_of_week]
               ,[day_number_of_month]
               ,[day_number_of_year]
               ,[week_number_of_year]
               ,[month_name]
               ,[month_number_of_year]
               ,[calendar_quarter]
               ,[calendar_year]
               ,[calendar_semester])
         VALUES
               (0
               ,GETDATE()
               ,0
               ,''
               ,0
               ,0
               ,1
               ,''
               ,0
               ,0
               ,0
               ,0);
END
GO

GO
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dw].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_DimCustomer];

ALTER TABLE [dw].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_DimProduct];

ALTER TABLE [dw].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_DimStaff];

ALTER TABLE [dw].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_DimStore];

ALTER TABLE [dw].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_DimDate_OrderDate];

ALTER TABLE [dw].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_DimDate_RequiredDate];

ALTER TABLE [dw].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_DimDate_ShippedDate];


GO
PRINT N'Actualización completada.';


GO
