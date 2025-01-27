--Jonathan Villalba Moran 1ºK

-- Sobre la base de datos empresa, utilizando todo tipo de subconsultas, recupera:

-- a.Empleados que ganan más que algún empleado del departamento JEFZS

    SELECT NomEmp 
    FROM empleado
    WHERE `SalEmp` > ANY (SELECT `SalEmp` FROM empleado e WHERE `CodDep` = "JEFZS");


    WITH rankingEmpleados as (
        SELECT coddep, codemp, nomemp, salemp,
            RANK() OVER (PARTITION BY coddep ORDER BY salemp desc) as rankingSalario
            from empleado
    )
    SELECT * FROM `rankingEmpleados` WHERE rankingSalario = 1;
-- b.Empleados que ganan más que todos los empleados del departamento VENZS

    SELECT `NomEmp`
    FROM empleado
    WHERE `SalEmp` > ALL(
        SELECT `SalEmp` from empleado e WHERE `CodDep` = "VENZS"
    );

-- c.Centros que tienen al menos un departamento con presupuesto superior a 20.000.000 €



-- d.Departamentos que no tienen empleados (sin subconsultas)



-- e.Departamentos que no tienen empleados (usando NOT IN)



-- f.Departamentos que no tienen empleados (usando NOT EXISTS)



-- g.Centros donde todos los departamentos tienen un presupuesto superior a 20.000.000 €



-- h.Empleados que trabajan en el mismo departamento que algún empleado con salario mayor a 2.000.000 €



-- i.Ultimo empleado incorporado a la empresa (usando NOT EXISTS).



-- j.Departamentos cuyo presupuesto es mayor que el presupuesto de todos los centros.



-- k.Departamentos cuyo presupuesto es mayor que al menos un presupuesto de los centros.



-- l.Departamentos con más de un empleado que tienen presupuesto superior a algún centro.
    SELECT d.`CodDep`, d.`NomDep`, COUNT(e.`CodEmp`)
    FROM departamento d
    JOIN empleado e on d.`CodDep` = e.`CodDep`
    WHERE `PreAnu` > ANY(
        SELECT SUM(`PreAnu`) as TotalPr FROM departamento GROUP BY `CodCen`
    )GROUP BY d.`CodDep`
    HAVING COUNT (e.`CodEmp`) > 1;


-- m.Centros donde ningún departamento tiene presupuesto inferior a 1.000.000 €