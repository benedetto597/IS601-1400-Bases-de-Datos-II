---Clase #3 
SELECT * FROM BD_CENSO.PAISES;

SELECT * FROM BD_CENSO.CAPITALES;

INSERT INTO BD_CENSO.CAPITALES VALUES (29, 'Distrito Central');

INSERT INTO BD_CENSO.PAISES VALUES (30, 'Honduras', 29);

DECLARE
  nombre_completo VARCHAR2(100):='Edgar Benedetto';
BEGIN
  DBMS_OUTPUT.PUT_LINE('El nombre de la persona es: ' ||nombre_completo );
END;

SET SERVEROUTPUT ON;