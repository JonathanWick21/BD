--Jonathan Villalba Moran 1ºK

--  Sobre la base de datos empresa, utilizando consultas agregadas, se pide:

-- a. Listar para cada departamento, su código, nombre, salario mínimo, máximo y medio.
    SELECT d.CodDep, d.NomDep, MIN(e.SalEmp), MAX(e.SalEmp), AVG(e.SalEmp) from departamento d
    JOIN empleado e ON e.CodDep = d.`CodDep`
    GROUP BY d.`CodDep`, d.`NomDep`;

-- b. Obtener, para cada empleado (mostrando su código y nombre), cuantas habilidades tiene.
    SELECT e.`NomEmp`, e.`CodEmp`, COUNT(h.`CodEmp`) from empleado e
    LEFT JOIN habemp h ON h.`CodEmp`= e.`CodEmp`
    GROUP BY e.`NomEmp`, e. `CodEmp`;

-- c. Obtener, para cada departamento (mostrando su código y nombre), la cantidad de habilidades que tienen sus empleados.
    SELECT d.`NomDep`, d.`CodDep`, COUNT(h.`CodEmp`)
    FROM departamento d 
    JOIN empleado e ON e.`CodDep` = d.`CodDep`
    LEFT JOIN habemp h ON h.`CodEmp` = e.`CodEmp`
    GROUP BY d.`CodDep`, d.`NomDep`;

-- d. Obtener, para cada centro (mostrando su código y nombre), la cantidad de habilidades que tienen sus empleados.
    SELECT c.`CodCen`, c.`NomCen`, COUNT(h.`CodEmp`) 
    FROM centro c
    JOIN departamento d ON d.`CodCen` = c.`CodCen`
    JOIN empleado e ON e.`CodDep` = d.`CodDep`
    LEFT JOIN habemp h ON h.`CodEmp` = e.`CodEmp`
    GROUP BY c.`CodCen`, c.`NomCen`;


-- e. Obtener, para cada departamento y centro (mostrando sus códigos y nombres), la cantidad de habilidades que tienen sus empleados, mostrando los datos acumulados.
    SELECT d.`CodDep`, d.`NomDep`, c.`CodCen`, c.`NomCen`, COUNT(h.`CodEmp`)
    FROM centro c
    JOIN departamento d ON d.`CodCen` = c.`CodCen`
    JOIN empleado e ON e.`CodDep` = d.`CodDep`
    LEFT JOIN habemp h ON h.`CodEmp` = e.`CodEmp`
    GROUP BY c.`CodCen`, c.`NomCen`, d.`CodDep`, d.`NomDep`
    WITH ROLLUP; 

-- f. Listar el salario medio por centro para aquellos departamentos con más de 25 millones de presupuesto. Indicar el nombre del centro. Ordenar de manera descendente por el salario medio.
    SELECT c.`NomCen`, AVG(e.SalEmp)
    FROM centro c
    JOIN departamento d ON d.`CodCen` = c.`CodCen`
    JOIN empleado e ON e.`CodDep` = d.`CodDep`
    WHERE d.`PreAnu` > 25000000
    GROUP BY c.`CodCen`
    ORDER BY `SalEmp` DESC;


-- g. Obtener para cada ciudad donde se sitúen los departamentos, el total de salario de sus empleados, mostrando también el total acumulado.
    SELECT c.`PobCen`, SUM(e.`SalEmp`)
    FROM centro c
    JOIN departamento d ON d.`CodCen` = c.`CodCen`
    JOIN empleado e ON e.`CodDep` = d.`CodDep`
    GROUP BY c.`PobCen`
    WITH ROLLUP;