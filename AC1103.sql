--Jonathan Villalba Moran 1ºK


-- Utilizando la tabla alumnado y las funciones y procedimientos creados en la actividad AC1010 de la unidad anterior, se pide:

-- Crea un trigger (ac1103triggerCrearEmailBeforeInsert) sobre la tabla alumnado, para que si el email a insertar es nulo, le asigne uno automáticamente. Debes utilizar la función crearEmail con el dominio noemail.com.

DELIMITER //

CREATE Trigger ac1103triggerCrearEmailBeforeInsert
BEFORE INSERT ON alumnado FOR EACH ROW
BEGIN
    

-- Crea un trigger (ac1103triggerGuardarEmailAfterUpdate) sobre la tabla alumnado, para que cada vez que se modifica el email, inserte un nuevo registro en la tabla logCambiosEmail, cuyos campos son:

-- id: clave primaria (entero autonumérico)
-- idAlumno: id del alumno (entero)
-- fechaHora: marca de tiempo con el instante del cambio (fecha y hora)
-- oldEmail: valor anterior del email (cadena de caracteres)
-- newEmail: nuevo valor con el que se ha actualizado
-- Además de código de los disparadores, se deben adjuntar algunas sentencias SQL para comprobar que funcionan correctamente, mostrando el contenido de las tablas antes y después de las operaciones.