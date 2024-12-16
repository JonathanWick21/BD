-- Jonathan Villalba Moran 1ºK

-- Sobre la base de datos empresa, realiza las siguientes consultas:

-- Recupera el nombre del empleado, salario y número de hijos del empleado con código 1.
SELECT nomEmp as Nombre, salemp as Salario, numhi as Hijos from empleado where CodEmp in (1);

-- Listar sin repeticiones el código de todos los departamentos que tengan trabajadores incorporados antes del 1/1/92.
SELECT  DISTINCT CodEmp from empleado where FecInEmp < '1992/1/1';

-- Listar el nombre de los trabajadores que no tienen extensión telefónica.
SELECT nomEmp from empleado where ExTelEmp is null;

-- Listar el nombre y presupuesto de los departamentos no ubicados en los centros con código DIGE o FAZS.
SELECT nomDep, preanu from departamento where codcen not in ('DIGE', 'FAZS');

-- Listar el nombre y salario de los trabajadores que ganen menos de 2 o más de 5 millones de euros.
SELECT nomEmp, salemp from empleado where salemp > 5000000 or salemp < 2000000;

-- Listar el código y nombre de los empleados cuyo código sea distinto de 1, 4, 6, 8 y de 10.
SELECT CodEmp, nomEmp from empleado where CodEmp NOT in (1, 4, 6, 8, 10);

-- Listar el nombre y fecha de nacimiento de los hijos de empleado que tengan como parte de su nombre o apellidos la secuencia de letras León.
SELECT nomHi, FecNaHi from hijo where nomHi like '%leon%';

-- Listar el nombre y salario anual de los empleados que ganan menos de 4 millones pero que ingresaron en la empresa antes de 1985.
SELECT nomEmp, salemp from empleado where salemp <4000000 and YEAR(FecInEmp) < 1985;

-- Listar el nombre y NIF de los empleados que tienen un NIF con la letra D o V, y que:

-- a) Trabajan en los departamentos IN&DI o DIRGE y ganan más de 5 millones; o
-- b) Fueron contratados en 1994.

SELECT nomEmp, nifemp from empleado where (nifemp like '%D' or nifemp like '%V') 
and (CodEmp in ('DIRGE', 'IN&DI') OR YEAR(FecInEmp) < 1994);
