-- Active: 1736359634384@@127.0.0.1@3306@empresa
--Jonathan Villalba Moran 1ºK

-- Sobre la base de datos empresa, utilizando las funciones agregadas, necesitamos obtener:

-- a. La cantidad de empleados de la empresa que tienen 2 hijos.
    select count(*) from empleado where NumHi = 2;

-- b. Cuantos empleados no tiene extensión telefónica.
    select count(*) from empleado where ExTelEmp is null;

-- c. La edad media de los empleados.
    select truncate (avg(timestampdiff(year, FecNaEmp, curdate())),1) from empleado;

-- d. La edad media de los empleados que trabajan en un centro que esté en Murcia.
    select truncate (avg(timestampdiff(year, FecNaEmp, curdate())),1) from empleado e
    join departamento d on d.CodDep = e.CodDep
    join centro c on d.CodCen = c.CodCen where c.PobCen = "Murcia";

-- e. La suma de presupuesto para los departamentos que estén en Cartagena.
    select sum(d.PreAnu) from departamento d
    join centro c on c.CodCen = d.CodCen
    where c.PobCen = "Cartagena";

-- f. Cuantos empleados tienen habilidades.
    select count(distinct CodEmp) from habemp;

-- g. Cuantos empleados no tienen habilidades.
    select count(distinct e.CodEmp) from empleado e
    left join habemp h on e.`CodEmp` = h.`CodEmp`
    WHERE h.`CodEmp` IS NULL;