--Jonathan Villalba Moran 1ºK

-- En la base de datos empresa, crea:


-- a. El procedimiento ac1005semanaIf que reciba como entrada un entero que represente un día de la semana y que devuelva una cadena con el nombre del día de la semana correspondiente (utilizando IF). Por ejemplo, para la entrada 1 debería devolver Lunes.
DELIMITER //
CREATE PROCEDURE ac1005semanaIf(dia int)
BEGIN
    DECLARE resultado varchar(10);
    IF dia = 1 THEN
        set resultado = "lunes";
    ELSEIF dia = 2 THEN
        SET resultado = "martes";
    ELSEIF dia = 3 THEN
        SET resultado = "miercoles";
    ELSEIF dia = 4 THEN
        set resultado = "jueves";
    ELSEIF dia = 5 THEN
        set resultado = "viernes";
    ELSEIF dia = 6 THEN
        set resultado = "sabado";
    ELSEIF dia = 7 THEN
        set resultado = "domingo";
    ELSE 
        set resultado = "Error";
    END IF;
    SELECT resultado;
    END
    //
    DELIMITER ;

    CALL ac1005semanaIf(4);

-- +-----------+
-- | resultado |
-- +-----------+
-- | jueves    |
-- +-----------+

-- b. El procedimiento ac1005semanaCase que reciba como entrada un entero que represente un día de la semana y que devuelva una cadena con el nombre del día de la semana correspondiente (utilizando CASE)
DELIMITER //
create PROCEDURE ac1005semanaCase(dia int)
BEGIN
    declare resultado VARCHAR(10);
    case dia
        WHEN 1 THEN
            set resultado = "Lunes";
        WHEN 2 THEN
            set resultado = "Martes";
        WHEN 3 THEN
            set resultado = "Miercoles";
        WHEN 4 THEN
            set resultado = "Jueves";
        WHEN 5 THEN
            set resultado = "Viernes";
        WHEN 6 THEN
            set resultado = "Sabado";
        ELSE
        set resultado = "Domingo";
        END CASE;
        SELECT resultado;
END
//
DELIMITER ;

CALL ac1005semanaCase(5);

-- +-----------+
-- | resultado |
-- +-----------+
-- | Viernes   |
-- +-----------+




-- c. El procedimiento ac1005semanaCasVal que reciba como entrada un entero que represente un día de la semana y una cadena con el idioma (los posibles valores son CAS o VAL) y que devuelva una cadena con el nombre del día de la semana correspondiente en el idioma indicado (puedes utilizar las sentencias condicionales que consideres). Por ejemplo, para 1 y CAS, devolverá Lunes, pero si es VAL devolverá Dilluns.

DELIMITER //
create PROCEDURE ac1005semanaCasVal(dia int, idioma char(3))
BEGIN
    declare resultado VARCHAR(10);
        IF idioma = "CAS" THEN
            CASE dia
                WHEN 1 THEN
                    set resultado = "Lunes";
                WHEN 2 THEN
                    set resultado = "Martes";
                WHEN 3 THEN
                    set resultado = "Miercoles";
                WHEN 4 THEN
                    set resultado = "Jueves";
                WHEN 5 THEN
                    set resultado = "Viernes";
                WHEN 6 THEN
                    set resultado = "Sabado";
                WHEN 7 THEN
                    set resultado = "Domingo";
                ELSE
                    set resultado = "Error";
                END CASE;
        ELSEIF idioma = "VAL" THEN
            CASE dia 
                WHEN 1 THEN
                    set resultado = "Dilluns";
                WHEN 2 THEN
                    set resultado = "Dimarts";
                WHEN 3 THEN
                    set resultado = "Dimecres";
                WHEN 4 THEN
                    set resultado = "Dijous";
                WHEN 5 THEN
                    set resultado = "Divendres";
                WHEN 6 THEN
                    set resultado = "Disabte";
                WHEN 7 THEN
                    set resultado = "Diumenje";
                ELSE
                    SET resultado = "Error";
                END CASE;
        ELSE
            SET resultado = "Error";
        END IF;
        SELECT resultado;
