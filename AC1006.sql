-- Jonathan Villalba Moran 1ºK

-- En la base de datos empresa, crea:

-- a. El procedimiento ac1006habilidad que reciba como entrada un código de habilidad y una descripción, y la inserte en la tabla habilidad
DELIMITER //
CREATE OR REPLACE PROCEDURE ac1006habilidad(in codHabilidad CHAR(5), descripcion VARCHAR(30))
BEGIN
    IF (SELECT COUNT(*) FROM habilidad h WHERE h.`CodHab` = codHabilidad) = 1 THEN
        UPDATE habilidad SET `DesHab` = descripcion
        WHERE `CodHab` = codHabilidad;
    ELSE
        INSERT INTO habilidad VALUES (codHabilidad, descripcion);
    END IF;
END
//
DELIMITER ;

CALL ac1006habilidad("Pepes", "Los pepes se aceleran");

-- b. El procedimiento ac1006habilidades que reciba como entrada un entero con una cantidad, he inserte tantas habilidades como el parámetro recibido, asignando como código BD-NNN y descripción Habilidad NNN, sustituyendo NNN por un número entero secuencial.

DELIMITER //
CREATE or REPLACE PROCEDURE ac1006habilidades(in _cantidad INT)
BEGIN
    DECLARE contador INT;
    set contador = 1;
    WHILE contador <= _cantidad DO
        INSERT INTO habilidad VALUES(CONCAT("BD", contador), CONCAT("Habilidad", contador));
        SET contador = contador + 1;
    END WHILE;
END;
//
DELIMITER ;

CALL ac1006habilidades(5);

-- +--------+----------------------+
-- | CodHab | DesHab               |
-- +--------+----------------------+
-- | BD1    | 1                    |
-- | BD2    | 2                    |
-- | BD3    | 3                    |
-- | BD4    | 4                    |
-- | BD5    | 5                    |
-- | FONTA  | Fontanería           |
-- | GEREN  | Gerencia             |
-- | GESCO  | Gestión Contable     |
-- | INFOR  | INFORMATICA          |
-- | pepes  | Los pepes se pelean  |
-- | MARKE  | Marketing            |
-- | MECAN  | Mecanografía         |
-- | RELPU  | Relaciones Públicas  |
-- | TELEF  | Telefonista          |
-- +--------+----------------------+

-- Me falto poner que habia que ppner habilidad nnn y puse solo nnn en el codigo esta corregido.


-- Si el parámetro es 3, insertará las habilidades BD-1, BD-2 y BD-3 y las descripciones Habilidad 1, Habilidad 2 y Habilidad 3.

-- c. El procedimiento ac1006habilidadesInicioFin que reciba como entrada un entero que indique el número de inicio y otro con el tope (o fin), e inserte habilidades cuyos valores vayan desde inicio hasta fin, con la misma nomenclatura que el apartado anterior.

DELIMITER //
CREATE OR REPLACE PROCEDURE ac1006habilidadesInicioFin(in _inicio INT,  in _fin INT)
BEGIN
    IF(_inicio < _fin) THEN
        WHILE _inicio <= _fin DO
            INSERT INTO habilidad VALUES(CONCAT("BD", _inicio), CONCAT("Habilidad", _inicio));
            SET _inicio = _inicio + 1;
        END WHILE;
    END IF;
END;
//
DELIMITER ;

CALL ac1006habilidadesInicioFin(6, 11);

-- +--------+----------------------+
-- | CodHab | DesHab               |
-- +--------+----------------------+
-- | BD1    | 1                    |
-- | BD2    | 2                    |
-- | BD3    | 3                    |
-- | BD4    | 4                    |
-- | BD5    | 5                    |
-- | FONTA  | Fontanería           |
-- | GEREN  | Gerencia             |
-- | GESCO  | Gestión Contable     |
-- | BD10   | Habilidad10          |
-- | BD11   | Habilidad11          |
-- | BD6    | Habilidad6           |
-- | BD7    | Habilidad7           |
-- | BD8    | Habilidad8           |
-- | BD9    | Habilidad9           |
-- | INFOR  | INFORMATICA          |
-- | pepes  | Los pepes se pelean  |
-- | MARKE  | Marketing            |
-- | MECAN  | Mecanografía         |
-- | RELPU  | Relaciones Públicas  |
-- | TELEF  | Telefonista          |
-- +--------+----------------------+

-- Debes pensar y argumentar qué sucede si cualquiera de los parámetros recibidos como entrada no contienen alguno de los valores esperados.
-- Además, no olvides adjuntar, para cada apartado, tanto las sentencias necesarias para su creación como para su prueba y una captura de pantalla con su ejecución.