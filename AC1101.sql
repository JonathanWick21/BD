-- Jonathan Villalba Moran 1ºK

-- En la base de datos empresa, crea las siguientes tablas:

SET GLOBAL event_scheduler = ON;


-- estadisticas: tabla con estadísticas acumuladas
    -- id: entero autoincrementable (clave primaria).
    -- fecha: timestamp con la fecha actual.
    -- totalEmpleados: entero que almacena el total de empleado en la empresa
    -- ultimoMesEmpleados: entero que almacena los empleados dados de alta en el último mes;
    -- totalHabilidadEmp: entero que almacena el total de habilidades de los empleados en la empresa;

CREATE OR REPLACE TABLE estadisticas (
    id INT UNSIGNED AUTO_INCREMENT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    totalEmpleados int,
    ultimoMesEmpleados int,
    totalHabilidadEmp int,
    CONSTRAINT PK_EST PRIMARY KEY (id)
);

-- contador: tabla que contendrá sólo una fila
    -- id: entero autoincrementable (clave primaria).
    -- fecha: timestamp con la fecha actual.
    -- total: entero inicializado a 0, almacenará el total de ejecución de los eventos,
    -- mensual: entero inicializado a 0, almacenará el total de ejecución de los eventos durante el último mes.

CREATE OR REPLACE TABLE contador (
    id int UNSIGNED AUTO_INCREMENT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total INT DEFAULT 0,
    mensual INT DEFAULT 0,
    CONSTRAINT PK_CONT PRIMARY KEY (id)
);

-- Sobre estas tabla, se pide:

--Procedimiento para aligerar la carga
DELIMITER //
CREATE or REPLACE PROCEDURE actualizarDatos()
BEGIN
    INSERT INTO estadisticas (totalEmpleados, ultimoMesEmpleados, totalHabilidadesEmp) VALUES (
        (SELECT COUNT(`CodEmp`) from empleado),
        (SELECT COUNT(CodEmp) FROM empleado WHERE `FecInEmp` > (NOW() - INTERVAL 1 MONTH)),
        (SELECT COUNT(*) FROM habemp)
    );

    UPDATE contador set total = total + 1, mensual = mensual + 1;
END;
//
DELIMITER ;

-- a. Crea un evento (ac1101evento3min) que se ejecute dentro de tres minutos y que inserte en contador un registro con todos los valores a 0.

CREATE EVENT ac1001evento3min
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 3 MINUTE
DO
INSERT INTO contador VALUES ();


-- b. Crea un evento (ac1101evento5min) que se ejecute cada 5 minutos y que inserte en estadisticas un registro con los datos actualizados. Además, modificará la tabla contador incrementando en uno los valores de total y mensual.

CREATE EVENT ac1005evento5min
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 5 MINUTE
DO
CALL actualizarDatos();


-- c. Crea un evento (ac1101eventoDiarioLunes) que se ejecute de forma diaria, comenzando su ejecución el Lunes a las 8:00, insertando un nuevo registro en estadisticas. Además, modificará la tabla contador incrementando en uno los valores de total y mensual.




CREATE EVENT ac1101eventoDiarioLunes
ON SCHEDULE EVERY 1 DAY STARTS '2025-03-10 08:00:00'
DO
CALL actualizarDatos();


-- d. Crea un evento (ac1101eventoMensual) que se ejecute cada mes a partir del momento de su lanzamiento, eliminando las estadísticas que tienen más de un año y poniendo el valor del contador mensual a 0.
DELIMITER //

CREATE EVENT ac1001eventoMensual
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
    delete from estadisticas WHERE fecha < (NOW() - INTERVAL 1 YEAR);
    UPDATE contador SET mensual = 0;
END;
//
DELIMITER ;

-- e. Deshabilita el evento ac1101eventoDiarioLunes

ALTER EVENT ac1101eventoDiarioLunes DISABLE;

-- f. Además del código fuente de las sentencias, tras haberlos creado y lanzado, se pide comprobar qué eventos están pendientes de ejecutar. ¡No olvides habilitar el programador de eventos!

show events;

-- +---------+-------------------------+---------------+-----------+-----------+---------------------+----------------+----------------+---------------------+------+----------+------------+----------------------+----------------------+--------------------+
-- | Db      | Name                    | Definer       | Time zone | Type      | Execute at          | Interval value | Interval field | Starts              | Ends | Status   | Originator | character_set_client | collation_connection | Database Collation |
-- +---------+-------------------------+---------------+-----------+-----------+---------------------+----------------+----------------+---------------------+------+----------+------------+----------------------+----------------------+--------------------+
-- | empresa | ac1001evento3min        | s8a@localhost | SYSTEM    | ONE TIME  | 2025-03-07 16:59:49 | NULL           | NULL           | NULL                | NULL | ENABLED  |          1 | utf8mb4              | utf8mb4_general_ci   | utf8_general_ci    |
-- | empresa | ac1001eventoMensual     | s8a@localhost | SYSTEM    | RECURRING | NULL                | 1              | MONTH          | 2025-03-07 16:53:10 | NULL | ENABLED  |          1 | utf8mb4              | utf8mb4_general_ci   | utf8_general_ci    |
-- | empresa | ac1005evento5min        | s8a@localhost | SYSTEM    | ONE TIME  | 2025-03-07 17:01:58 | NULL           | NULL           | NULL                | NULL | ENABLED  |          1 | utf8mb4              | utf8mb4_general_ci   | utf8_general_ci    |
-- | empresa | ac1101eventoDiarioLunes | s8a@localhost | SYSTEM    | RECURRING | NULL                | 1              | DAY            | 2025-03-10 08:00:00 | NULL | DISABLED |          1 | utf8mb4              | utf8mb4_general_ci   | utf8_general_ci    |
-- +---------+-------------------------+---------------+-----------+-----------+---------------------+----------------+----------------+---------------------+------+----------+------------+----------------------+----------------------+--------------------+
