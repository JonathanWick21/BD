--Jonathan Villalba Moran 1ºK


-- Utilizando la tabla alumnado y las funciones y procedimientos creados en la actividad AC1010 de la unidad anterior, se pide:

-- Crea un trigger (ac1103triggerCrearEmailBeforeInsert) sobre la tabla alumnado, para que si el email a insertar es nulo, le asigne uno automáticamente. Debes utilizar la función crearEmail con el dominio noemail.com.

DELIMITER //

CREATE Trigger ac1103triggerCrearEmailBeforeInsert
BEFORE INSERT ON alumnado FOR EACH ROW
BEGIN
    IF NEW.email IS NULL THEN
        SET NEW.email = crearEmail(NEW.nombre, NEW.apellido, NEW.curso);
    END IF;
END;
//
DELIMITER ;

    

-- Crea un trigger (ac1103triggerGuardarEmailAfterUpdate) sobre la tabla alumnado, para que cada vez que se modifica el email, inserte un nuevo registro en la tabla logCambiosEmail, cuyos campos son:

-- id: clave primaria (entero autonumérico)
-- idAlumno: id del alumno (entero)
-- fechaHora: marca de tiempo con el instante del cambio (fecha y hora)
-- oldEmail: valor anterior del email (cadena de caracteres)
-- newEmail: nuevo valor con el que se ha actualizado
-- Además de código de los disparadores, se deben adjuntar algunas sentencias SQL para comprobar que funcionan correctamente, mostrando el contenido de las tablas antes y después de las operaciones.

CREATE OR REPLACE TABLE logCambiosEmail(
    id int UNSIGNED AUTO_INCREMENT,
    idAlumno INT UNSIGNED,
    fechaHora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    oldEmail VARCHAR(65),
    newEmail VARCHAR(65),
    CONSTRAINT PK_LOG_CAM_EMA PRIMARY KEY (id)
);

DELIMITER //
CREATE OR REPLACE TRIGGER ac1103triggerGuardarEmailAfterUpdate AFTER UPDATE
ON alumnado FOR EACH ROW
BEGIN
    INSERT INTO logCambiosEmail(idAlumno, oldEmail, newEmail) VALUES (new.id, old.email, new.email);
END;
//
DELIMITER ;