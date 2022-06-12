---Clase #3
CREATE USER BD_CENSO IDENTIFIED BY 123
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users;

GRANT ADMINISTRADORES TO BD_CENSO;

GRANT SELECT ON BD_CENSO.PAISES TO ADMINISTRADORES;
GRANT INSERT,UPDATE,DELETE ON BD_CENSO.PAISES TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_CENSO.CAPITALES TO ADMINISTRADORES;

SELECT *  FROM DBA_TAB_PRIVS WHERE GRANTEE = 'ADMINISTRADORES';

REVOKE CREATE ANY PROCEDURE, DROP ANY PROCEDURE, ALTER ANY PROCEDURE FROM ADMINISTRADORES;

REVOKE SELECT ON BD_CENSO.PAISES FROM ADMINISTRADORES;
