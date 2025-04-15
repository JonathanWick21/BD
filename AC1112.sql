-- Jonathan Villalba Moran 1ºK

-- Haciendo uso de cursores y la base de datos empresa, se pide:

-- Crea la tabla empleado_plus con los mismos datos que la tabla empleado (mediante CREATE TABLE .... AS SELECT ...)

CREATE TABLE empleado_plus AS SELECT * FROM empleado;

-- Sobre la nueva tabla empleado_plus, añade la columna HijMayor que permita almacenar el nombre del hijo mayor de cada empleado. Para ello, crea el procedimiento almacenado ac1112procHijos, y mediante un cursor, sobre los hijos mayores de cada empleado, modifique el campo del empleado y almacene su nombre.

ALTER TABLE empleado_plus ADD(
    HiMayor VARCHAR(50)
);

DELIMITER //
CREATE or REPLACE PROCEDURE ac1112porcHijos()
BEGIN
    DECLARE rowEmp ROW TYPE OF empleado_plus;
    DECLARE fin INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT * from empleado_plus;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;

    OPEN cur;

    WHILE not fin DO
    FETCH cur into rowEmp;

    IF rowEmp.numHi != 0 THEN
        UPDATE empleado_plus set HiMayor = (
            SELECT NomHi from hijo WHERE NumHij = 1 AND CodEmp = rowEmp.CodEmp
        )
        WHERE CodEmp = rowEmp.CodEmp;
    END IF;
    END WHILE;
END;
//
DELIMITER ;

CALL ac1112porcHijos();


-- Sobre la nueva tabla empleado_plus, añade la columna DescHabs que permita almacenar los códigos de las habilidades de dicho empleado separadas por comas. Es decir, para el empleado 1 deberá almacenar GEREN,RELPU. Si no tuviera ninguna habilidad, debe dejar el campo nulo. Crea el procedimiento almacenado ac1112procHabilidadesEmpleados que complete dicha columna.

