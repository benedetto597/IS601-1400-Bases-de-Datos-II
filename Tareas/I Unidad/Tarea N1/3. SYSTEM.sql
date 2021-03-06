/*
  @author edgar.benedetto@unah.hn
  @date 16/02/2021
  @version 1.0
  
  Tarea N1 
  Docente: Emilson Omar Acosta
  Alumno: Edgar Josu? Benedetto Godoy
  Num. de cuenta: 20171033802
*/

--- Creacion del usuario
CREATE USER BD_EMPRESA IDENTIFIED BY 123
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users;

/*
--- Creacion del rol Administradores
CREATE ROLE ADMINISTRADORES;

GRANT CREATE SESSION, CREATE ANY TABLE, CREATE ANY PROCEDURE, ALTER ANY TABLE, ALTER ANY PROCEDURE, DROP ANY TABLE, DROP ANY PROCEDURE, CREATE ANY SEQUENCE, DROP ANY SEQUENCE TO ADMINISTRADORES;
*/

--- Permisos Grant para usuarios y tablas
GRANT ADMINISTRADORES TO BD_EMPRESA;
GRANT CREATE ANY SEQUENCE, DROP ANY SEQUENCE TO ADMINISTRADORES;
GRANT CREATE ANY PROCEDURE, DROP ANY PROCEDURE, ALTER ANY PROCEDURE TO ADMINISTRADORES;
GRANT CREATE ANY TRIGGER, DROP ANY TRIGGER, ALTER ANY TRIGGER TO ADMINISTRADORES;

GRANT SELECT,INSERT,UPDATE,DELETE ON BD_EMPRESA.COUNTRIES TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_EMPRESA.DEPARTMENTS TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_EMPRESA.EMPLOYEES TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_EMPRESA.JOB_GRADES TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_EMPRESA.JOB_HISTORY TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_EMPRESA.JOBS TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_EMPRESA.LOCATIONS TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_EMPRESA.REGIONS TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_EMPRESA.TABLA_TEST TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_EMPRESA.REGISTRO_LOG TO ADMINISTRADORES;
