-- Jonathan Villalba Moran 1ºK

--Sobre la base de datos empresa, y utilizando composiciones externas, realiza las siguientes consultas:

-- Muestra un listado de todas las habilidades, y si tienen, el código del empleado y el nivel de su habilidad.
select hab.Codhab, habe.NivHab
from habilidad hab LEFT JOIN habemp habe ON hab.Codhab = habe.Codhab;

-- Muestra un listado de las habilidades que no tiene ningún empleado.
select Codhab from habilidad except select Codhab from habemp;

-- Comprueba si los empleados que no tienen hijos (empleado.NumHi) coinciden con los empleados no tienen hijos relacionados (tabla hijo).
select e.codemp from empleado e join hijo h on e.codemp = h.codemp
where h.codemp is null;

-- Obtén el nombre del empleado y el nombre del hijo, si tuviese, para todos los empleados.
select e.nomemp, h.nomhi
from empleado e left join hijo h on e.codemp = h.codemp;

-- Mostrar un listado con todos los departamentos junto con los nombres de los departamentos de los cuales dependen (propiedad CodDepDep) (en el caso que dependan de alguno).
select d2.nomemp, d1 nomdep as nomdepdep
from departamento d2 left join departamento d1 on d2.CodDepDep = d1.codDep;

-- Devuelve un listado de los empleados que no son directivos (usando joins) de departamentos.
select e.codemp
from empleado e left join departamento on e.codemp = d.codempDir
where d.CodEmpdir is null;

-- Devuelve un listado de los empleados que no son directivos (usando joins) de ningún centro.
select e.codemp
from empleado e left join centro c on e.codcen = d.codcen
where d.codcen is null;

-- Comprueba si tenemos centros que no tengan ningún departamento asignado.
select c.codcen
from centro c left join on departamento d on c.codcen = d.codcen
where d.codcen is null;

-- Devuelve un listado de los empleados que no son directivos de ningún tipo.
select e.codemp
from empleado e left join departamento d on e.codemp = d.codempDir
where d.codempDir is null
intersect
select e.codemp
from empleado e left join centro c on e.codemp= c.codempDir
where c.CodEmpdir is null;