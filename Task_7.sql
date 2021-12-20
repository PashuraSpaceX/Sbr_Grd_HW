���������� ������� ���� �������

���� ������� �� ������� �� 4 ���������� � �� ����������� �� ������� - ��������� � ��������� �� 2 ������ ����� �������:

create table candidates(name varchar2(100), prc number(5,2));

���� ������� ��� ������� � �� ����������� ������� ���� �������.

create table vote_results(name varchar2(100), prc number(5,2), is_finished integer);

�������� ���������, ������� ������ ������� ���������:

1)
��������� ������� candidates ���������� ������� ���������� �� 10 �������� � ���������� �� ������������ �� ������� � ��������� ���������������.
� ����� ��� ���������� ������ ���� 100 ��������� (� ��������� �� ������ ����������, �.�. ����� ����� 99.99 ��� 100.01 ��������� � �����).
��������, ���:
FfKIAVVGhW	66,21
tNLwfMnKsq	24,83
RSzeaZYFNw	6,90
IdfyXFhWAT	2,07

2)
����� ��������� ������� vote_results ����������� ������� ���� �������.
���� ����� ���� ����������, ��������� ����� 50 ��������� �������.
����� is_finished=1 � ��������� ���� ������. ��������,
FfKIAVVGhW 55.13 1
���� ����� ��� ���������, ��������� ���������� ���������� �������, �������� �� ������ ���.
����� is_finished=0 � ��������� ��� ������. ��������,
FfKIAVVGhW 44.92 0
tNLwfMnKsq 29.53 0
��� ���:
FfKIAVVGhW 43.01 0
tNLwfMnKsq 43.01 0

CREATE TABLE candidates (
    name  VARCHAR2(100),
    prc   NUMBER(5, 2)
);
drop table candidates;

CREATE TABLE vote_results (
    name         VARCHAR2(100),
    prc          NUMBER(5, 2),
    is_finished  INTEGER
);
--drop table vote_results;


CREATE OR REPLACE PROCEDURE candidates_results IS
    coef NUMBER(5, 4);
BEGIN
    FOR z IN 1..4 LOOP INSERT INTO candidates ( name, prc ) VALUES (( dbms_random.string('a', 10) ), round((dbms_random.value * 100), 2));
END LOOP;

SELECT ( 100 / SUM(prc) ) INTO coef
    FROM candidates;
    UPDATE candidates
    SET prc = prc * coef;

    FOR i IN ( SELECT name,prc FROM(SELECT name, prc, ROW_NUMBER() OVER( ORDER BY prc DESC ) row_num
    FROM candidates)
    WHERE row_num < 3
    ORDER BY prc DESC) LOOP
        IF i.prc > 50 THEN
        INSERT INTO vote_results (name, prc, is_finished) VALUES (i.name,i.prc,1);

    EXIT;
    ELSE
    INSERT INTO vote_results (name, prc, is_finished) VALUES ( i.name,i.prc,0);
    END IF;
    END LOOP;

END candidates_results;


begin candidates_results; end;

select * from candidates;

select * from vote_results;



