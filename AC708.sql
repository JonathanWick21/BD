--Jonathan Villalba Moran 1ºK

-- Sobre la base de datos empresa, y utilizando funciones ventana, realiza las siguientes consultas:

-- a. Edad de cada empleado en comparación con la media del centro
    SELECT `NomEmp`, d.`CodCen`, TIMESTAMPDIFF(YEAR, `FecNaEmp`, CURDATE()) as EdEmp,
        AVG(TIMESTAMPDIFF(YEAR, `FecNaEmp`, CURDATE())) OVER (PARTITION BY c.`CodCen`) as EdMedCen,
        TIMESTAMPDIFF(YEAR, e.`FecNaEmp`, CURDATE()) - AVG(TIMESTAMPDIFF(YEAR, e.`FecNaEmp`, CURDATE())) OVER (PARTITION BY c.`CodCen`) as Dif
    FROM empleado e
    JOIN departamento d ON d.`CodDep`= e.`CodDep`
    JOIN centro c ON c.`CodCen` = d.`CodCen`;

-- b. Empleados con salario mayor al promedio de su departamento


-- c. Máximo y mínimo salario por tipo de dirección del departamento


-- d. Diferencia entre salario de un empleado y el máximo de su departamento


-- e. Ordenación jerárquica: antigüedad en el puesto por centro


-- f. Comparación de fechas de incorporación: tiempo transcurrido entre empleados