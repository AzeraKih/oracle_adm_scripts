/*
Script para validar objetos invalidos
*/
SET VERIFY OFF

COL COMMAND FORMAT A150

ACCEPT VAR_OWNER PROMPT 'INFORME PARTE DO OWNER : '

SELECT (CASE
       WHEN OBJECT_TYPE  = 'SYNONYM' THEN
            (CASE WHEN OWNER = 'PUBLIC' THEN
               'DESC "'||OBJECT_NAME||'";'
             ELSE
               'DESC "' || OWNER || '"."' || OBJECT_NAME || '";'
             END)
       WHEN OBJECT_TYPE LIKE 'JAVA%' THEN
            'ALTER ' || OBJECT_TYPE || ' "' || OWNER || '"."' || OBJECT_NAME || '" RESOLVE;'
       WHEN OBJECT_TYPE LIKE 'TYPE%' THEN
            'ALTER TYPE "' || OWNER || '"."' || OBJECT_NAME || '" COMPILE;'
       ELSE
            'ALTER ' || DECODE(OBJECT_TYPE, 'PACKAGE BODY', 'PACKAGE', OBJECT_TYPE) || ' "' || OWNER || '"."' || OBJECT_NAME || '" COMPILE' || DECODE(OBJECT_TYPE, 'PACKAGE BODY', ' BODY','') || ';'
       END ) COMMAND
FROM  DBA_OBJECTS
WHERE STATUS = 'INVALID'
AND   UPPER(OWNER) LIKE UPPER('%&VAR_OWNER%')
UNION
SELECT
    'ALTER INDEX "'||OWNER||'"."'||INDEX_NAME||'" REBUILD;' 
FROM DBA_INDEXES
WHERE STATUS = 'UNUSABLE'
    AND UPPER(OWNER) LIKE UPPER('%&VAR_OWNER%')
ORDER BY 1 DESC;

CLEAR COL
UNDEF VAR_OWNER VAR_TYPE