END
//
DELIMITER ;

CALL ac1005semanaCasVal(1, "VAL");

-- +-----------+
-- | resultado |
-- +-----------+
-- | Dilluns   |
-- +-----------+


CALL ac1005semanaCasVal(8, "CAS");

-- +-----------+
-- | resultado |
-- +-----------+
-- | Error     |
-- +-----------+


CALL ac1005semanaCasVal(5, "PEO");

-- +-----------+
-- | resultado |
-- +-----------+
-- | Error     |
-- +-----------+

-- Debes pensar y argumentar qué sucede si cualquiera de los parámetros recibidos como entrada no contienen alguno de los valores esperados.
-- A continuación, sobre la tabla habilidad, crea:

-- a. El procedimiento ac1005insertaHabilidad que reciba como entrada un código de habilidad y su descripción, y que sólo la inserte si el código de la habilidad tiene un tamaño de 5 caracteres.
DELIMITER //
create PROCEDURE ac1005insertaHabilidad(codHabilidad char(5), descripcion VARCHAR(30))
BEGIN
    IF LENGTH(codHabilidad) = 5 THEN
        INSERT INTO habilidad VALUES (codHabilidad, descripcion);
    END IF;
END
//
DELIMITER ;

CALL ac1005insertaHabilidad("pepes", "Comunicacion entre pepes");

SELECT * 
FROM habilidad
WHERE `CodHab` = "pepes";

-- +--------+--------------------------+
-- | CodHab | DesHab                   |
-- +--------+--------------------------+
-- | pepes  | Comunicacion entre pepes |
-- +--------+--------------------------+


-- b. El procedimiento ac1005upsertHabilidad que reciba como entrada un código de habilidad y su descripción, y que sólo la inserte si el código de la habilidad tiene un tamaño de 5 caracteres. Si el código ya existe, debe modificar la habilidad con la nueva descripción, y si no, la insertará.

DELIMITER //
create PROCEDURE ac1005upsertHabilidad(codHabilidad CHAR(5), descripcion VARCHAR(30))
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

CALL ac1005upsertHabilidad("pepes", "Los pepes se pelean");

SELECT * from habilidad WHERE `CodHab` = "pepes";

-- +--------+---------------------+
-- | CodHab | DesHab              |
-- +--------+---------------------+
-- | pepes  | Los pepes se pelean |
-- +--------+---------------------+

-- c. El procedimiento ac1005upsertHabilidadPlus que además de todo lo anterior, informe al usuario de la operación realizada. En el caso de que los datos de entrada sean incorrectos o incompletos, deberá también informar de ello.

DELIMITER //
create PROCEDURE ac1005upserHabilidadPlus(codigoHabilidad CHAR(5), descripcion VARCHAR(30))
BEGIN
    DECLARE operacion VARCHAR(32);
    IF (SELECT COUNT(*) FROM habilidad h WHERE h.`CodHab` = codHabilidad) = 1 THEN
        IF LENGTH(codHabilidad) = 5 THEN
            UPDATE habilidad SET `DesHab` = descripcion
            WHERE `CodHab` = codHabilidad;
            SET operacion = "Se ha cambiado la descripcion";
        ELSE
            SET operacion = "Error el codigo debe ser de 5";
        END IF;
    ELSE
        IF LENGTH(codHabilidad) = 5 THEN
        INSERT INTO habilidad VALUES (codHabilidad, descripcion);
            SET operacion = "Habilidad creada con exito";
        ELSE
            SET operacion = "Error el codigo debe ser de 5";
        END IF;
    END IF;
    SELECT operacion;
END
//
DELIMITER ;

CALL ac1005upserHabilidadPlus("pepes", "Los pepes se reconcilian");


-- Además, no olvides adjuntar, para cada apartado, tanto las sentencias necesarias para su creación como para su prueba y una captura de pantalla con su ejecución.