--Jonathan Villalba Moran 1ºK

-- Sobre la base de datos empresa se pide crear las siguientes vistas (para los campos nuevos, se indica el nombre que debe tener):

-- a.empleado_anyos: Para cada empleado, mostrar, además de su código y nombre, su edad (EdadEmp) y los años de antigüedad en la empresa (AntEmp).
CREATE VIEW empleado_anyos AS
SELECT `CodEmp`, `NomEmp`, TRUNCATE(TIMESTAMPDIFF(YEAR, `FecNaEmp`, CURDATE()),0) as EdadEmp,
TRUNCATE(TIMESTAMPDIFF(YEAR, `FecInEmp`, CURDATE()), 0) as AntEmp
FROM empleado;

-- b. centro_presupuesto: Para cada centro, además de su código y nombre, mostrar su presupuesto anual (CenPreAnu), y el código (CodDir) y el nombre (NomDir) de su director.
CREATE VIEW centro_presupuesto AS
SELECT c.`CodCen`, c.`NomCen`, SUM(`PreAnu`) as CenPreAnu, c.`CodEmpDir` as CodDir, e.`NomEmp` as NomDir
FROM centro c
JOIN departamento d ON d.`CodCen` = c.`CodCen`
JOIN empleado e ON c.`CodEmpDir` = e.`CodEmp`
GROUP BY c.`CodCen`, c.`NomCen`, c.`CodEmpDir`, e.`NomEmp`;


--c. empleado_habilidades_total: Para cada empleado, además de su código y nombre, muestre una columna con el total de habilidades de dicho empleado (NumHab) (si no tiene habilidades, debe aparecer el empleado, pero con dicho valor a 0).
CREATE VIEW empleado_habilidades_total AS
SELECT e.`CodEmp`, e.`NomEmp`, COUNT(h.`CodHab`) as NumHab
FROM empleado e
LEFT JOIN habemp h ON h.`CodEmp` = e.`CodEmp`
GROUP BY e.`CodEmp`, e.`NomEmp`;


--d.  departamento_jerarquia: Para cada departamento, además del código y el nombre, muestre el código y el nombre de su departamento superior (NomDepSup) si lo tienen (deben aparecer todos los departamentos).
CREATE VIEW departamento_jerarquia AS
SELECT d.`CodDep`, d.`NomDep`, d1.`CodDep` as CodDepSup, d1.`NomDep` as NomDepSup
FROM departamento d
LEFT JOIN departamento d1 ON d.`CodDepDep` = d1.`CodDep`;


-- Utilizando las vistas creadas, se pide crear las siguientes consultas:

-- a. Muestra para cada centro, además del presupuesto, el nombre de su director, edad y años en la empresa.
SELECT cp.`NomCen`, cp.`CenPreAnu`, ea.`NomEmp`, ea.`EdadEmp`, ea.`AntEmp`
from centro_presupuesto cp
JOIN empleado_anyos ea ON cp.`CodDir` = ea.`CodEmp`;

-- b. Muestra para cada empleado, su código, nombre, cuantas habilidades tiene, y el nombre del departamento en el que trabaja y el nombre de su departamento superior.
SELECT
FROM 


-- c. Muestra para cada empleado, su código, nombre, cuantas habilidades tiene y una columna nivel que sea A si tiene 2 o más habilidades, B si tiene una habilidad y C si no tiene ninguna.



