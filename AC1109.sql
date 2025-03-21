-- Jonathan Villalba Moran 1ºK

-- Crea la base de datos cine con las siguientes tablas:

CREATE DATABASE cine;
USE cine;

-- Tabla cuentas:
    -- idCuenta: entero sin signo (PK).
    -- saldo: real sin signo.

CREATE TABLE cuentas (
    idCuenta int UNSIGNED AUTO_INCREMENT,
    saldo float UNSIGNED,
    CONSTRAINT PK_CUENTAS PRIMARY KEY (idCuenta)
);

-- Tabla entradas:
    -- idButaca: entero sin signo (PK).
    -- nif: cadena de 9 caracteres.


CREATE TABLE entradas (
    idButaca INT UNSIGNED AUTO_INCREMENT,
    nif CHAR(9),
    CONSTRAINT PK_ENTRADAS PRIMARY KEY (idButaca)
);

-- Crear un procedimiento llamado ac1109comprarEntrada que reciba 3 parámetros de entrada (nif, idCuenta, idButaca) y devuelva como salida un parámetro llamado error que tendrá un valor igual a 0 si la operación se ha podido realizar con éxito o 1 en caso contrario.
DELIMITER //
CREATE PROCEDURE ac1109comprarEntrada (_nif CHAR(9), _idCuenta INT UNSIGNED, _idButcaca INT UNSIGNED, OUT error INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET error 1;
    END;
    START TRANSACTION;
        UPDATE cuentas SET saldo = saldo - 5 WHERE idCuenta = _idCuenta;
        INSERT INTO entradas VALUES (_idButaca, _nif);
        SET error = 0;
    COMMIT;    
END;
//
DELIMITER ;


-- Pasos del procedimiento de compra:

-- a. Inicia una transacción.
-- b. Actualiza cuentas.saldo cobrando 5 euros a la cuenta con el idCuenta adecuado.
-- c. Inserta una fila en la tabla entradas indicando la butaca (idButaca) que acaba de comprar el usuario (nif).
-- d. Comprueba si ha ocurrido algún error en las operaciones anteriores. Si todo va bien aplica un COMMIT a la transacción y si ha ocurrido algún error haz ROLLBACK.

-- Debe manejar los errores ERROR 1264 (Out of range value) y ERROR 1062 (Duplicate entry for PRIMARY KEY).

-- ¿Qué ocurre si se compra una entrada y le pasamos como parámetro un número de cuenta inexistente? ¿Ocurre algún error o podemos comprar la entrada? En caso de que exista algún error, ¿cómo podríamos resolverlo?.