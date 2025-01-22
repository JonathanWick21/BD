-- Active: 1736359634384@@127.0.0.1@3306@empresa
-- Jonathan Villalba Moran 1ºK

-- Sobre la base de datos empresa, utilizando subconsultas, realiza las siguientes consultas:


-- a. Recupera el nombre y el salario de aquellos empleados que cobra más que el salario medio de los empleados del departamento PROZS.

    SELECT `NomEmp`, `SalEmp`
    FROM empleado
    WHERE `SalEmp` > (SELECT AVG(`SalEmp`) FROM empleado WHERE `CodDep` = "PROZS");

-- b. Recupera el nombre y el salario de aquellos empleados que cobra más que el salario medio de los empleados del departamento Investigación y Diseño.

    SELECT `NomEmp`, `SalEmp`
    FROM empleado e
    WHERE `SalEmp` > ( SELECT AVG(`SalEmp`)
    FROM empleado e
    JOIN departamento d ON d.`CodDep` = e.`CodDep`
    WHERE LOWER(d.`NomDep`) LIKE "%investigacion y diseño%"); 

-- c. Recupera el nombre y el salario de aquellos empleados que cobra más que el salario medio de los empleados de su departamento.

    SELECT e.`NomEmp`, e.`SalEmp`
    FROM empleado e
    WHERE `SalEmp` > (
        SELECT AVG(`SalEmp`) 
        FROM empleado
        WHERE `CodDep` = e.`CodDep`
    );


-- d. Recupera el nombre de los departamentos cuyo presupuesto anual sea superior al presupuesto medio de todos los departamentos.

    SELECT `NomDep`, `PreAnu`
    FROM departamento
    WHERE `PreAnu` > (
        SELECT AVG(`PreAnu`)
        FROM departamento
    );

-- e. Recupera el nombre de los departamentos cuyo presupuesto anual sea superior al presupuesto medio de todos los centros.

    SELECT nomdep from departamento WHERE `PreAnu` > (
        SELECT AVG(precen) FROM (
            SELECT c.coden, SUM(d.preanu) as precen
            from centro c JOIN departamento d ON d.`CodCen` = c.`CodCen`
            GROUP BY c.`CodCen`) centros
        );


-- f. Recupera las habilidades que no tienen empleados asignados (sin subconsultas).

    SELECT DISTINCT h.`DesHab`
    FROM habilidad h
    LEFT JOIN habemp he ON h.`CodHab` = he.`CodHab`
    WHERE he.`CodEmp` IS NULL;

-- g. Recupera las habilidades que no tienen empleados asignados (con subconsultas).

    SELECT `DesHab`
    FROM habilidad
    WHERE `CodHab` NOT IN (
        SELECT `CodHab`
        FROM habemp
    );

-- h. Recupera el nombre del empleado que más cobra (sin subconsultas).

    SELECT `NomEmp`, `SalEmp`
    FROM empleado
    ORDER BY `SalEmp` DESC
    LIMIT 1;

-- i. Recupera el nombre del empleado que más cobra (con subconsultas).

    SELECT `NomEmp`, `SalEmp`
    FROM empleado
    WHERE `SalEmp` = (
        SELECT MAX(`SalEmp`) FROM empleado
    );

-- j. Recupera el nombre del empleado que tiene el salario más alto, perteneciendo al departamento que tiene más empleados.

-- k. Recupera el código y el nombre del empleado que tiene el salario más alto, cuyo departamento pertenece al centro que tiene más empleados.

-- l. Recupera el nombre y la fecha de nacimiento del empleado más joven de entre aquellos que trabajan en el presupuesto que tiene mayor presupuesto anual.