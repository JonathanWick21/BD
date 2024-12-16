create table DEPARTAMENTO (
    codD INT AUTO_INCREMENT,
    nombre VARCHAR (32) NOT NULL,
    direcc VARCHAR (50),
     CONSTRAINT PK_DEP PRIMARY KEY(codD)
);

create table EMPLEADO (
    dni CHAR(9),
    nombrec VARCHAR(32) NOT NULL,
    salario decimal(10,2) DEFAULT '1000.00' NOT NULL CHECK(salario>=900.00) ,
    direcc VARCHAR(50),
    departamento INT NOT NULL,
    CONSTRAINT PK_EMP PRIMARY KEY(dni),
    CONSTRAINT UK_NOM UNIQUE(nombrec),
    CONSTRAINT FK_EMP_DEP FOREIGN KEY (departamento) REFERENCES DEPARTAMENTO(codD)
);

alter table EMPLEADO DROP departamento;
alter table EMPLEADO add departamento INT NOT NULL,
CONSTRAINT FK_EMP_DEP FOREIGN KEY (departamento) REFERENCES DEPARTAMENTO(codD)
ON UPDATE CASCADE
ON DELETE NO ACTION;
