create table FABRICANTE(
    codFabricante INT AUTO_INCREMENT,
    nombre VARCHAR(32) NOT NULL,
    pais VARCHAR(32),
    PRIMARY KEY(codFabricante)
);


create table ARTICULO(
    codigo CHAR(32),
    codFabricante INT,
    peso decimal(11,2),
    categoria ENUM ('primera', 'segunda', 'tercera'),
    precioVenta decimal(11,2),
    precioCompra decimal(11,2),
    existencias INT UNSIGNED,
    PRIMARY KEY(codigo,codFabricante,peso,categoria)
);

alter table FABRICANTE modify pais VARCHAR(32) DEFAULT 'España';

alter table FABRICANTE add provincia VARCHAR(32) AFTER nombre;

rename table ARTICULO to PRODUCTO;






