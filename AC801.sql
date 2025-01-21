-- Active: 1736359634384@@127.0.0.1@3306@empresa
-- Jonathan Villalba Moran 1ºK

-- Sobre la base de datos empresa, utilizando subconsultas, realiza las siguientes consultas:


-- a. Recupera el nombre y el salario de aquellos empleados que cobra más que el salario medio de los empleados del departamento PROZS.

    SELECT `NomEmp`, `SalEmp`
    FROM empleado
    WHERE `SalEmp` > (SELECT AVG(`SalEmp`) FROM empleado WHERE `CodDep` = "PROZS");

-- b. Recupera el nombre y el salario de aquellos empleados que cobra más que el salario medio de los empleados del departamento Investigación y Diseño.


-- c. Recupera el nombre y el salario de aquellos empleados que cobra más que el salario medio de los empleados de su departamento.




-- Recupera el nombre de los departamentos cuyo presupuesto anual sea superior al presupuesto medio de todos los departamentos.

-- Recupera el nombre de los departamentos cuyo presupuesto anual sea superior al presupuesto medio de todos los centros.

-- Recupera las habilidades que no tienen empleados asignados (sin subconsultas).

-- Recupera las habilidades que no tienen empleados asignados (con subconsultas).

-- Recupera el nombre del empleado que más cobra (sin subconsultas).

-- Recupera el nombre del empleado que más cobra (con subconsultas).

-- Recupera el nombre del empleado que tiene el salario más alto, perteneciendo al departamento que tiene más empleados.

-- Recupera el código y el nombre del empleado que tiene el salario más alto, cuyo departamento pertenece al centro que tiene más empleados.

-- Recupera el nombre y la fecha de nacimiento del empleado más joven de entre aquellos que trabajan en el presupuesto que tiene mayor presupuesto anual.