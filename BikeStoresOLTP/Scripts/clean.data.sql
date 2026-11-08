-- Borrar primero las tablas "hijas" que tienen claves foráneas
DELETE FROM sales.order_items;
GO
DELETE FROM sales.orders;
GO
DELETE FROM production.stocks;
GO
DELETE FROM sales.staffs;
GO
-- Ahora podemos borrar las tablas "padre"
DELETE FROM sales.stores;
GO
DELETE FROM sales.customers;
GO
DELETE FROM production.products;
GO
DELETE FROM production.brands;
GO
DELETE FROM production.categories;
GO

-- Reiniciar los contadores de identidad
DBCC CHECKIDENT ('sales.orders', RESEED);
GO
DBCC CHECKIDENT ('sales.staffs', RESEED);
GO
DBCC CHECKIDENT ('sales.stores', RESEED);
GO
DBCC CHECKIDENT ('sales.customers', RESEED);
GO
DBCC CHECKIDENT ('production.brands', RESEED);
GO
DBCC CHECKIDENT ('production.categories', RESEED);
GO
DBCC CHECKIDENT ('production.products', RESEED);
GO