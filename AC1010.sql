-- Jonathan Villalba Moran 1ºK

-- En la base de datos pruebas, crea la tabla alumnado con las siguientes columnas:

-- id: entero sin signo (clave primaria).
-- nombre: cadena de 50 caracteres.
-- apellidos: cadena de 50 caracteres.
-- curso: cadena de 50 caracteres;
-- E inserta 5 registros con datos inventados.
CREATE TABLE alumnado (
    id INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    curso VARCHAR(50),
    CONSTRAINT PK_ALU PRIMARY KEY (id)
);

INSERT INTO alumnado (nombre, apellidos, curso) VALUES 
    ("Emilio", "Garcia", "1ºk DAM"),
    ("Sergio", "Llorente", "1ºK DAM"),
    ("Pablo", "Morillas", "1ºK DAM"),
    ("Jonathan", "Villalba Dios Destructor", "1ºK DAM"),
    ("Diego", "Valencia", "1ºK DAM");

    -- +----+----------+--------------------------+----------+
    -- | id | nombre   | apellidos                | curso    |
    -- +----+----------+--------------------------+----------+
    -- |  1 | Emilio   | Garcia                   | 1ºk DAM  |
    -- |  2 | Sergio   | Llorente                 | 1ºK DAM  |
    -- |  3 | Pablo    | Morillas                 | 1ºK DAM  |
    -- |  4 | Jonathan | Villalba Dios Destructor | 1ºK DAM  |
    -- |  5 | Diego    | Valencia                 | 1ºK DAM  |
    -- +----+----------+--------------------------+----------+

-- Crea una función (crearEmail) que a partir de un nombre, apellidos y curso, genere una dirección de email y la devuelva como salida. El formato del email de salida es el siguiente:

DELIMITER //
CREATE OR REPLACE FUNCTION crearEmail(_nombre varchar(50), _apellidos VARCHAR(50), _curso VARCHAR(50)) RETURNS VARCHAR(160)
begin
    declare email VARCHAR(160);
    set email = CONCAT(LOWER(LEFT(_nombre, 1)), LOWER(LEFT(_apellidos, 5)), LENGTH(_apellidos), "@", LOWER(_curso), "s8a.es");
    RETURN email;
END;
//
DELIMITER ;

SELECT crearEmail("Jonathan", "Villalba", "DAM");

-- +-------------------------------------------+
-- | crearEmail("Jonathan", "Villalba", "DAM") |
-- +-------------------------------------------+
-- | jvilla8@dams8a.es                         |
-- +-------------------------------------------+

-- El primer carácter del parámetro nombre (en minúsculas).
-- Los cinco primeros caracteres del parámetro apellidos (en minúsculas).
-- Un número con la longitud de los apellidos.
-- El carácter @.
-- El curso pasado como parámetro (en minúsculas).
-- y finalizar con s8a.es.
-- Por ejemplo, si invocamos a la función con crearEmail('Aitor', 'Medrano', 'BD') devolvería amedra8@bd.s8a.es.

-- Añade una columna email a la tabla alumnado. A continuación, crea un procedimiento (ac1010actualizarColumnaEmail) que permita crear un email para todo el alumnado que ya existe en la tabla alumnado, utilizando la función crearEmail.

ALTER TABLE alumnado
ADD COLUMN email VARCHAR(160);

DELIMITER //
CREATE OR REPLACE PROCEDURE ac1010actualizarColumnaEmail()
begin
    UPDATE alumnado set email = crearEmail(nombre, apellidos, curso);
END;
//
DELIMITER ;

CALL ac1010actualizarColumnaEmail();

-- +----+----------+--------------------------+----------+-------------------------+
-- | id | nombre   | apellidos                | curso    | email                   |
-- +----+----------+--------------------------+----------+-------------------------+
-- |  1 | Emilio   | Garcia                   | 1ºk DAM  | egarci6@1ºk dams8a.es   |
-- |  2 | Sergio   | Llorente                 | 1ºK DAM  | sllore8@1ºk dams8a.es   |
-- |  3 | Pablo    | Morillas                 | 1ºK DAM  | pmoril8@1ºk dams8a.es   |
-- |  4 | Jonathan | Villalba Dios Destructor | 1ºK DAM  | jvilla24@1ºk dams8a.es  |
-- |  5 | Diego    | Valencia                 | 1ºK DAM  | dvalen8@1ºk dams8a.es   |
-- +----+----------+--------------------------+----------+-------------------------+