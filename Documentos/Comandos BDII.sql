//**
  @author edgar.benedetto@unah.hn
  @date 23/03/2021
  @version 1.0
  
  Comandos Básicos de PL SQL | Clase BD II

*/

--- Crear usuario
CREATE USER BD_BICICLETAS IDENTIFIED BY 123
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users;


--- Crear roles
CREATE ROLE ADMINISTRADORES;

--- Dar privilegios al rol
GRANT CREATE SESSION, CREATE ANY TABLE, CREATE ANY PROCEDURE, ALTER ANY TABLE, ALTER ANY PROCEDURE, DROP ANY TABLE, DROP ANY PROCEDURE TO ADMINISTRADORES;

--- Dar privilegios del rol a los usuarios
GRANT ADMINISTRADORES TO BD_BICICLETAS;

--- Dar privilegios de seleccionar, insertar, actualizar y eliminar una tabla especifica 
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_CENSO.CAPITALES TO ADMINISTRADORES;