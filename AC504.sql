create table PRODUCTO504 (
    codigo CHAR(32),
    codFabricante INT,
    peso decimal (11,2),
    categoria ENUM ('primera', 'segunda', 'tercera'),
    precioVenta decimal(11,2) CHECK(precioVenta>0),
    precioCompra decimal(11,2) CHECK(precioCompra>0),
    existencias INT UNSIGNED,
    PRIMARY KEY(codigo, codFabricante, peso, categoria),
    CONSTRAINT FK_PRO_FAB FOREIGN KEY (codFabricante) REFERENCES FABRICANTE(codFabricante)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);

alter table PRODUCTO504 modify codFabricante CHECK (codFabricante NOT NULL);

alter table PRODUCTO504 modify peso decimal(11,2) CHECK(peso>=1.00);
