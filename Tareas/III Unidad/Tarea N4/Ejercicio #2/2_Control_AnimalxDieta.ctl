OPTIONS (SKIP='1')
LOAD DATA
APPEND INTO TABLE ANIMALXDIETA
(
ANIMALID CHAR TERMINATED BY ", " ,
DIETAID CHAR TERMINATED BY ", " ,
FECHAINICIO DATE "YYYY-MM-DD" TERMINATED BY ", " ,
FECHAFINAL DATE "YYYY-MM-DD" TERMINATED BY ", "
)