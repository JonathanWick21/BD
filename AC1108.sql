-- Jonathan Villalba Moran 

-- Sobre la base de datos empresa y haciendo uso de señales, se pide:

-- a. El procedimiento ac1108salariosHabilidad que reciba como argumento el nombre de un habilidad y muestre el total de los salarios de los empleados que tienen dicha habilidad. Si no hubiera ningún empleado, lanzará una señal con el mensaje "Para la habilidad XXXX no hay ningún empleado existente". Si la habilidad no existe, el mensaje será "La habilidad XXX no existe".

DELIMITER //
CREATE OR REPLACE PROCEDURE ac1108salariosHabilidad (_nomHab CHAR(5))
BEGIN
    DECLARE habilidad CHAR(5);
    DECLARE cantEmp INT;

    SELECT CodHab INTO habilidad FROM habilidad WHERE CodHab = _nomHab;
    SELECT COUNT(CodEmp) INTO cantEmp from habemp WHERE _nomHab = CodHab;

    IF (habilidad IS NULL) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = CONCAT("La habilidad ", _nomHab, " no existe"),
            MYSQL_ERRNO = 12345;
    
    ELSE IF (cantEmp < 1) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = CONCAT("Para la habilidad ", _nomHab, " no hay ningún empleado existente"),
            MYSQL_ERRNO = 54321;
    ELSE
        SELECT SUM(SalEmp) 
        FROM empleado e JOIN habemp h ON e.CodEmp = h.CodEmp
        WHERE CodHab = habilidad;
    END IF;
END;
//
DELIMITER ;



-- b. El trigger ac1108triggerHijoAfterInsert que tras insertar un hijo, compruebe que si el número de hijo es el mayor (de entre sus herman@s), tenga una fecha de nacimiento menor a la de sus herman@s. Si no fuera así, lanzará una señal con el mensaje "El hijo XXX debe ser menor que su hermano YYY".