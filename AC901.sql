--Jonathan Villalba Moran 1ºK

-- AC901. (RABD.2 // CE2g, CE2h // 3p) Sobre la instalación de MariaDB que utilizas normalmente, realiza las siguientes operaciones, indicando los comandos necesarios y adjuntando capturas de pantalla de los resultados obtenidos:

-- Comprueba los usuarios existentes en nuestro SGBD.

select host, user, password from mysql.user;


-- Crea un usuario ac901local con contraseña s8a que sólo pueda conectarse desde localhost. Comprueba que puedes acceder con el nuevo usuario.

CREATE USER ac901local@localhost IDENTIFIED BY 's8a';

-- Crea un usuario ac901remoto con contraseñas8a que pueda conectarse desde cualquier lugar. Comprueba que puedes acceder con el nuevo usuario.

CREATE USER ac901remoto IDENTIFIED BY 's8a';

-- Modifica la contraseña del usuario ac901remoto para que sea severo. Comprueba que puedes acceder con la nueva contraseña.

ALTER USER ac901remoto IDENTIFIED BY 'severo';

-- Vuelve a comprobar los usuarios existentes en nuestro SGBD.

select host, user, password from mysql.user;


-- Elimina el usuario ac901remoto.

DROP USER ac901remoto;