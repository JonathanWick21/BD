-- Active: 1736359634384@@127.0.0.1@3306@empresa
--Jonathan Vilalba Moran 1ºK

-- AC902. (RABD.2 // CE2g, CE2h // 3p) Sobre la instalación de MariaDB que utilizas normalmente, realiza las siguientes operaciones, indicando los comandos necesarios y adjuntando capturas de pantalla de los resultados obtenidos:

-- a. Comprueba los permisos del usuario s8a.

    SHOW GRANTS FOR s8a@localhost;

-- b. Sobre el usuario ac901local:

--      i.Comprueba sus permisos

    SHOW GRANTS FOR CURRENT_USER;

--      ii. Asigna los permisos necesarios para que sólo pueda acceder a la tabla habilidad, pudiendo hacer consultas, inserciones y borrados, pero no modificaciones sobre los datos.

    GRANT SELECT, INSERT, DELETE ON habilidad TO ac901local@localhost;

--      iii. Comprueba de nuevo los permisos.

    SHOW GRANT FOR ac901local@localhost;

--      iv. Insertar una nueva habilidad.

INSERT INTO habilidad VALUES ('Dorm', 'Duerme que no veas');

--      v. Intenta modificar la nueva habilidad

UPDATE habilidad set `DesHab` = 'Duerme como nadie' WHERE `CodHab` = 'Dorm';

--      vi. Elimina la habilidad insertada.

DELETE FROM habilidad WHERE `CodHab` = 'Dorm';

-- c. Crea un nuevo usuario ac902lectura con contraseña s8a que únicamente pueda consultar todas las tablas de la base de datos empresa.

CREATE USER ac902lectura IDENTIFIED BY 's8a';

GRANT SELECT ON empresa.* TO ac902lectura;

-- d. Crea un nuevo usuario ac903todo con contraseña s8a pueda hacer de todo en el sistema, a modo de administrador del sistema.

CREATE USER ac903todo IDENTIFIED BY 's8a';

GRANT ALL PRIVILEGES ON *.* TO ac903todo WITH GRANT OPTION;


-- e. Entra al sistema como el usuario ac903todo, y elimina los usuarios ac901local y ac902lectura.

DROP USER 'ac901local'@'localhost', 'ac902lectura'@'localhost';

-- f. Recupera los usuarios existentes en el sistema.