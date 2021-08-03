--DROP DATABASE prueba;

--CREATE DATABASE prueba;
--\c prueba;

--\echo :AUTOCOMMIT
--\set AUTOCOMMIT off

\echo '1. Cargar el respaldo de la base de datos unidad2.sql.'

--psql -U postgres prueba < unidad2.sql

\echo '2. El cliente usuario01 ha realizado la siguiente compra:'

BEGIN TRANSACTION;

INSERT INTO compra (cliente_id,fecha,id) VALUES (1,'2021-08-03',33);
INSERT INTO detalle_compra (producto_id,compra_id,cantidad) VALUES (9,33,4);

UPDATE producto SET stock = stock - 5 WHERE id = 9;

ROLLBACK;

SELECT * FROM producto WHERE descripcion = 'producto9';

\echo '3. El cliente usuario02 ha realizado la siguiente compra:'

BEGIN TRANSACTION;

INSERT INTO compra(id, cliente_id, fecha) VALUES (34, 2,'2021-08-03');
INSERT INTO detalle_compra(producto_id, compra_id, cantidad) VALUES (1,34,3);
INSERT INTO detalle_compra(producto_id, compra_id, cantidad) VALUES(2,34,3);
INSERT INTO detalle_compra(producto_id, compra_id, cantidad) VALUES(8,34,3);

UPDATE producto SET stock = stock - 3 WHERE id = 1;
UPDATE producto SET stock = stock - 3 WHERE id = 2;
UPDATE producto SET stock = stock - 3 WHERE id = 8;

ROLLBACK;

SELECT * FROM producto WHERE descripcion in ('producto1','producto2','producto8');

\echo '4. Realizar las siguientes consultas:'

--a. Deshabilitar el AUTOCOMMIT

\set AUTOCOMMIT OFF


BEGIN TRANSACTION;

--b. Insertar un nuevo cliente

INSERT INTO cliente(id, nombre, email) VALUES (11,'usuario11','usuario11@gmail.com');

--c. Confirmar que fue agregado en la tabla cliente

SELECT * FROM cliente WHERE id = 11;

--d. Realizar un ROLLBACK

ROLLBACK;

--e. Confirmar que se restauró la información, sin considerar la inserción del punto b

SELECT * FROM cliente;

--f. Habilitar de nuevo el AUTOCOMMIT

\set AUTOCOMMIT