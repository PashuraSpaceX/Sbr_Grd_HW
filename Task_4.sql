Минимальные значения столбцов

При решении задачи может пригодиться следующее. Если в конструкции execute immediate написать select, выдающий одну единственную строку, то можно получить значения возвращённых полей с помощью опции into, например,

set serveroutput on
declare
  v_dummy   char(1);
  v_sysdate date;
begin
  execute immediate 'select dummy, sysdate from dual'
    into v_dummy, v_sysdate;
  dbms_output.enable;
  dbms_output.put_line('v_dummy=' || v_dummy || ', v_sysdate=' ||
                       to_char(v_sysdate, 'dd.mm.yyyy hh24:mi:ss'));
end;

Во всех таблицах и вьюшках текущей схемы найти первые по алфавиту столбцы среди столбцов, имеющих типы данных не BLOB и не CLOB.
Найти минимальное значение, хранящееся в таком первом по алфавиту столбце каждой таблицы или вьюшки, привести его к строковому типу данных (в формате по умолчанию).
Вывести в dbms_output отчёт о таблицах о вьюшках, их первых по алфавиту столбцах и минимальных значениях в этих столбцах.
Не использовать вспомогательных таблиц (не делать create table).

Пример того, что может получиться в dbms_output:

table_name=CLIENTS                                          column_name=ID                                              min_value=1                                                 
table_name=CLIENTS_EXT                                      column_name=CLIENT_NAME                                     min_value=DNLKKI                                            
table_name=KK_RATE                                          column_name=CURRENCY_CODE                                   min_value=840                                               
table_name=SELECT_ME_BY_DBLINK                              column_name=F1                                              min_value=                                                  
table_name=STATE_HIER                                       column_name=BOSS_ID                                         min_value=1                                                 
table_name=TEST_STUDENTS                                    column_name=PASSPORT_NUMBER                                 min_value=485892                                            
table_name=KK_AUTONOMOUS_COMMITING_TABLE                    column_name=ID                                              min_value=1                                                 
table_name=KK_CLIENT                                        column_name=AMOUNT                                          min_value=                                                  
table_name=KK_EVENTS_LOG                                    column_name=EVENT_DATE                                      min_value=24.04.21     




SET SERVEROUTPUT ON

DECLARE
    table_name      VARCHAR2(100);
    column_name     VARCHAR2(100);
    column_content  VARCHAR2(100);
BEGIN
    dbms_output.enable;
    FOR z IN (
        SELECT
            table_name,
            MIN(column_name) AS "COLUMN_NAME"
        FROM
            user_tab_columns
        WHERE
                data_type != 'BLOB' AND data_type != 'CLOB'
        GROUP BY
            table_name
        ORDER BY
            table_name) 
        LOOP
        table_name := z.table_name;
        column_name := z.column_name;
        EXECUTE IMMEDIATE 'select min('|| column_name || ') from ' || table_name || ''
        INTO column_content;
        CONTINUE WHEN column_content IS NULL;
        dbms_output.put_line(to_char(rpad('table_name = ' || table_name, 31))
        || to_char(rpad('column_name = ' || column_name, 31))
        || to_char(rpad('min_value = ' || column_content, 31)));
    END LOOP;
END;