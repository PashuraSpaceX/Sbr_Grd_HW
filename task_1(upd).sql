-- ��� ������� ������ ���������:
-- ���������� ������� ���� � ��������� ������ !������!
-- ����������� ���������� �������� 
-- ������������ ���������� ��������
--������ 2 0 3
--����������� 4 2 2
--����� 1 4 5

create table cities(name varchar2(100));
insert into cities(name) values('������   ');
insert into cities(name) values('������');
insert into cities(name) values('������ ');
insert into cities(name) values('�����    ');
insert into cities(name) values('�����     ');
insert into cities(name) values('�����������  ');

select name, glasnye, min(probel), max(probel) from
(SELECT
    replace(name, ' ') as name,
    length(replace(translate(lower(name), '�����������������������', '	'), ' ')) as glasnye,
    regexp_count(name, ' ') as probel
FROM
    cities)
group by name, glasnye
order by name;
