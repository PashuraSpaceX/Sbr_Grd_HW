����� � �������� � ����������
������� ������� ������
--create table planets(id integer, name varchar2(100));
� �������
--create sequence sq_planets;
�������� �����, � ������� ����:

-- ��������� � ����������� num_rows � max_length, 
--������� ��������� � ��� ������� num_rows �����:
--id �� ��������, name � ������ ��������� ����� �� 1 �� max_length 
--�� ���������� ���������.

-- ������� � ���������� name_length, ������� ��� �������� ����� name_length 
--����� ����� ������ �� �������� ������� � ��������� ����� ����� (name ��� id).

--DROP TABLE planets;
--drop sequence sq_planets;

CREATE TABLE planets (id INTEGER, name VARCHAR2(100));
-- ������� �����
CREATE SEQUENCE sq_planets;
-- ������� �������
select * from planets;

CREATE OR REPLACE PACKAGE t_2_pkg IS
    PROCEDURE t_2_p (num_rows   IN INTEGER, max_length IN INTEGER);
    FUNCTION t_2_f (name_length IN INTEGER) RETURN VARCHAR2;
END t_2_pkg;
-- ������� ������������ �� ����� � � ���������� � �������� � ��������� �����������
CREATE OR REPLACE PACKAGE BODY t_2_pkg IS
    PROCEDURE t_2_p (num_rows   IN INTEGER, max_length IN INTEGER) IS x_y INTEGER; -- �������� ��������� ����� ����� �� ��� � � ������. �_� ����������
    BEGIN 
    FOR i IN 1..num_rows LOOP
            x_y := trunc(dbms_random.value(1, max_length)); -- �������������� �� ���� trunk
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