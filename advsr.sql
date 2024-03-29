/*
 Cria uma tuning task do oracle ADVISOR e a executa
 Ps. Licenciamento necessario.
*/

SET SERVEROUTPUT ON SIZE UNLIMITED;

DECLARE
  l_sql_tune_task_id  VARCHAR2(100);
BEGIN
  l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
                          sql_id      => '&1',
                          scope       => DBMS_SQLTUNE.scope_comprehensive,
                          time_limit  => 1200,
                          task_name   => 'tuning_task_&1',
                          description => 'Tuning task1 for sql_id &1');
    DBMS_SQLTUNE.execute_tuning_task(task_name => l_sql_tune_task_id);
    DBMS_OUTPUT.put_line('------------------------------------');
    DBMS_OUTPUT.put_line('-  Execute:                        -');
    DBMS_OUTPUT.put_line('------------------------------------');
    DBMS_OUTPUT.put_line('set long 1000000;');
    DBMS_OUTPUT.put_line('set longchunksize 100000');
    DBMS_OUTPUT.put_line('set pagesize 10000 ');
    DBMS_OUTPUT.put_line('set linesize 1000 ');
    DBMS_OUTPUT.put_line('select dbms_sqltune.report_tuning_task(''tuning_task_&1'') as Recommandations from dual;');
END;
/

undef 1