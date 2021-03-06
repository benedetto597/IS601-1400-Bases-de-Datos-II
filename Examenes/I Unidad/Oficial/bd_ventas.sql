--------------------------------------------------------
--  DDL for Table DEMO_CUSTOMERS
--------------------------------------------------------

  CREATE TABLE "DEMO_CUSTOMERS" ("CUSTOMER_ID" NUMBER, "CUST_FIRST_NAME" VARCHAR2(20), "CUST_LAST_NAME" VARCHAR2(20), "CUST_STREET_ADDRESS1" VARCHAR2(60), "CUST_STREET_ADDRESS2" VARCHAR2(60), "CUST_CITY" VARCHAR2(30), "CUST_STATE" VARCHAR2(2), "CUST_POSTAL_CODE" VARCHAR2(10), "PHONE_NUMBER1" VARCHAR2(25), "PHONE_NUMBER2" VARCHAR2(25), "CREDIT_LIMIT" NUMBER(9,2), "CUST_EMAIL" VARCHAR2(30)) ;
--------------------------------------------------------
--  DDL for Table DEMO_ORDERS
--------------------------------------------------------

  CREATE TABLE "DEMO_ORDERS" ("ORDER_ID" NUMBER, "CUSTOMER_ID" NUMBER, "ORDER_TOTAL" NUMBER(8,2), "ORDER_TIMESTAMP" DATE, "USER_ID" NUMBER) ;
--------------------------------------------------------
--  DDL for Table DEMO_ORDER_ITEMS
--------------------------------------------------------

  CREATE TABLE "DEMO_ORDER_ITEMS" ("ORDER_ITEM_ID" NUMBER(3,0), "ORDER_ID" NUMBER, "PRODUCT_ID" NUMBER, "UNIT_PRICE" NUMBER(8,2), "QUANTITY" NUMBER(8,0)) ;
--------------------------------------------------------
--  DDL for Table DEMO_PRODUCT_INFO
--------------------------------------------------------

  CREATE TABLE "DEMO_PRODUCT_INFO" ("PRODUCT_ID" NUMBER, "PRODUCT_NAME" VARCHAR2(50), "PRODUCT_DESCRIPTION" VARCHAR2(2000), "CATEGORY" VARCHAR2(30), "PRODUCT_AVAIL" VARCHAR2(1), "LIST_PRICE" NUMBER(8,2), "PRODUCT_IMAGE" BLOB, "MIMETYPE" VARCHAR2(255), "FILENAME" VARCHAR2(400), "IMAGE_LAST_UPDATE" DATE) ;
--------------------------------------------------------
--  DDL for Table DEMO_STATES
--------------------------------------------------------

  CREATE TABLE "DEMO_STATES" ("ST" VARCHAR2(30), "STATE_NAME" VARCHAR2(30)) ;
--------------------------------------------------------
--  DDL for Table DEMO_USERS
--------------------------------------------------------

  CREATE TABLE "DEMO_USERS" ("USER_ID" NUMBER, "USER_NAME" VARCHAR2(100), "PASSWORD" VARCHAR2(4000), "CREATED_ON" DATE, "QUOTA" NUMBER, "PRODUCTS" CHAR(1), "EXPIRES_ON" DATE, "ADMIN_USER" CHAR(1)) ;
--------------------------------------------------------
--  DDL for Table DEPT
--------------------------------------------------------

  CREATE TABLE "DEPT" ("DEPTNO" NUMBER(2,0), "DNAME" VARCHAR2(14), "LOC" VARCHAR2(13)) ;
--------------------------------------------------------
--  DDL for Table EMP
--------------------------------------------------------

  CREATE TABLE "EMP" ("EMPNO" NUMBER(4,0), "ENAME" VARCHAR2(10), "JOB" VARCHAR2(9), "MGR" NUMBER(4,0), "HIREDATE" DATE, "SAL" NUMBER(7,2), "COMM" NUMBER(7,2), "DEPTNO" NUMBER(2,0)) ;
