Пакет с функцией и процедурой
Имеется таблица планет
--create table planets(id integer, name varchar2(100));
и сиквенс
--create sequence sq_planets;
Написать пакет, в котором есть:

-- процедура с параметрами num_rows и max_length, 
--которая вставляет в эту таблицу num_rows строк:
--id из сиквенса, name – строка случайной длины от 1 до max_length 
--со случайными символами.

-- функция с параметром name_length, которая для заданной длины name_length 
--выдаёт самую первую по алфавиту планету с названием такой длины (name без id).

--DROP TABLE planets;
--drop sequence sq_planets;

CREATE TABLE planets (id INTEGER, name VARCHAR2(100));
-- создали таблу
CREATE SEQUENCE sq_planets;
-- создали сиквенс
select * from planets;

CREATE OR REPLACE PACKAGE t_2_pkg IS
    PROCEDURE t_2_p (num_rows   IN INTEGER, max_length IN INTEGER);
    FUNCTION t_2_f (name_length IN INTEGER) RETURN VARCHAR2;
END t_2_pkg;
-- создали спецификацию на пакет с ф процедурой и функцией с входящими параметрами
CREATE OR REPLACE PACKAGE BODY t_2_pkg IS
    PROCEDURE t_2_p (num_rows   IN INTEGER, max_length IN INTEGER) IS x_y INTEGER; -- описание процедуры точно такое же как и в специф. х_у переменная
    BEGIN 
    FOR i IN 1..num_rows LOOP
            x_y := trunc(dbms_random.value(1, max_length)); -- целочислоенное за счет trunk
            INSERT INTO planets (id, name) VALUES (sq_planets.NEXTVAL, dbms_random.string(1, x_y));

        END LOOP;
    END t_2_p;

    FUNCTION t_2_f (name_length IN INTEGER) RETURN VARCHAR2 IS
        res VARCHAR2(100);
    BEGIN
        SELECT
            name INTO res FROM(SELECT name, length(name) AS length
                FROM planets WHERE length(name) = name_length
                ORDER BY length, name) 
                WHERE ROWNUM = 1 ;
        RETURN res;
    END t_2_f;
END t_2_pkg;

SET SERVEROUTPUT ON

BEGIN
    dbms_output.enable;
    t_2_pkg.t_2_p(4, 24);
END;

select * from planets;

SELECT
    t_2_pkg.t_2_f(1)
FROM
    dual;