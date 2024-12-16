INSERT INTO DEPARTAMENTO(nombre) VALUES ("Formación");

UPDATE DEPARTAMENTO SET nombre="Informatica" WHERE codD=3;

ALTER TABLE DEPARTAMENTO ADD email VARCHAR(32) AFTER direcc;

UPDATE DEPARTAMENTO SET email="email@ac510.com" WHERE email is NULL;

UPDATE EMPLEADO SET salario=salario + 300.00 WHERE departamento=3;

INSERT INTO EMPLEADO(dni, nombrec, salario, direcc, departamento) VALUES ("10101010E", "Jonathan Villalba", 50000, "Gran Via", 11);

UPDATE EMPLEADO SET departamento=11 WHERE dni="12345678A";

UPDATE DEPARTAMENTO SET codD=666 WHERE codD=11;
/**No va porque es una clave primaria**/

DELETE FROM DEPARTAMENTO WHERE codD=9;