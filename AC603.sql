-- Jonathan Villlaba Moran 1ºK

--  Sobre la base de datos empresa, realiza las siguientes consultas:

-- Lista, para cada empleado, además de su nombre, en campos separados, el día, el mes y el año de cuando nació.
    SELECT nomEmp, DAY(FecNaEmp) as DIA, MONTH(FecNaEmp) as MES, YEAR (FecNaEmp) as AÑO from empleado;

-- Listado de empleados, con su nombre, fecha de nacimiento y edad.
    SELECT nomEmp as Nombre, FecNaEmp as Fecha_Nacimiento, ROUND(datediff(NOW(), FecNaEmp)/365) as Edad from empleado;

-- Para cada empleado, necesitamos su nombre, fecha de incorporación y días de vacaciones extra (por cada 4 años en la empresa, tiene un día extra)
    SELECT nomEmp as Nombre, FecInEmp as Fecha_Comienzo, ROUND(datediff(NOW(), FecInEmp)/365/4) as Dias_Extras from empleado; 

-- Crea un listado con el nombre de los departamentos, así como un nuevo código formado por el código del departamento, un número aleatorio de dos cifras y el código del centro.
    SELECT 

-- Listado del tipo de director, código, nombre y presupuesto de los departamentos ordenado por tipo de director (orden alfabético) y dentro de este criterio por presupuesto anual en orden ascendente.


-- Listado del nombre y salario de los empleados (con dos decimales y separadores de miles) ordenado por criterio descendente del salario.


-- Lista los tres departamentos ordenados por presupuesto anual y por el código del centro con menor presupuesto.
SELECT*from departamento order by preanu asc, codcen limit 3;

-- Recupera el empleado que más cobra.
SELECT*from empleado order by salemp desc limit 1;
