-- Jonathan Villalba Moran 1ºK

-- Haciendo uso de cursores y la base de datos empresa, se pide:

-- Crea la tabla empleado_copia con la misma estructura que la tabla empleado (mediante CREATE TABLE .... LIKE ...).

CREATE OR REPLACE TABLE empleado_copia LIKE empleado;

-- Crea el procedimiento ac1111empleadosSinHijos, para que, utilizando cursores y recuperando todos los empleados en la consulta, recorra la tabla de empleados e inserte en empleado_copia aquellos empleados que no tiene hijos.

DELIMITER //
CREATE OR REPLACE PROCEDURE ac1111empleadosSinHijos()
BEGIN
    DECLARE rowEmp ROW TYPE OF empleado;
    DECLARE fin INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT * from empleado;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;
    
    OPEN cur;
    

    WHILE NOT fin DO
    FETCH cur INTO rowEmp;
    IF rowEmp.numHi = 0 THEN
        INSERT INTO empleado_copia VALUES (rowEmp.CodEmp, rowEmp.CodDep, rowEmp.ExTelEmp, rowEmp.FecInEmp. rowEmp.FecNaEmp, rowEmp.NifEmp, rowEmp.NomEmp, rowEmp.numHi, rowEmp.SalEmp);
    END IF
    END WHILE;
    CLOSE cur;
END;
//
DELIMITER ;


-- Crea el procedimiento ac1111empleadosNumHijos, para que, utilizando cursores, recorra la tabla de empleados e inserte en empleado_copia aquellos empleados que tienen la cantidad de hijos recibidos como un parámetro de entrada del procedimiento.

-- Además del código, se deben adjuntar algunas sentencias SQL para comprobar que funciona correctamente, mostrando el contenido de las tablas antes y después de las operaciones.


