CREATE TABLE "COUNTRIES" (
      "COUNTRY_ID" CHAR(2), 
      "COUNTRY_NAME" VARCHAR2(40), 
      "REGION_ID" NUMBER,  
      CONSTRAINT "COUNTRY_C_ID_PK" PRIMARY KEY ("COUNTRY_ID") ENABLE
  );

   --------------------------------------------------------
--  DDL for Table DEPARTMENTS
--------------------------------------------------------

  CREATE TABLE "DEPARTMENTS" (
      "DEPARTMENT_ID" NUMBER(4,0), 
      "DEPARTMENT_NAME" VARCHAR2(30), 
      "MANAGER_ID" NUMBER(6,0), 
      "LOCATION_ID" NUMBER(4,0)
  ) ;

   --------------------------------------------------------
--  DDL for Table EMPLOYEES
--------------------------------------------------------

  CREATE TABLE "EMPLOYEES" (
      "EMPLOYEE_ID" NUMBER(6,0), 
      "FIRST_NAME" VARCHAR2(20), 
      "LAST_NAME" VARCHAR2(25), 
      "EMAIL" VARCHAR2(25), 
      "PHONE_NUMBER" VARCHAR2(20), 
      "HIRE_DATE" DATE, 
      "JOB_ID" VARCHAR2(10), 
      "SALARY" NUMBER(8,2), 
      "COMMISSION_PCT" NUMBER(2,2),
      "MANAGER_ID" NUMBER(6,0), 
      "DEPARTMENT_ID" NUMBER(4,0)
  ) ;

   --------------------------------------------------------
--  DDL for Table JOBS
--------------------------------------------------------

  CREATE TABLE "JOBS" (
      "JOB_ID" VARCHAR2(10), 
      "JOB_TITLE" VARCHAR2(35), 
      "MIN_SALARY" NUMBER(6,0), 
      "MAX_SALARY" NUMBER(6,0)
  ) ;

  --------------------------------------------------------
--  DDL for Table JOB_GRADES
--------------------------------------------------------

  CREATE TABLE "JOB_GRADES" (
      "GRADE_LEVEL" VARCHAR2(3), 
      "LOWEST_SAL" NUMBER, 
      "HIGHEST_SAL" NUMBER
  );
--------------------------------------------------------
--  DDL for Table JOB_HISTORY
--------------------------------------------------------

  CREATE TABLE "JOB_HISTORY" (
      "EMPLOYEE_ID" NUMBER(6,0), 
      "START_DATE" DATE, 
      "END_DATE" DATE, 
      "JOB_ID" VARCHAR2(10), 
      "DEPARTMENT_ID" NUMBER(4,0)
  ) ;

   --------------------------------------------------------
--  DDL for Table LOCATIONS
--------------------------------------------------------

  CREATE TABLE "LOCATIONS" (
      "LOCATION_ID" NUMBER(4,0), 
      "STREET_ADDRESS" VARCHAR2(40), 
      "POSTAL_CODE" VARCHAR2(12), 
      "CITY" VARCHAR2(30), 
      "STATE_PROVINCE" VARCHAR2(25), 
      "COUNTRY_ID" CHAR(2)
  ) ;

   --------------------------------------------------------
