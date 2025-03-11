--Jonathan Villalba Moran 1ºK

--  Utilizando las tablas, funciones y procedimiento de las actividades anteriores, se pide:

-- a. Crea un trigger (ac1104triggerGuardarAlumnosAfterDelete) sobre la tabla alumnado, para que cada vez que se elimine un alumno, inserte un nuevo registro en la tabla logAlumnosEliminados, cuyos campos son:

-- id: clave primaria (entero autonumérico)
-- idAlumno (entero)
-- fechaHora: marca de tiempo
-- nombre: nombre del alumno (cadena de caracteres)
-- apellido (cadena de caracteres)
-- email (cadena de caracteres)

CREATE OR REPLACE TABLE logAlumnosEliminados(
    id int UNSIGNED AUTO_INCREMENT,
    idAlumno INT UNSIGNED,
    fechaHora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nombre VARCHAR(65),
    apellido VARCHAR(65),
    email VARCHAR(65),
    CONSTRAINT PK_LOG_ALU_ELI PRIMARY KEY (id)
);

DELIMITER //
CREATE OR REPLACE TRIGGER ac1104triggerGuardarAlumnosAfterDelete AFTER DELETE
ON alumnado FOR EACH ROW
BEGIN
    INSERT INTO logAlumnosEliminados (idAlumno, nombre, apellido, email) VALUES (OLD.id, OLD.nombre, OLD.apellidos, OLD.email);
END;
//
DELIMITER ;


INSERT INTO alumnado (nombre, apellidos, curso, email) VALUES ("Amigo", "Amiguisimo", "Jardineria", "amigo@amigos.ami");


-- +----+----------+--------------------------+------------+-------------------------+
-- | id | nombre   | apellidos                | curso      | email                   |
-- +----+----------+--------------------------+------------+-------------------------+
-- |  1 | Emilio   | Garcia                   | 1ºk DAM    | egarci6@1ºk dams8a.es   |
-- |  2 | Sergio   | Llorente                 | 1ºK DAM    | sllore8@1ºk dams8a.es   |
-- |  3 | Pablo    | Morillas                 | 1ºK DAM    | pmoril8@1ºk dams8a.es   |
-- |  4 | Jonathan | Villalba Dios Destructor | 1ºK DAM    | jvilla24@1ºk dams8a.es  |
-- |  5 | Diego    | Valencia                 | 1ºK DAM    | dvalen8@1ºk dams8a.es   |
-- |  6 | Amigo    | Amiguisimo               | Jardineria | amigo@amigos.ami        |
-- +----+----------+--------------------------+------------+-------------------------+
DELETE FROM alumnado WHERE nombre = "Amigo";

-- +----+----------+---------------------+--------+------------+------------------+
-- | id | idAlumno | fechaHora           | nombre | apellido   | email            |
-- +----+----------+---------------------+--------+------------+------------------+
-- |  1 |        6 | 2025-03-11 16:47:13 | Amigo  | Amiguisimo | amigo@amigos.ami |
-- +----+----------+---------------------+--------+------------+------------------+


-- b. Crea un trigger (ac1104triggerMensajeAfterDelete) sobre la tabla alumnado y que se ejecute tras ac1104triggerGuardarAlumnosAfterDelete, para que cada vez que se elimine un alumno, muestre por pantalla información del alumno eliminado, con un mensaje similar a "Se ha eliminado al alumno XXX con email YYY a las ZZ:ZZ", a partir de la información almacenada en la tabla logAlumnosEliminados.

CREATE OR REPLACE TABLE mensajes (
    id INT UNSIGNED AUTO_INCREMENT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    texto VARCHAR(120),
    CONSTRAINT PK_MENS PRIMARY KEY (id)
);

DELIMITER //
CREATE OR REPLACE TRIGGER ac1104triggerMensajeAfterDelete AFTER DELETE
ON alumnado FOR EACH ROW
    FOLLOWS ac1104triggerGuardarAlumnosAfterDelete
BEGIN
    INSERT INTO mensajes (texto) VALUES (
        CONCAT("Se ha eliminado al alumno ", OLD.nombre, " con email ", OLD.email, " a las ", CURRENT_TIME)
    );
END;
//
DELIMITER ;


-- +----+---------------------+---------------------------------------------------------------------------+
-- | id | fecha               | texto                                                                     |
-- +----+---------------------+---------------------------------------------------------------------------+
-- |  1 | 2025-03-11 16:47:13 | Se ha eliminado al alumno Amigo con email amigo@amigos.ami a las 16:47:13 |
-- +----+---------------------+---------------------------------------------------------------------------+



-- Además del código de los disparadores, se deben adjuntar algunas sentencias SQL para comprobar que funcionan correctamente, mostrando el contenido de las tablas antes y después de las operaciones.

