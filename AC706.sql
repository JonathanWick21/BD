-- Sobre la base de datos empresa realiza las siguientes consultas:

-- a. Departamentos con más de 3 empleados
    SELECT `CodDep`, COUNT(*) as NumEmp
    FROM empleado
    GROUP BY `CodDep`
    HAVING NumEmp > 3;

-- b. Centros con más de 3 empleados
    SELECT c.`CodCen`, COUNT(*) as NumEmp
    FROM centro c
    JOIN departamento d ON d.`CodCen` = c.`CodCen`
    JOIN empleado e ON e.`CodDep` = d.`CodDep`
    GROUP BY c.`CodCen`
    HAVING NumEmp > 3;

-- c. Departamentos cuyos empleados tiene más de 2 hijos de media.
    SELECT `CodDep`, AVG(`NumHi`) as media
    FROM empleado
    GROUP BY `CodDep`
    HAVING media > 2;


-- d. Habilidades asociadas a más de 3 empleados.
    SELECT `CodHab`, COUNT(`CodEmp`) as empleats
    FROM habemp
    GROUP BY `CodHab`
    HAVING COUNT(`CodEmp`) > 3;

-- e. Centros con antigüedad promedio de empleados mayor a 10 años
    SELECT c.`NomCen`, AVG(TIMESTAMPDIFF(YEAR, `FecInEmp`, CURDATE())) as Antigüedad
    FROM centro c
    JOIN departamento d ON c.`CodCen` = d.`CodCen`
    JOIN empleado e ON e.`CodDep` = d.`CodDep`
    GROUP BY `NomCen`
    HAVING AVG(TIMESTAMPDIFF(YEAR, `FecInEmp`, CURDATE())) > 10;

-- f. Centros con más de 3 empleados que lleven al menos 20 años en la empresa
    SELECT c.`NomCen`
    FROM centro c
    JOIN departamento d ON d.`CodCen` = c.`CodCen`
    JOIN empleado e ON e.`CodDep` = d.`CodDep`
    WHERE TRUNCATE(TIMESTAMPDIFF(YEAR, e.`FecInEmp`, CURDATE()), 0) >= 20
    GROUP BY `NomCen`
    HAVING COUNT(TRUNCATE(TIMESTAMPDIFF(YEAR, e.`FecInEmp`, CURDATE()), 0) >= 20) > 3;


-- g. Departamentos con salarios no uniformes (mínimo diferente del máximo)