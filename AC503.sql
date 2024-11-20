create table FABRICANTE(
    codFabricante INT AUTO_INCREMENT,
    nombre VARCHAR(32) NOT NULL,
    pais VARCHAR(32),
    PRIMARY KEY(codFabricante)
);


create table ARTICULO(
    codigo CHAR(32),
    codFabricante INT,
    peso decimal(,2),
    categoria VARCHAR(16) CHECK ("primera"||"segunda"||"tercera"),
    precioVenta decimal(,2),
    precioCompra decimal(,2),
    existencias INT UNSIGNED,
    PRIMARY KEY(codigo,codFabricante,peso,categoria)
)
