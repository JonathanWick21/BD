-- Jonathan Villalba Moran 1ºK

--A partir del siguiente fragmento de código que realiza transacciones,
--sin ejecutar el código, índica el resultado de las consultas realizadas en las líneas 11 y 20, justificando tu respuesta:

CREATE TABLE producto (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DOUBLE
);

INSERT INTO producto (id, nombre) VALUES (1, 'Primero');
INSERT INTO producto (id, nombre) VALUES (2, 'Segundo');
INSERT INTO producto (id, nombre) VALUES (3, 'Tercero');

SELECT * FROM producto;

START TRANSACTION;
INSERT INTO producto (id, nombre) VALUES (4, 'Cuarto');
SAVEPOINT sp1;
INSERT INTO producto (id, nombre) VALUES (5, 'Quinto');
INSERT INTO producto (id, nombre) VALUES (6, 'Sexto');
ROLLBACK TO sp1;

SELECT * FROM producto;


-- La línea 1 mostraria:
/*
1|Primero
2|Segundo
3|Tercero
*/

-- Como no ha empezado una transacción por lo que el autocommit esta en 1 por defecto

-- La línea 20 mostraria:
/*
1|Primero
2|Segundo
3|Tercero
4|Cuarto
*/

-- Ya que ha creado un savepoint despues de añadir el valor de Cuarto y al hacer rollback ha vuelto a el.

-- A continuación, indica las sentencias SQL necesarias para realizar las siguientes tareas dentro de una única operación:

-- Coloca un punto de guardado nombrado SP2
-- Inserta el producto 10 con nombre Deu y con 10€ de precio.
-- Inserta el producto 11 con nombre Onze y con 100€ de precio.
-- Coloca un punto de guardado nombrado SP3
-- Modifica el precio de Onze para que sea de 11€.
-- Cancela las operaciones posteriores a SP3 y muestra el resultado de la tabla producto.

START TRANSACTION
SAVEPOINT SP2;
INSERT INTO producto VALUES (10, "Deu", 10);
INSERT INTO producto VALUES (11, "Onze", 100);
SAVEPOINT SP3;
UPDATE producto SET precio = 11 WHERE id = 11;

ROLLBACK TO SP3;

