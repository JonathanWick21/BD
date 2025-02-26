--Jonathan Villalba Moran 1ºK

--  En la base de datos empresa, crea:


-- a. El procedimiento ac1002listEmpleadosConHijos que muestre los empleados que tienen hijos.
DELIMITER //
CREATE PROCEDURE ac1002listEmpleadosConHijos()
BEGIN
    SELECT * FROM empleado e join hijo h on e.`CodDep` = h.`CodEmp`;
END
//
DELIMITER ;


-- b. El procedimiento ac1002contarEmpleados que muestre la cantidad de empleados.
DELIMITER //
CREATE PROCEDURE ac1002contarEmpleados()
BEGIN 
    SELECT COUNT(codEmp) as cantEmpleados FROM empleado;
END
//
DELIMITER ;

-- c. El procedimiento ac1002updSalarioEmpleados que incremente el salario de los empleados un 10%.

DELIMITER //
CREATE PROCEDURE ac1002updSalarioEmpleados()
BEGIN
    UPDATE empleado set `SalEmp` = (`SalEmp`*1.10);
END
//
DELIMITER ;

-- d. Recupera los procedimientos existentes.

SHOW PROCEDURE STATUS WHERE db = "empresa";


-- +---------+-----------------------------+-----------+---------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
-- | Db      | Name                        | Type      | Definer       | Modified            | Created             | Security_type | Comment | character_set_client | collation_connection | Database Collation |
-- +---------+-----------------------------+-----------+---------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
-- | empresa | ac1002contarEmpleados       | PROCEDURE | s8a@localhost | 2025-02-25 16:40:10 | 2025-02-25 16:40:10 | DEFINER       |         | utf8mb4              | utf8mb4_general_ci   | utf8_general_ci    |
-- | empresa | ac1002listEmpleadosConHijos | PROCEDURE | s8a@localhost | 2025-02-25 16:39:41 | 2025-02-25 16:39:41 | DEFINER       |         | utf8mb4              | utf8mb4_general_ci   | utf8_general_ci    |
-- | empresa | ac1002updSalarioEmpleados   | PROCEDURE | s8a@localhost | 2025-02-25 16:40:38 | 2025-02-25 16:40:38 | DEFINER       |         | utf8mb4              | utf8mb4_general_ci   | utf8_general_ci    |
-- +---------+-----------------------------+-----------+---------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+


-- e. Elimina el procedimiento ac10021updSalarioEmpleados.

DROP PROCEDURE ac1021updSalarioEmpleados;

-- Debes adjuntar, para cada apartado, tanto las sentencias necesarias para su creación como para su prueba y una captura de pantalla con su ejecución.