REM INSERTING into DEMO_CUSTOMERS
SET DEFINE OFF;
Insert into DEMO_CUSTOMERS (CUSTOMER_ID,CUST_FIRST_NAME,CUST_LAST_NAME,CUST_STREET_ADDRESS1,CUST_STREET_ADDRESS2,CUST_CITY,CUST_STATE,CUST_POSTAL_CODE,PHONE_NUMBER1,PHONE_NUMBER2,CREDIT_LIMIT,CUST_EMAIL) values (1,'John','Dulles','45020 Aviation Drive',null,'Sterling','VA','20166','703-555-2143',null,1000,null);
Insert into DEMO_CUSTOMERS (CUSTOMER_ID,CUST_FIRST_NAME,CUST_LAST_NAME,CUST_STREET_ADDRESS1,CUST_STREET_ADDRESS2,CUST_CITY,CUST_STATE,CUST_POSTAL_CODE,PHONE_NUMBER1,PHONE_NUMBER2,CREDIT_LIMIT,CUST_EMAIL) values (2,'William','Hartsfield','6000 North Terminal Parkway',null,'Atlanta','GA','30320','404-555-3285',null,1000,null);
Insert into DEMO_CUSTOMERS (CUSTOMER_ID,CUST_FIRST_NAME,CUST_LAST_NAME,CUST_STREET_ADDRESS1,CUST_STREET_ADDRESS2,CUST_CITY,CUST_STATE,CUST_POSTAL_CODE,PHONE_NUMBER1,PHONE_NUMBER2,CREDIT_LIMIT,CUST_EMAIL) values (3,'Edward','Logan','1 Harborside Drive',null,'East Boston','MA','02128','617-555-3295',null,1000,null);
Insert into DEMO_CUSTOMERS (CUSTOMER_ID,CUST_FIRST_NAME,CUST_LAST_NAME,CUST_STREET_ADDRESS1,CUST_STREET_ADDRESS2,CUST_CITY,CUST_STATE,CUST_POSTAL_CODE,PHONE_NUMBER1,PHONE_NUMBER2,CREDIT_LIMIT,CUST_EMAIL) values (4,'Edward "Butch"','OHare','10000 West OHare',null,'Chicago','IL','60666','773-555-7693',null,1000,null);
Insert into DEMO_CUSTOMERS (CUSTOMER_ID,CUST_FIRST_NAME,CUST_LAST_NAME,CUST_STREET_ADDRESS1,CUST_STREET_ADDRESS2,CUST_CITY,CUST_STATE,CUST_POSTAL_CODE,PHONE_NUMBER1,PHONE_NUMBER2,CREDIT_LIMIT,CUST_EMAIL) values (5,'Fiorello','LaGuardia','Hangar Center','Third Floor','Flushing','NY','11371','212-555-3923',null,1000,null);
Insert into DEMO_CUSTOMERS (CUSTOMER_ID,CUST_FIRST_NAME,CUST_LAST_NAME,CUST_STREET_ADDRESS1,CUST_STREET_ADDRESS2,CUST_CITY,CUST_STATE,CUST_POSTAL_CODE,PHONE_NUMBER1,PHONE_NUMBER2,CREDIT_LIMIT,CUST_EMAIL) values (6,'Albert','Lambert','10701 Lambert International Blvd.',null,'St. Louis','MO','63145','314-555-4022',null,1000,null);
Insert into DEMO_CUSTOMERS (CUSTOMER_ID,CUST_FIRST_NAME,CUST_LAST_NAME,CUST_STREET_ADDRESS1,CUST_STREET_ADDRESS2,CUST_CITY,CUST_STATE,CUST_POSTAL_CODE,PHONE_NUMBER1,PHONE_NUMBER2,CREDIT_LIMIT,CUST_EMAIL) values (7,'Eugene','Bradley','Schoephoester Road',null,'Windsor Locks','CT','06096','860-555-1835',null,1000,null);
REM INSERTING into DEMO_ORDERS
SET DEFINE OFF;
Insert into DEMO_ORDERS (ORDER_ID,CUSTOMER_ID,ORDER_TOTAL,ORDER_TIMESTAMP,USER_ID) values (1,7,1890,to_date('17-JUN-18','DD-MON-RR'),2);
Insert into DEMO_ORDERS (ORDER_ID,CUSTOMER_ID,ORDER_TOTAL,ORDER_TIMESTAMP,USER_ID) values (2,1,2380,to_date('14-JUN-18','DD-MON-RR'),2);
Insert into DEMO_ORDERS (ORDER_ID,CUSTOMER_ID,ORDER_TOTAL,ORDER_TIMESTAMP,USER_ID) values (3,2,1640,to_date('08-JUN-18','DD-MON-RR'),2);
Insert into DEMO_ORDERS (ORDER_ID,CUSTOMER_ID,ORDER_TOTAL,ORDER_TIMESTAMP,USER_ID) values (4,5,1090,to_date('31-MAY-18','DD-MON-RR'),2);
Insert into DEMO_ORDERS (ORDER_ID,CUSTOMER_ID,ORDER_TOTAL,ORDER_TIMESTAMP,USER_ID) values (5,6,950,to_date('26-MAY-18','DD-MON-RR'),2);
Insert into DEMO_ORDERS (ORDER_ID,CUSTOMER_ID,ORDER_TOTAL,ORDER_TIMESTAMP,USER_ID) values (6,3,1515,to_date('21-MAY-18','DD-MON-RR'),2);
Insert into DEMO_ORDERS (ORDER_ID,CUSTOMER_ID,ORDER_TOTAL,ORDER_TIMESTAMP,USER_ID) values (7,3,905,to_date('11-MAY-18','DD-MON-RR'),2);
Insert into DEMO_ORDERS (ORDER_ID,CUSTOMER_ID,ORDER_TOTAL,ORDER_TIMESTAMP,USER_ID) values (8,4,1060,to_date('09-MAY-18','DD-MON-RR'),2);
Insert into DEMO_ORDERS (ORDER_ID,CUSTOMER_ID,ORDER_TOTAL,ORDER_TIMESTAMP,USER_ID) values (9,2,730,to_date('28-APR-18','DD-MON-RR'),2);
Insert into DEMO_ORDERS (ORDER_ID,CUSTOMER_ID,ORDER_TOTAL,ORDER_TIMESTAMP,USER_ID) values (10,7,870,to_date('14-APR-18','DD-MON-RR'),2);
REM INSERTING into DEMO_ORDER_ITEMS
SET DEFINE OFF;
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (1,1,1,50,10);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (2,1,2,80,8);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (3,1,3,150,5);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (4,2,1,50,3);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (5,2,2,80,3);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (6,2,3,150,3);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (7,2,4,60,3);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (8,2,5,80,3);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (9,2,6,120,2);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (10,2,7,30,2);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (11,2,8,125,4);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (12,2,9,110,2);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (13,2,10,50,2);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (14,3,4,60,4);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (15,3,5,80,4);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (16,3,6,120,4);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (17,3,8,125,4);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (18,3,10,50,2);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (19,4,6,120,2);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (20,4,7,30,6);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (21,4,8,125,2);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (22,4,9,110,2);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (23,4,10,50,4);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (24,5,1,50,3);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (25,5,2,80,2);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (26,5,3,150,2);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (27,5,4,60,3);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (28,5,5,80,2);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (29,6,3,150,3);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (30,6,6,120,3);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (31,6,8,125,3);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (32,6,9,110,3);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (33,7,1,50,2);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (34,7,2,80,2);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (35,7,4,60,2);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (36,7,5,80,2);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (37,7,7,30,3);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (38,7,8,125,1);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (39,7,10,50,3);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (40,8,2,80,2);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (41,8,3,150,3);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (42,8,6,120,1);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (43,8,9,110,3);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (44,9,4,60,4);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (45,9,5,80,3);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (46,9,8,125,2);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (47,10,1,50,5);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (48,10,2,80,4);
Insert into DEMO_ORDER_ITEMS (ORDER_ITEM_ID,ORDER_ID,PRODUCT_ID,UNIT_PRICE,QUANTITY) values (49,10,3,150,2);
REM INSERTING into DEMO_PRODUCT_INFO
SET DEFINE OFF;
Insert into DEMO_PRODUCT_INFO (PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,CATEGORY,PRODUCT_AVAIL,LIST_PRICE,MIMETYPE,FILENAME,IMAGE_LAST_UPDATE) values (9,'Mens Shoes','Leather upper and lower lace up shoes','Mens','Y',110,'image/jpeg','shoes.jpg',to_date('18-JUN-18','DD-MON-RR'));
Insert into DEMO_PRODUCT_INFO (PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,CATEGORY,PRODUCT_AVAIL,LIST_PRICE,MIMETYPE,FILENAME,IMAGE_LAST_UPDATE) values (10,'Wallet','Travel wallet suitable for men and women. Several compartments for credit cards, passports and cash','Accessories','Y',50,'image/jpeg','wallet.jpg',to_date('18-JUN-18','DD-MON-RR'));
Insert into DEMO_PRODUCT_INFO (PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,CATEGORY,PRODUCT_AVAIL,LIST_PRICE,MIMETYPE,FILENAME,IMAGE_LAST_UPDATE) values (1,'Business Shirt','Wrinkle-free cotton business shirt','Mens','Y',50,'image/jpeg','shirt.jpg',to_date('18-JUN-18','DD-MON-RR'));
Insert into DEMO_PRODUCT_INFO (PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,CATEGORY,PRODUCT_AVAIL,LIST_PRICE,MIMETYPE,FILENAME,IMAGE_LAST_UPDATE) values (2,'Trousers','Black trousers suitable for every business man','Mens','Y',80,'image/jpeg','pants.jpg',to_date('18-JUN-18','DD-MON-RR'));
Insert into DEMO_PRODUCT_INFO (PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,CATEGORY,PRODUCT_AVAIL,LIST_PRICE,MIMETYPE,FILENAME,IMAGE_LAST_UPDATE) values (3,'Jacket','Fully lined jacket which is both professional and extremely comfortable to wear','Mens','Y',150,'image/jpeg','jacket.jpg',to_date('18-JUN-18','DD-MON-RR'));
Insert into DEMO_PRODUCT_INFO (PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,CATEGORY,PRODUCT_AVAIL,LIST_PRICE,MIMETYPE,FILENAME,IMAGE_LAST_UPDATE) values (4,'Blouse','Silk blouse ideal for all business women','Womens','Y',60,'image/jpeg','blouse.jpg',to_date('18-JUN-18','DD-MON-RR'));
Insert into DEMO_PRODUCT_INFO (PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,CATEGORY,PRODUCT_AVAIL,LIST_PRICE,MIMETYPE,FILENAME,IMAGE_LAST_UPDATE) values (5,'Skirt','Wrinkle free skirt','Womens','Y',80,'image/jpeg','skirt.jpg',to_date('18-JUN-18','DD-MON-RR'));
Insert into DEMO_PRODUCT_INFO (PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,CATEGORY,PRODUCT_AVAIL,LIST_PRICE,MIMETYPE,FILENAME,IMAGE_LAST_UPDATE) values (6,'Ladies Shoes','Low heel and cushioned interior for comfort and style in simple yet elegant shoes','Womens','Y',120,'image/jpeg','heels.jpg',to_date('18-JUN-18','DD-MON-RR'));
Insert into DEMO_PRODUCT_INFO (PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,CATEGORY,PRODUCT_AVAIL,LIST_PRICE,MIMETYPE,FILENAME,IMAGE_LAST_UPDATE) values (7,'Belt','Leather belt','Accessories','Y',30,'image/jpeg','belt.jpg',to_date('18-JUN-18','DD-MON-RR'));
Insert into DEMO_PRODUCT_INFO (PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,CATEGORY,PRODUCT_AVAIL,LIST_PRICE,MIMETYPE,FILENAME,IMAGE_LAST_UPDATE) values (8,'Bag','Unisex bag suitable for carrying laptops with room for many additional items','Accessories','Y',125,'image/jpeg','bag.jpg',to_date('18-JUN-18','DD-MON-RR'));
REM INSERTING into DEMO_STATES
SET DEFINE OFF;
Insert into DEMO_STATES (ST,STATE_NAME) values ('AK','ALASKA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('AL','ALABAMA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('AR','ARKANSAS');
Insert into DEMO_STATES (ST,STATE_NAME) values ('AZ','ARIZONA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('CA','CALIFORNIA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('CO','COLORADO');
Insert into DEMO_STATES (ST,STATE_NAME) values ('CT','CONNECTICUT');
Insert into DEMO_STATES (ST,STATE_NAME) values ('DC','DISTRICT OF COLUMBIA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('DE','DELAWARE');
Insert into DEMO_STATES (ST,STATE_NAME) values ('FL','FLORIDA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('GA','GEORGIA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('HI','HAWAII');
Insert into DEMO_STATES (ST,STATE_NAME) values ('IA','IOWA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('ID','IDAHO');
Insert into DEMO_STATES (ST,STATE_NAME) values ('IL','ILLINOIS');
Insert into DEMO_STATES (ST,STATE_NAME) values ('IN','INDIANA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('KS','KANSAS');
Insert into DEMO_STATES (ST,STATE_NAME) values ('KY','KENTUCKY');
Insert into DEMO_STATES (ST,STATE_NAME) values ('LA','LOUISIANA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('MA','MASSACHUSETTS');
Insert into DEMO_STATES (ST,STATE_NAME) values ('MD','MARYLAND');
Insert into DEMO_STATES (ST,STATE_NAME) values ('ME','MAINE');
Insert into DEMO_STATES (ST,STATE_NAME) values ('MI','MICHIGAN');
Insert into DEMO_STATES (ST,STATE_NAME) values ('MN','MINNESOTA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('MO','MISSOURI');
Insert into DEMO_STATES (ST,STATE_NAME) values ('MS','MISSISSIPPI');
Insert into DEMO_STATES (ST,STATE_NAME) values ('MT','MONTANA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('NC','NORTH CAROLINA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('ND','NORTH DAKOTA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('NE','NEBRASKA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('NH','NEW HAMPSHIRE');
Insert into DEMO_STATES (ST,STATE_NAME) values ('NJ','NEW JERSEY');
Insert into DEMO_STATES (ST,STATE_NAME) values ('NM','NEW MEXICO');
Insert into DEMO_STATES (ST,STATE_NAME) values ('NV','NEVADA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('NY','NEW YORK');
Insert into DEMO_STATES (ST,STATE_NAME) values ('OH','OHIO');
Insert into DEMO_STATES (ST,STATE_NAME) values ('OK','OKLAHOMA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('OR','OREGON');
Insert into DEMO_STATES (ST,STATE_NAME) values ('PA','PENNSYLVANIA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('RI','RHODE ISLAND');
Insert into DEMO_STATES (ST,STATE_NAME) values ('SC','SOUTH CAROLINA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('SD','SOUTH DAKOTA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('TN','TENNESSEE');
Insert into DEMO_STATES (ST,STATE_NAME) values ('TX','TEXAS');
Insert into DEMO_STATES (ST,STATE_NAME) values ('UT','UTAH');
Insert into DEMO_STATES (ST,STATE_NAME) values ('VA','VIRGINIA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('VT','VERMONT');
Insert into DEMO_STATES (ST,STATE_NAME) values ('WA','WASHINGTON');
Insert into DEMO_STATES (ST,STATE_NAME) values ('WI','WISCONSIN');
Insert into DEMO_STATES (ST,STATE_NAME) values ('WV','WEST VIRGINIA');
Insert into DEMO_STATES (ST,STATE_NAME) values ('WY','WYOMING');
REM INSERTING into DEMO_USERS
SET DEFINE OFF;
Insert into DEMO_USERS (USER_ID,USER_NAME,PASSWORD,CREATED_ON,QUOTA,PRODUCTS,EXPIRES_ON,ADMIN_USER) values (1,'ADMIN','CAA33D9DD3A72379C924F0E193B39463',to_date('18-JUN-18','DD-MON-RR'),null,'Y',null,'Y');
Insert into DEMO_USERS (USER_ID,USER_NAME,PASSWORD,CREATED_ON,QUOTA,PRODUCTS,EXPIRES_ON,ADMIN_USER) values (2,'DEMO','4991AAE00E86E3E7A266BBE85D1F186B',to_date('18-JUN-18','DD-MON-RR'),15000,'Y',null,'N');
REM INSERTING into DEPT
SET DEFINE OFF;
Insert into DEPT (DEPTNO,DNAME,LOC) values (10,'ACCOUNTING','NEW YORK');
Insert into DEPT (DEPTNO,DNAME,LOC) values (20,'RESEARCH','DALLAS');
Insert into DEPT (DEPTNO,DNAME,LOC) values (30,'SALES','CHICAGO');
Insert into DEPT (DEPTNO,DNAME,LOC) values (40,'OPERATIONS','BOSTON');
REM INSERTING into EMP
SET DEFINE OFF;
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values (7839,'KING','PRESIDENT',null,to_date('17-NOV-81','DD-MON-RR'),5000,null,10);
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values (7698,'BLAKE','MANAGER',7839,to_date('01-MAY-81','DD-MON-RR'),2850,null,30);
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values (7782,'CLARK','MANAGER',7839,to_date('09-JUN-81','DD-MON-RR'),2450,null,10);
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values (7566,'JONES','MANAGER',7839,to_date('02-APR-81','DD-MON-RR'),2975,null,20);
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values (7788,'SCOTT','ANALYST',7566,to_date('09-DEC-82','DD-MON-RR'),3000,null,20);
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values (7902,'FORD','ANALYST',7566,to_date('03-DEC-81','DD-MON-RR'),3000,null,20);
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values (7369,'SMITH','CLERK',7902,to_date('17-DEC-80','DD-MON-RR'),800,null,20);
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values (7499,'ALLEN','SALESMAN',7698,to_date('20-FEB-81','DD-MON-RR'),1600,300,30);
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values (7521,'WARD','SALESMAN',7698,to_date('22-FEB-81','DD-MON-RR'),1250,500,30);
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values (7654,'MARTIN','SALESMAN',7698,to_date('28-SEP-81','DD-MON-RR'),1250,1400,30);
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values (7844,'TURNER','SALESMAN',7698,to_date('08-SEP-81','DD-MON-RR'),1500,0,30);
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values (7876,'ADAMS','CLERK',7788,to_date('12-JAN-83','DD-MON-RR'),1100,null,20);
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values (7900,'JAMES','CLERK',7698,to_date('03-DEC-81','DD-MON-RR'),950,null,30);
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values (7934,'MILLER','CLERK',7782,to_date('23-JAN-82','DD-MON-RR'),1300,null,10);
--------------------------------------------------------
--  DDL for Index DEMO_CUSTOMERS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEMO_CUSTOMERS_PK" ON "DEMO_CUSTOMERS" ("CUSTOMER_ID") ;
--------------------------------------------------------
--  DDL for Index DEMO_CUST_NAME_IX
--------------------------------------------------------

  CREATE INDEX "DEMO_CUST_NAME_IX" ON "DEMO_CUSTOMERS" ("CUST_LAST_NAME", "CUST_FIRST_NAME") ;
--------------------------------------------------------
--  DDL for Index DEMO_ORDER_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEMO_ORDER_PK" ON "DEMO_ORDERS" ("ORDER_ID") ;
--------------------------------------------------------
--  DDL for Index DEMO_ORD_CUSTOMER_IX
--------------------------------------------------------

  CREATE INDEX "DEMO_ORD_CUSTOMER_IX" ON "DEMO_ORDERS" ("CUSTOMER_ID") ;
--------------------------------------------------------
--  DDL for Index DEMO_ORDER_ITEMS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEMO_ORDER_ITEMS_PK" ON "DEMO_ORDER_ITEMS" ("ORDER_ITEM_ID") ;
--------------------------------------------------------
--  DDL for Index DEMO_PRODUCT_INFO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEMO_PRODUCT_INFO_PK" ON "DEMO_PRODUCT_INFO" ("PRODUCT_ID") ;
--------------------------------------------------------
--  DDL for Index DEMO_USERS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEMO_USERS_PK" ON "DEMO_USERS" ("USER_ID") ;
--------------------------------------------------------
--  DDL for Index SYS_C007275
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYS_C007275" ON "DEPT" ("DEPTNO") ;
--------------------------------------------------------
--  DDL for Index SYS_C007277
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYS_C007277" ON "EMP" ("EMPNO") ;
--------------------------------------------------------
--  Constraints for Table DEMO_CUSTOMERS
--------------------------------------------------------

  ALTER TABLE "DEMO_CUSTOMERS" ADD CONSTRAINT "DEMO_CUSTOMERS_PK" PRIMARY KEY ("CUSTOMER_ID") ENABLE;
  ALTER TABLE "DEMO_CUSTOMERS" ADD CONSTRAINT "DEMO_CUST_CREDIT_LIMIT_MAX" CHECK (credit_limit <= 5000) ENABLE;
  ALTER TABLE "DEMO_CUSTOMERS" MODIFY ("CUST_LAST_NAME" NOT NULL ENABLE);
  ALTER TABLE "DEMO_CUSTOMERS" MODIFY ("CUST_FIRST_NAME" NOT NULL ENABLE);
  ALTER TABLE "DEMO_CUSTOMERS" MODIFY ("CUSTOMER_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table DEMO_ORDERS
--------------------------------------------------------

  ALTER TABLE "DEMO_ORDERS" ADD CONSTRAINT "DEMO_ORDER_PK" PRIMARY KEY ("ORDER_ID") ENABLE;
  ALTER TABLE "DEMO_ORDERS" ADD CONSTRAINT "DEMO_ORDER_TOTAL_MIN" CHECK (order_total >= 0) ENABLE;
  ALTER TABLE "DEMO_ORDERS" MODIFY ("CUSTOMER_ID" NOT NULL ENABLE);
  ALTER TABLE "DEMO_ORDERS" MODIFY ("ORDER_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table DEMO_ORDER_ITEMS
--------------------------------------------------------

  ALTER TABLE "DEMO_ORDER_ITEMS" ADD CONSTRAINT "DEMO_ORDER_ITEMS_PK" PRIMARY KEY ("ORDER_ITEM_ID") ENABLE;
  ALTER TABLE "DEMO_ORDER_ITEMS" MODIFY ("QUANTITY" NOT NULL ENABLE);
  ALTER TABLE "DEMO_ORDER_ITEMS" MODIFY ("UNIT_PRICE" NOT NULL ENABLE);
  ALTER TABLE "DEMO_ORDER_ITEMS" MODIFY ("PRODUCT_ID" NOT NULL ENABLE);
  ALTER TABLE "DEMO_ORDER_ITEMS" MODIFY ("ORDER_ID" NOT NULL ENABLE);
  ALTER TABLE "DEMO_ORDER_ITEMS" MODIFY ("ORDER_ITEM_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table DEMO_PRODUCT_INFO
--------------------------------------------------------

  ALTER TABLE "DEMO_PRODUCT_INFO" ADD CONSTRAINT "DEMO_PRODUCT_INFO_PK" PRIMARY KEY ("PRODUCT_ID") ENABLE;
  ALTER TABLE "DEMO_PRODUCT_INFO" MODIFY ("PRODUCT_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table DEMO_USERS
--------------------------------------------------------

  ALTER TABLE "DEMO_USERS" ADD CONSTRAINT "DEMO_USERS_PK" PRIMARY KEY ("USER_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table DEPT
--------------------------------------------------------

  ALTER TABLE "DEPT" ADD PRIMARY KEY ("DEPTNO") ENABLE;
--------------------------------------------------------
--  Constraints for Table EMP
--------------------------------------------------------

  ALTER TABLE "EMP" ADD PRIMARY KEY ("EMPNO") ENABLE;
  ALTER TABLE "EMP" MODIFY ("EMPNO" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table DEMO_ORDERS
--------------------------------------------------------

  ALTER TABLE "DEMO_ORDERS" ADD CONSTRAINT "DEMO_ORDERS_CUSTOMER_ID_FK" FOREIGN KEY ("CUSTOMER_ID") REFERENCES "DEMO_CUSTOMERS" ("CUSTOMER_ID") ENABLE;
  ALTER TABLE "DEMO_ORDERS" ADD CONSTRAINT "DEMO_ORDERS_USER_ID_FK" FOREIGN KEY ("USER_ID") REFERENCES "DEMO_USERS" ("USER_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table DEMO_ORDER_ITEMS
--------------------------------------------------------

  ALTER TABLE "DEMO_ORDER_ITEMS" ADD CONSTRAINT "DEMO_ORDER_ITEMS_FK" FOREIGN KEY ("ORDER_ID") REFERENCES "DEMO_ORDERS" ("ORDER_ID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "DEMO_ORDER_ITEMS" ADD CONSTRAINT "DEMO_ORDER_ITEMS_PRODUCT_ID_FK" FOREIGN KEY ("PRODUCT_ID") REFERENCES "DEMO_PRODUCT_INFO" ("PRODUCT_ID") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table EMP
--------------------------------------------------------

  ALTER TABLE "EMP" ADD FOREIGN KEY ("MGR") REFERENCES "EMP" ("EMPNO") ENABLE;
  ALTER TABLE "EMP" ADD FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO") ENABLE;
