-- Jonathan Villalba Moran 1ºK

-- En la actividad AP1105 se planteaba actualizar la cantidad de hijos de un empleado mediante un disparador asociado a la inserción de un nuevo registro en la tabla hijo. Realmente, es mejor que ambas operaciones formen parte de una transacción y que se gestionen dentro de un procedimiento almacenado. Dicho esto, se pide:

-- a. Crea la función ap1110funcCompruebaHijo que valide que la cantidad de hijos almacenados en la tabla hijo concuerda con el atributo NumHi de la tabla empleado. En caso contrario, debe lanzar una señal con un mensaje adecuado.

DELIMITER //
CREATE OR REPLACE FUNCTION ap1110funcCompruebaHijo (_codigo int)
RETURNS INT
Begin

    DECLARE numTablaHijos INT;
    DECLARE numTablaEmpleados INT;

    SELECT SUM(NumHij) INTO numTablaHijos FROM hijo WHERE `CodEmp` = _codigo;
    SELECT NumHi INTO numTablaEmpleados FROM empleado WHERE `CodEmp` = _codigo;

    IF numTablaHijos != numTablaEmpleados THEN
        SIGNAL SQLSTATE '41001'
            SET MESSAGE_TEXT = "Valores dispares en las tablas";
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END;
//
DELIMITER ;    


-- b. Crea el procedimiento almacenado ap1110procInsertaHijo, que haciendo un buen uso de las transacciones y la gestiones de errores, y tras validar que los datos existen previamente, tanto inserte los datos en la tabla hijo como modifique la columna NumHi de la tabla empleado. En caso de error, debe lanzar una señal con un mensaje adecuado (o relanzar la existente, si fuera el caso).

DELIMITER //
CREATE PROCEDURE ap1110procInsertaHijo(_codigo int, _numHij int, _fecha date, _nomHi VARCHAR(40))
BEGIN
    DECLARE EXIT HANDLER FOR SQLSTATE '41001'
    BEGIN
        ROLLBACK;
    END;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;
            INSERT INTO hijo VALUES(_codigo, _numHij, _fecha, _nomHi);
            UPDATE empleado SET NumHi = NumHi + 1 
            WHERE CodEmp = _codigo;

            IF ap1110funcCompruebaHijo(_codigo) = 1 THEN
                SIGNAL SQLSTATE '41001'
                    SET MESSAGE_TEXT = "Error al insertar en la tabla hijos";
            END IF;
    COMMIT;
    END;
    //
    DELIMITER ;
                