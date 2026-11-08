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
:r .\clean.data.sql
:r .\brands.data.sql
:r .\categories.data.sql
:r .\products.data.sql
:r .\customers.data.sql
:r .\stores.data.sql
:r .\staffs.data.sql
:r .\stocks.data.sql
:r .\orders.data.sql
:r .\order_items.data.sql
