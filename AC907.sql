--Jonathan Villalba Moran 1ºK

--Abre dos sesiones contra el SGBD con dos usuarios distintos (por ejemplos, s8a y root) en dos terminales. Con uno de ellos, ejecuta las siguiente sentencias:

CREATE OR REPLACE TABLE departamento (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    jefe VARCHAR(100));

INSERT INTO departamento (id, nombre, jefe) VALUES (1, 'Contabilidad', "J1");
INSERT INTO departamento (id, nombre, jefe) VALUES (2, 'Marketing', "J1");
INSERT INTO departamento (id, nombre, jefe) VALUES (3, 'I+D', "J2");

-- A continuación, anota las sentencias necesarias para cada caso y adjunta capturas de pantalla de cada uno de los terminales de los usuarios:

-- a. Con el usuario indicado, realiza las siguientes tareas y contesta a las preguntas que se plantean:

    --I
    --usuario1
    START TRANSACTION;

    SELECT * FROM departamento;
    --II
    --usuario1
    UPDATE departamento SET jefe = "J2" WHERE nombre = "marketing";

    --III
    --usuario2
    select * from departamento;

    --IV
    --usuario2
    DELETE FROM departamento WHERE nombre = "marketing";


-- b. ¿Qué cambiaría si hubiéramos bloqueado la tabla con accesos de lectura?

    --I
    --usuario1
    START TRANSACTION;
    LOCK TABLE departamento as blockDepartamento READ;
    SELECT * FROM departamento as blockDepartamento;
    --II
    --usuario1
    UPDATE departamento as blockDepartamento SET jefe = "J2" WHERE nombre = "marketing";

    --III
    --usuario1
    UNLOCK TABLES;

-- c. ¿Y si la bloqueamos para accesos de escritura?

    --I
    START TRANSACTION;
    LOCK TABLE departamento as blockDep WRITE;
    SELECT * from departamento as blockDep;

    --II
    --usuario1 
    UPDATE departamento as blockDep SET jefe = "J2" WHERE nombre = "marketing";

