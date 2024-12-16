-- Lista el nombre de todos los departamentos que hay en la tabla departamento.
    SELECT codDep FROM departamento;


-- Lista los nombres y los presupuestos de todos los departamentos.
    SELECT NomDep, PreAnu from departamento;

-- Lista todas las columnas de la tabla departamento.
    SELECT count(*) FROM departamento;

-- Lista el nombre de los empleados junto con su salario.
    SELECT nomEmp, salEmp from empleado;

-- Recupera todas las posibilidades de número de hijos que tienen los empleados (debes recuperar 0, 1 y 2).
    SELECT DISTINCT NumHi from empleado;

-- Lista el nombre y el complemento familiar (= salario * nº hijos * 4 /100) de todos los empleados.
    SELECT nomEmp, salEmp*NumHi*4/100 as ComplementoFamiliar from empleado;

-- Lista el nombre de los departamentos, el precio en euros y el precio en dólares estadounidenses (USD).
    SELECT NomDep, PreAnu as PreuEuro, PreAnu*1.05 as PreuDolar from departamento;

-- A partir de la consulta anterior, utiliza los siguientes alias para las columnas: nombre de departamento, euros, dólares.
    SELECT NomDep as NombreDeDepartamento, PreAnu as PreuEuro, PreAnu*1.05 as PreuDolar from departamento;