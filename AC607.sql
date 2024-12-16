--Jonathan Villalba Moran 1ºK

--Explica qué recuperan las siguientes consultas (en lenguaje natural, no leyendo la consulta):

--De todos los empleados que cobren mas de 2500000€ queremos saber su codigo de empleado y su salario.
SELECT CodEmp, ROUND(SalEmp, 2) FROM empleado WHERE SalEmp > 2500000;

--Haz una suma de todos los hijos que tienen en total todos nuestros empleados.
SELECT SUM(NumHij) FROM hijo;

--Haz una lista con todos las habilidades que estan relacionadas con la gestión indicando tambien su codigo.
SELECT CodHab, DesHab FROM habilidad WHERE LOWER(DesHab) LIKE '%gestión%';

--Queremos una media del salario de todos los empleados con al menos 1 hijo.
SELECT AVG(SalEmp) FROM empleado WHERE NumHi >= 1;

--Muestra el nombre y cuantos años llevan trabajando en la empresa los empleados que llevan mas de 25 años en la empresa.
SELECT NomEmp, TIMESTAMPDIFF(YEAR, FecInEmp, CURDATE()) FROM empleado WHERE TIMESTAMPDIFF(YEAR, FecInEmp, CURDATE()) > 25;

--Dame el codigo y el nombre del los centros dento de la poblacion de elche y ordenalos por nombre de mayor a menor
SELECT CodCen, NomCen FROM centro WHERE PobCen = "Elche" ORDER BY NomCen DESC;

--Queremos saber cuantos presupuestos anuales hay que sean mayores de 20000000€
SELECT COUNT(*) FROM departamento WHERE PreAnu > 20000000;

--Queremos saber el codigo, el numero de empelados y que muestre la extension telefonica si no el numero de hijos y en caso de no haber ninguna devolvera 0
SELECT CodEmp, NomEmp, COALESCE(ExTelEmp, NumHi, "0000") from empleado;

--Dame el codigo de habilidad, la descripcion y que tan larga es esta descripcion de las habilidades que su codigo comiences por A
SELECT CodHab, DesHab, CHAR_LENGTH(DesHab) FROM habilidad WHERE CodHab LIKE 'A%';