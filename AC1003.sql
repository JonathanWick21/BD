-- Jonathan Villalba Moran 1ºK

-- En la base de datos empresa, crea:

-- a. El procedimiento ac1003listDepartamentos que liste los departamentos de una determinada oficina.
DELIMITER //
CREATE PROCEDURE ac1003listaDepartamentos(IN _nombreCentro VARCHAR(32))
BEGIN
    SELECT d.`CodDep`
    FROM centro c
    JOIN departamento d ON c.`CodCen` = d.`CodCen` 
    WHERE `NomCen` = _nombreCentro;
END
//
DELIMITER ;

CALL `ac1003listaDepartamentos`("Direccion General");

-- +--------+
-- | CodDep |
-- +--------+
-- | DIRGE  |
-- | IN&DI  |
-- +--------+


-- b. El procedimiento ac1003listDepartamentosPlus que liste los departamentos de una determinada oficina, y en el caso de recibir como argumento un valor nulo, devuelva todos los departamentos.

DELIMITER //
CREATE PROCEDURE ac1003listaDepartamentosPlus(IN _nomCentro VARCHAR(64))
BEGIN
    SELECT d.`CodDep`
    FROM centro c
    JOIN departamento d ON c.`CodCen` = d.`CodCen`
    WHERE d.`CodCen` = COALESCE(_nomCentro, d.`CodCen`);
END
//
DELIMITER ;

CALL ac1003listaDepartamentosPlus("FAZS");

-- +--------+
-- | CodDep |
-- +--------+
-- | JEFZS  |
-- | PROZS  |
-- +--------+

CALL ac1003listaDepartamentosPlus(NULL);

-- +--------+
-- | CodDep |
-- +--------+
-- | DIRGE  |
-- | IN&DI  |
-- | ADMZS  |
-- | VENZS  |
-- | JEFZS  |
-- | PROZS  |
-- +--------+


-- c. El procedimiento ac1003updSalarioEmpleadosParam que incremente el salario de los empleados una determinada cantidad a partir de un parámetro de entrada.

DELIMITER //
CREATE PROCEDURE ac1003SalarioEmpleadosParam(IN _incremento int)
BEGIN
    UPDATE empleado SET `SalEmp` = `SalEmp` + _incremento;
END
//
DELIMITER ;

CALL ac1003SalarioEmpleadosParam(1000);

--Select salemp from empleado;
-- +--------+--------+----------+------------+------------+-----------+-----------------------------+-------+------------+
-- | CodEmp | CodDep | ExTelEmp | FecInEmp   | FecNaEmp   | NifEmp    | NomEmp                      | NumHi | SalEmp     |
-- +--------+--------+----------+------------+------------+-----------+-----------------------------+-------+------------+
-- |      1 | DIRGE  | 1111     | 1972-07-01 | 1961-08-07 | 21451451V | Saladino Mandamás, Augusto  |     1 | 7201000.00 |
-- |      2 | IN&DI  | 2233     | 1991-06-14 | 1970-06-08 | 21231347K | Manrique Bacterio, Luisa    |     0 | 4501000.00 |
-- |      3 | VENZS  | 2133     | 1984-06-08 | 1965-12-07 | 23823930D | Monforte Cid, Roldán        |     1 | 5201000.00 |
-- |      4 | VENZS  | 3838     | 1990-08-09 | 1975-02-21 | 38293923L | Topaz Illán, Carlos         |     0 | 3201000.00 |
-- |      5 | ADMZS  | 1239     | 1976-08-07 | 1958-03-08 | 38223923T | Alada Veraz, Juana          |     1 | 6201000.00 |
-- |      6 | JEFZS  | 23838    | 1991-08-01 | 1969-06-03 | 26454122D | Gozque Altanero, Cándido    |     1 | 5001000.00 |
-- |      7 | PROZS  | NULL     | 1994-06-30 | 1975-08-07 | 47123132D | Forzado López, Galeote      |     0 | 1601000.00 |
-- |      8 | PROZS  | NULL     | 1994-08-15 | 1976-06-15 | 32132154H | Mascullas Alto, Eloísa      |     1 | 1601000.00 |
-- |      9 | PROZS  | 12124    | 1982-06-10 | 1968-07-19 | 11312121D | Mando Correa, Rosa          |     2 | 3101000.00 |
-- |     10 | PROZS  | NULL     | 1993-11-02 | 1975-01-07 | 32939393D | Mosc Amuerta, Mario         |     0 | 1301000.00 |
-- +--------+--------+----------+------------+------------+-----------+-----------------------------+-------+------------+



-- d. El procedimiento ac1003contarEmpleados que devuelva la cantidad de empleados en un parámetro de salida.


DELIMITER //
CREATE PROCEDURE ac1003contarEmpleados(out _cantidadEmpleados int)
BEGIN
    set _cantidadEmpleados = (SELECT COUNT(`CodEmp`) FROM empleado);
END
//
DELIMITER ;

CALL ac1003contarEmpleados(@canitdad);
SELECT @cantidad;
    
-- +-----------+
-- | @cantidad |
-- +-----------+
-- | NULL      |
-- +-----------+


-- e. El procedimiento ac1003contarEmpleadosDpto que devuelva la cantidad de empleados de un determinado departamento (introducido vía un parámetro de entrada) en un parámetro de salida.


-- f. El procedimiento ac1003sueldosSet que devuelva el sueldo menor, el mayor y el promedio de todos los empleados (usando SET).


-- g. El procedimiento ac1003sueldosSelectInto que devuelva el sueldo menor, el mayor y el promedio de todos los empleados (usando SELECT INTO).
