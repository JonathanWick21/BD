-- Jonathan Villalba Moran 1ºK

-- Siguiendo con la tabla alumnado, se pide:

-- a. Crea un procedimiento llamado ac1106insertarAlumno que reciba los cuatro datos como parámetros de entrada y los inserte en la tabla. El procedimiento devolverá como salida un parámetro llamado error que tendrá un valor igual a 0 si la operación se ha podido realizar con éxito o 1 en caso contrario. Deberá manejar los errores que puedan ocurrir cuando se intenta insertar una fila que contiene una clave primaria repetida.

DELIMITER //
CREATE OR REPLACE PROCEDURE ac1106insertarAlumno (_id int, nom VARCHAR(50), apellid VARCHAR(50), curs VARCHAR(50) , OUT error INT)
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = 1;

    SET error = 0;

    INSERT INTO alumnado (id, nombre, apellidos, curso) VALUES (_id, nom, apellid, curs);
    
END;
//
DELIMITER ;

CALL ac1106insertarAlumno (3, "Gol", "Del puto Huesca", "Marketing", @resultado);
select @resultado;
MariaDB [pruebas1]> select @resultado;
-- +------------+
-- | @resultado |
-- +------------+
-- |          1 |
-- +------------+

CALL ac1106insertarAlumno (6, "Gol", "Del Betis", "Marketing", @resultado);
select @resultado;

-- +------------+
-- | @resultado |
-- +------------+
-- |          0 |
-- +------------+



-- b.Escribe un procedimiento (ac1106nombreAlumnoIf) que muestre el nombre de un alumno dado su código. En caso de que no se encuentre, devolverá Alumn@ no encontrado.

-- Utiliza IF para contar si ha encontrado al alumno.
-- Crea un nuevo procedimiento (ac1106nombreAlumnoHandler) pero ahora utiliza un manejador de errores (sin usar IF)
-- Debes comprobar el error NOT FOUND.
-- La consulta debe guardar el resultado en una variable mediante SELECT … INTO.


DELIMITER //
CREATE PROCEDURE ac1106nombreAlumnoIf (_id int, OUT mensaje VARCHAR(30))
BEGIN
    IF (SELECT COUNT(*) FROM alumnado
    WHERE _id = id) != 1
    THEN
    SELECT nombre INTO mensaje FROM alumnado where _id = id;
    
    ELSE
    SET mensaje = "Alumn@ no encontrad@";
    END IF;
END;
//
DELIMITER ;

CALL ac1106nombreAlumnoIf(8, @mensaje);
SELECT @mensaje;

-- +----------+
-- | @mensaje |
-- +----------+
-- | NULL     |
-- +----------+



DELIMITER //
CREATE PROCEDURE ac1106nombreAlumnoHandler(_id int, OUT mensaje VARCHAR(30))
BEGIN
    DECLARE EXIT HANDLER FOR NOT FOUND 
        SET mensaje = "Alumn@ no encontrad@";

    SELECT nombre INTO mensaje FROM alumnado where _id = id;
END;
//
DELIMITER ;

CALL ac1106nombreAlumnoHandler(6, @mensaje);
SELECT @mensaje;
-- +----------+
-- | @mensaje |
-- +----------+
-- | Gol      |
-- +----------+



-- c. Crea un procedimiento llamado ac1106upsertAlumno a partir de ac1106insertarAlumno, pero en el caso de que el alumno ya exista, y gestionando la captura de SQLException, modificará los datos de dicho alumno con los datos recibidos como parámetros.

DELIMITER //
CREATE OR REPLACE PROCEDURE ac1106upsertAlumno (_id int, _nom VARCHAR(50), _apellido VARCHAR(50), _curso VARCHAR(50) , OUT error INT)

    DECLARE resultado;

    CALL ac1106nombreAlumnoHandler(_id @resultado)
    IF SELECT @resultado = "Alumn@ no encontrad@"
        THEN
        CALL ac1106insertarAlumno(_id int, _nom VARCHAR(50), _apellido VARCHAR(50), _curso VARCHAR(50));
    ELSE
        UPDATE alumnado
            SET nombre = _nom,
            SET apellidos = _apellido,
            SET curso = _curso
            WHERE id = _id;
    END IF;
END;
//
DELIMITER ;

