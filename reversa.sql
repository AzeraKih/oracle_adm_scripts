/*
Traz a DDL de um objeto.
*/
SET LONG 90000 LONGCHUNKSIZE 20000 PAGESIZE 0 LINESIZE 3000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON

ACCEPT VAR_TYPE  PROMPT 'TIPO DO OBJETO  : '
ACCEPT VAR_OBJ   PROMPT 'NOME DO OBJETO  : '
ACCEPT VAR_OWNER PROMPT 'OWNER DO OBJETO : '

SELECT DBMS_METADATA.GET_DDL('&VAR_TYPE','&VAR_OBJ','&VAR_OWNER') FROM DUAL;

UNDEF VAR_TYPE VAR_OBJ VAR_OWNER
SET LINESIZE 900 FEEDBACK ON VERIFY ON