--  DDL for Table REGIONS
--------------------------------------------------------

  CREATE TABLE "REGIONS" (
      "REGION_ID" NUMBER, 
      "REGION_NAME" VARCHAR2(25)
  ) ;


Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('CA','Canada',2);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('DE','Germany',1);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('UK','United Kingdom',1);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('US','United States of America',2);

Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (10,'Administration',200,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (20,'Marketing',201,1800);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (50,'Shipping',124,1500);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (60,'IT',103,1400);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (80,'Sales',149,2500);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (90,'Executive',100,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (110,'Accounting',205,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (190,'Contracting',null,1700);

Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (100,'Steven','King','SKING','515.123.4567',to_date('17-JUN-87','DD-MON-RR'),'AD_PRES',24000,null,null,90);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (101,'Neena','Kochhar','NKOCHHAR','515.123.4568',to_date('21-SEP-89','DD-MON-RR'),'AD_VP',17000,null,100,90);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (102,'Lex','De Haan','LDEHAAN','515.123.4569',to_date('13-JAN-93','DD-MON-RR'),'AD_VP',17000,null,100,90);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (103,'Alexander','Hunold','AHUNOLD','590.423.4567',to_date('03-JAN-90','DD-MON-RR'),'IT_PROG',9000,null,102,60);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (104,'Bruce','Ernst','BERNST','590.423.4568',to_date('21-MAY-91','DD-MON-RR'),'IT_PROG',6000,null,103,60);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (107,'Diana','Lorentz','DLORENTZ','590.423.5567',to_date('07-FEB-99','DD-MON-RR'),'IT_PROG',4200,null,103,60);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (124,'Kevin','Mourgos','KMOURGOS','650.123.5234',to_date('16-NOV-99','DD-MON-RR'),'ST_MAN',5800,null,100,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (141,'Trenna','Rajs','TRAJS','650.121.8009',to_date('17-OCT-95','DD-MON-RR'),'ST_CLERK',3500,null,124,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (142,'Curtis','Davies','CDAVIES','650.121.2994',to_date('29-JAN-97','DD-MON-RR'),'ST_CLERK',3100,null,124,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (143,'Randall','Matos','RMATOS','650.121.2874',to_date('15-MAR-98','DD-MON-RR'),'ST_CLERK',2600,null,124,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (144,'Peter','Vargas','PVARGAS','650.121.2004',to_date('09-JUL-98','DD-MON-RR'),'ST_CLERK',2500,null,124,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (149,'Eleni','Zlotkey','EZLOTKEY','011.44.1344.429018',to_date('29-JAN-00','DD-MON-RR'),'SA_MAN',10500,0.2,100,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (174,'Ellen','Abel','EABEL','011.44.1644.429267',to_date('11-MAY-96','DD-MON-RR'),'SA_REP',11000,0.3,149,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (176,'Jonathon','Taylor','JTAYLOR','011.44.1644.429265',to_date('24-MAR-98','DD-MON-RR'),'SA_REP',8600,0.2,149,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (178,'Kimberely','Grant','KGRANT','011.44.1644.429263',to_date('24-MAY-99','DD-MON-RR'),'SA_REP',7000,0.15,149,null);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (200,'Jennifer','Whalen','JWHALEN','515.123.4444',to_date('17-SEP-87','DD-MON-RR'),'AD_ASST',4400,null,101,10);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (201,'Michael','Hartstein','MHARTSTE','515.123.5555',to_date('17-FEB-96','DD-MON-RR'),'MK_MAN',13000,null,100,20);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (202,'Pat','Fay','PFAY','603.123.6666',to_date('17-AUG-97','DD-MON-RR'),'MK_REP',6000,null,201,20);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (205,'Shelley','Higgins','SHIGGINS','515.123.8080',to_date('07-JUN-94','DD-MON-RR'),'AC_MGR',12000,null,101,110);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (206,'William','Gietz','WGIETZ','515.123.8181',to_date('07-JUN-94','DD-MON-RR'),'AC_ACCOUNT',8300,null,205,110);

Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AD_PRES','President',20000,40000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AD_VP','Administration Vice President',15000,30000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AD_ASST','Administration Assistant',3000,6000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AC_MGR','Accounting Manager',8200,16000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AC_ACCOUNT','Public Accountant',4200,9000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('SA_MAN','Sales Manager',10000,20000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('SA_REP','Sales Representative',6000,12000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('ST_MAN','Stock Manager',5500,8500);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('ST_CLERK','Stock Clerk',2000,5000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('IT_PROG','Programmer',4000,10000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('MK_MAN','Marketing Manager',9000,15000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('MK_REP','Marketing Representative',4000,9000);

Insert into JOB_GRADES (GRADE_LEVEL,LOWEST_SAL,HIGHEST_SAL) values ('A',1000,2999);
Insert into JOB_GRADES (GRADE_LEVEL,LOWEST_SAL,HIGHEST_SAL) values ('B',3000,5999);
Insert into JOB_GRADES (GRADE_LEVEL,LOWEST_SAL,HIGHEST_SAL) values ('C',6000,9999);
Insert into JOB_GRADES (GRADE_LEVEL,LOWEST_SAL,HIGHEST_SAL) values ('D',10000,14999);
Insert into JOB_GRADES (GRADE_LEVEL,LOWEST_SAL,HIGHEST_SAL) values ('E',15000,24999);
Insert into JOB_GRADES (GRADE_LEVEL,LOWEST_SAL,HIGHEST_SAL) values ('F',25000,40000);

Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (102,to_date('13-JAN-93','DD-MON-RR'),to_date('24-JUL-98','DD-MON-RR'),'IT_PROG',60);
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (101,to_date('21-SEP-89','DD-MON-RR'),to_date('27-OCT-93','DD-MON-RR'),'AC_ACCOUNT',110);
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (101,to_date('28-OCT-93','DD-MON-RR'),to_date('15-MAR-97','DD-MON-RR'),'AC_MGR',110);
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (201,to_date('17-FEB-96','DD-MON-RR'),to_date('19-DEC-99','DD-MON-RR'),'MK_REP',20);
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (144,to_date('24-MAR-98','DD-MON-RR'),to_date('31-DEC-99','DD-MON-RR'),'ST_CLERK',50);
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (124,to_date('01-JAN-99','DD-MON-RR'),to_date('31-DEC-99','DD-MON-RR'),'ST_CLERK',50);
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (200,to_date('17-SEP-87','DD-MON-RR'),to_date('17-JUN-93','DD-MON-RR'),'AD_ASST',90);
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (176,to_date('24-MAR-98','DD-MON-RR'),to_date('31-DEC-98','DD-MON-RR'),'SA_REP',80);
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (176,to_date('01-JAN-99','DD-MON-RR'),to_date('31-DEC-99','DD-MON-RR'),'SA_MAN',80);
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (200,to_date('01-JUL-94','DD-MON-RR'),to_date('31-DEC-98','DD-MON-RR'),'AC_ACCOUNT',90);

Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1400,'2014 Jabberwocky Rd','26192','Southlake','Texas','US');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1500,'2011 Interiors Blvd','99236','South San Francisco','California','US');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1700,'2004 Charade Rd','98199','Seattle','Washington','US');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1800,'460 Bloor St. W.','ON M5S 1X8','Toronto','Ontario','CA');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2500,'Magdalen Centre, The Oxford Science Park','OX9 9ZB','Oxford','Oxford','UK');

Insert into REGIONS (REGION_ID,REGION_NAME) values (1,'Europe');
Insert into REGIONS (REGION_ID,REGION_NAME) values (2,'Americas');
Insert into REGIONS (REGION_ID,REGION_NAME) values (3,'Asia');
Insert into REGIONS (REGION_ID,REGION_NAME) values (4,'Middle East and Africa');


--------------------------------------------------------
--  Constraints for Table COUNTRIES
--------------------------------------------------------

  ---YA ESTA ESTA LLAVE PRIMARIA ALTER TABLE "COUNTRIES" ADD CONSTRAINT "COUNTRY_C_ID_PK" PRIMARY KEY ("COUNTRY_ID");
  ALTER TABLE "COUNTRIES" MODIFY ("COUNTRY_ID" CONSTRAINT "COUNTRY_ID_NN" NOT NULL);
--------------------------------------------------------
--  Constraints for Table DEPARTMENTS
--------------------------------------------------------

  ALTER TABLE "DEPARTMENTS" ADD CONSTRAINT "DEPT_ID_PK" PRIMARY KEY ("DEPARTMENT_ID");
  ALTER TABLE "DEPARTMENTS" MODIFY ("DEPARTMENT_NAME" CONSTRAINT "DEPT_NAME_NN" NOT NULL);
--------------------------------------------------------
--  Constraints for Table EMPLOYEES
--------------------------------------------------------

  ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_EMP_ID_PK" PRIMARY KEY ("EMPLOYEE_ID");
  ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_EMAIL_UK" UNIQUE ("EMAIL");
  ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_SALARY_MIN" CHECK (salary > 0);
  ALTER TABLE "EMPLOYEES" MODIFY ("JOB_ID" CONSTRAINT "EMP_JOB_NN" NOT NULL);
  ALTER TABLE "EMPLOYEES" MODIFY ("HIRE_DATE" CONSTRAINT "EMP_HIRE_DATE_NN" NOT NULL);
  ALTER TABLE "EMPLOYEES" MODIFY ("EMAIL" CONSTRAINT "EMP_EMAIL_NN" NOT NULL);
  ALTER TABLE "EMPLOYEES" MODIFY ("LAST_NAME" CONSTRAINT "EMP_LAST_NAME_NN" NOT NULL);
--------------------------------------------------------
--  Constraints for Table JOBS
--------------------------------------------------------

  ALTER TABLE "JOBS" ADD CONSTRAINT "JOB_ID_PK" PRIMARY KEY ("JOB_ID");
  ALTER TABLE "JOBS" MODIFY ("JOB_TITLE" CONSTRAINT "JOB_TITLE_NN" NOT NULL);
--------------------------------------------------------
--  Constraints for Table JOB_HISTORY
--------------------------------------------------------

  ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_EMP_ID_ST_DATE_PK" PRIMARY KEY ("EMPLOYEE_ID", "START_DATE");
  ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_DATE_INTERVAL" CHECK (end_date > start_date);
  ALTER TABLE "JOB_HISTORY" MODIFY ("JOB_ID" CONSTRAINT "JHIST_JOB_NN" NOT NULL);
  ALTER TABLE "JOB_HISTORY" MODIFY ("END_DATE" CONSTRAINT "JHIST_END_DATE_NN" NOT NULL);
  ALTER TABLE "JOB_HISTORY" MODIFY ("START_DATE" CONSTRAINT "JHIST_START_DATE_NN" NOT NULL);
  ALTER TABLE "JOB_HISTORY" MODIFY ("EMPLOYEE_ID" CONSTRAINT "JHIST_EMPLOYEE_NN" NOT NULL);
--------------------------------------------------------
--  Constraints for Table LOCATIONS
--------------------------------------------------------

  ALTER TABLE "LOCATIONS" ADD CONSTRAINT "LOC_ID_PK" PRIMARY KEY ("LOCATION_ID");
  ALTER TABLE "LOCATIONS" MODIFY ("CITY" CONSTRAINT "LOC_CITY_NN" NOT NULL);
--------------------------------------------------------
--  Constraints for Table REGIONS
--------------------------------------------------------

  ALTER TABLE "REGIONS" ADD CONSTRAINT "REG_ID_PK" PRIMARY KEY ("REGION_ID");
  ALTER TABLE "REGIONS" MODIFY ("REGION_ID" CONSTRAINT "REGION_ID_NN" NOT NULL);
--------------------------------------------------------
--  Ref Constraints for Table COUNTRIES
--------------------------------------------------------

  ALTER TABLE "COUNTRIES" ADD CONSTRAINT "COUNTR_REG_FK" FOREIGN KEY ("REGION_ID") REFERENCES "REGIONS" ("REGION_ID");
--------------------------------------------------------
--  Ref Constraints for Table DEPARTMENTS
--------------------------------------------------------

  ALTER TABLE "DEPARTMENTS" ADD CONSTRAINT "DEPT_LOC_FK" FOREIGN KEY ("LOCATION_ID") REFERENCES "LOCATIONS" ("LOCATION_ID");
  ALTER TABLE "DEPARTMENTS" ADD CONSTRAINT "DEPT_MGR_FK" FOREIGN KEY ("MANAGER_ID") REFERENCES "EMPLOYEES" ("EMPLOYEE_ID");
--------------------------------------------------------
--  Ref Constraints for Table EMPLOYEES
--------------------------------------------------------

  ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_DEPT_FK" FOREIGN KEY ("DEPARTMENT_ID") REFERENCES "DEPARTMENTS" ("DEPARTMENT_ID");
  ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_JOB_FK" FOREIGN KEY ("JOB_ID") REFERENCES "JOBS" ("JOB_ID");
  ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_MANAGER_FK" FOREIGN KEY ("MANAGER_ID") REFERENCES "EMPLOYEES" ("EMPLOYEE_ID");
--------------------------------------------------------
--  Ref Constraints for Table JOB_HISTORY
--------------------------------------------------------

  ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_DEPT_FK" FOREIGN KEY ("DEPARTMENT_ID") REFERENCES "DEPARTMENTS" ("DEPARTMENT_ID");
  ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_EMP_FK" FOREIGN KEY ("EMPLOYEE_ID") REFERENCES "EMPLOYEES" ("EMPLOYEE_ID");
  ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_JOB_FK" FOREIGN KEY ("JOB_ID") REFERENCES "JOBS" ("JOB_ID");

--------------------------------------------------------
--  Ref Constraints for Table LOCATIONS
--------------------------------------------------------

  ALTER TABLE "LOCATIONS" ADD CONSTRAINT "LOC_C_ID_FK" FOREIGN KEY ("COUNTRY_ID") REFERENCES "COUNTRIES" ("COUNTRY_ID");