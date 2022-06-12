/*
  @author edgar.benedetto@unah.hn N.Cuenta 20171033802
  @date 26/03/2021
  @decription Proyecto BD II Secci�n 1400 I PAC 2021 
  @name_file SYSTEM.sql
  @version 1.0
  
    1. Creacipon del usuario BD_MANTENIMIENTO_PROYECTO para restaurar la base de datos
    2. Otorgar priviligeios del rol Administrador
    3. Restaurar la base de datos creando una nueva conexi�n
    4. Permitir seleccionar, insertar, eliminar y actualizar las tablas de la base de datos restaurada
*/


CREATE USER BD_MANTENIMIENTO_PROYECTO IDENTIFIED BY 123
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users;

GRANT ADMINISTRADORES TO BD_MANTENIMIENTO_PROYECTO;

GRANT SELECT,INSERT,UPDATE,DELETE ON BD_VENTAS_TAREA_N3.DEMO_CUSTOMERS TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_VENTAS_TAREA_N3.DEMO_ORDER_ITEMS TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_VENTAS_TAREA_N3.DEMO_ORDER TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_VENTAS_TAREA_N3.DEMO_PODUCT_INFO TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_VENTAS_TAREA_N3.DEMO_STATES TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_VENTAS_TAREA_N3.DEMO_USERS TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_VENTAS_TAREA_N3.DEPT TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_VENTAS_TAREA_N3.EMP TO ADMINISTRADORES;

/*
    1. Creacipon del usuario DW_MANTENIMIENTO_PROYECTO para crear la base de datos
    2. Otorgar priviligeios del rol Administrador
    3. Restaurar la base de datos creando una nueva conexi�n
    4. Permitir seleccionar, insertar, eliminar y actualizar las tablas de la base de datos restaurada
*/

CREATE USER DW_MANTENIMIENTO_PROYECTO IDENTIFIED BY 123
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users;

GRANT ADMINISTRADORES TO DW_MANTENIMIENTO_PROYECTO;

GRANT SELECT,INSERT,UPDATE,DELETE ON BD_VENTAS_TAREA_N3.DEMO_CUSTOMERS TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_VENTAS_TAREA_N3.DEMO_ORDER_ITEMS TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_VENTAS_TAREA_N3.DEMO_ORDER TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_VENTAS_TAREA_N3.DEMO_PODUCT_INFO TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_VENTAS_TAREA_N3.DEMO_STATES TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_VENTAS_TAREA_N3.DEMO_USERS TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_VENTAS_TAREA_N3.DEPT TO ADMINISTRADORES;
GRANT SELECT,INSERT,UPDATE,DELETE ON BD_VENTAS_TAREA_N3.EMP TO ADMINISTRADORES;

