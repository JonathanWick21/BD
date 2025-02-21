-- Jonathan Villalba Moran 1ºK

CREATE TABLE persona (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL    );

INSERT INTO persona (id, nombre) VALUES (1, 'Andreu');
INSERT INTO persona (id, nombre) VALUES (2, 'Marina');
INSERT INTO persona (id, nombre) VALUES (3, 'Guillem');

-- Usuario
-- Comienza una transacción
START TRANSACTION;
-- Modifica el nombre de Andreu por Andreu 4K.
UPDATE persona SET nombre = "Andreu 4K" WHERE nombre = "Andreu";

-- Consulta la tabla persona
SELECT * FROM persona;

--Usuario 2
--Consulta la tabla persona
SELECT * FROM persona;


--Usuario 2
-- Cambia el nivel de aislamiento a Lectura no confirmada. (solo para la siguiente transacción)
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-- Comienza una transacción	
START TRANSACTION;
-- Consulta la tabla persona
SELECT * FROM persona;
--Pregunta
-- ¿Qué datos aparecen y por qué?

--Usuario 1
-- Anula la sentencia realizada
ROLLBACK;
-- Consulta la tabla
SELECT * from persona; 

--Usuario 2
--Consulta la tabla persona
SELECT * from persona; 

--Pregunta
-- ¿Qué datos aparecen y por qué?