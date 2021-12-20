���� ������� ������������� �������:

create table classification(unit varchar2(30), name varchar2(200));
insert into classification(unit, name) values('1', '��������');
insert into classification(unit, name) values('1.1', '������������� ����������');
insert into classification(unit, name) values('1.1.1', '���� �������');
insert into classification(unit, name) values('1.1.2', '�������� ������');
insert into classification(unit, name) values('1.2', '������������������');
insert into classification(unit, name) values('1.2.1', '�����');
insert into classification(unit, name) values('1.2.1.1', '����� ���������� �����');
insert into classification(unit, name) values('1.3', '�����������');
insert into classification(unit, name) values('1.3.1', '���');
insert into classification(unit, name) values('1.4', '�������� ��������');
insert into classification(unit, name) values('1.4.1', '������');
insert into classification(unit, name) values('1.4.2', '������');
insert into classification(unit, name) values('1.5', '������');
insert into classification(unit, name) values('1.5.1', '���������');
insert into classification(unit, name) values('1.5.1.1', '������� ������');
insert into classification(unit, name) values('1.5.2', '������������');
insert into classification(unit, name) values('1.5.2.1', '���������� ��������');
insert into classification(unit, name) values('1.5.2.2', '���������� ��������');
insert into classification(unit, name) values('1.6', '���������');
insert into classification(unit, name) values('1.6.1', '����');
insert into classification(unit, name) values('1.6.1.1', '�����������');
insert into classification(unit, name) values('1.6.1.2', '����������');
insert into classification(unit, name) values('1.6.1.2.1', '�������');
insert into classification(unit, name) values('1.7', '�������� ������');
insert into classification(unit, name) values('1.7.1', '�����');
insert into classification(unit, name) values('1.8', '���������� � ��� �������������');
insert into classification(unit, name) values('1.9', '�������� ��� �����������');
insert into classification(unit, name) values('1.9.1', '������� ����');
insert into classification(unit, name) values('1.10', '������������');
insert into classification(unit, name) values('1.10.1', '������');
insert into classification(unit, name) values('1.11', '������������ ��������� ������ �� ���������� ������');
insert into classification(unit, name) values('1.12', '������');
insert into classification(unit, name) values('1.12.1', '���� ����');
insert into classification(unit, name) values('1.13', '��������� ��������� ����');
insert into classification(unit, name) values('1.13.1', '������ �����');
insert into classification(unit, name) values('1.13.2', '������� ���');
insert into classification(unit, name) values('1.14', '������� ������ �� ���');
insert into classification(unit, name) values('1.14.1', '����������');
insert into classification(unit, name) values('1.14.1.1', '���������� �������');
insert into classification(unit, name) values('1.14.1.2', '������');
insert into classification(unit, name) values('2', '��������');
insert into classification(unit, name) values('2.1', '�����');
insert into classification(unit, name) values('2.2', '������������');

�������� ������, ������� �������� �� ������� �������� ������ ���� �� ������� ������������� �� ��������� ��������.

SELECT (unit || ' ' || regexp_replace(sys_connect_by_path(name, '>'), '^>') ) AS result
FROM (SELECT unit, CASE WHEN instr(unit, '.') > 0 THEN regexp_replace(unit, '[.][[:digit:]]+$')
END parent_unit, name FROM classification)
START WITH
    parent_unit IS NULL
CONNECT BY
    PRIOR unit = parent_unit;
    
������ ���������� ����� ���������:
1 ��������
1.1 ��������>������������� ����������
1.1.1 ��������>������������� ����������>���� �������
1.1.2 ��������>������������� ����������>�������� ������
1.10  ��������>������������
1.10.1  ��������>������������>������
1.11  ��������>������������ ��������� ������ �� ���������� ������
1.12  ��������>������
1.12.1  ��������>������>���� ����
1.13  ��������>��������� ��������� ����
1.13.1  ��������>��������� ��������� ����>������ �����
1.13.2  ��������>��������� ��������� ����>������� ���
1.14  ��������>������� ������ �� ���
1.14.1  ��������>������� ������ �� ���>����������
1.14.1.1  ��������>������� ������ �� ���>����������>���������� �������
1.14.1.2  ��������>������� ������ �� ���>����������>������
1.2 ��������>������������������
1.2.1 ��������>������������������>�����
1.2.1.1 ��������>������������������>�����>����� ���������� �����
1.3 ��������>�����������
1.3.1 ��������>�����������>���
1.4 ��������>�������� ��������
1.4.1 ��������>�������� ��������>������
1.4.2 ��������>�������� ��������>������
1.5 ��������>������
1.5.1 ��������>������>���������
1.5.1.1 ��������>������>���������>������� ������
1.5.2 ��������>������>������������
1.5.2.1 ��������>������>������������>���������� ��������
1.5.2.2 ��������>������>������������>���������� ��������
1.6 ��������>���������
1.6.1 ��������>���������>����
1.6.1.1 ��������>���������>����>�����������
1.6.1.2 ��������>���������>����>����������
1.6.1.2.1 ��������>���������>����>����������>�������
1.7 ��������>�������� ������
1.7.1 ��������>�������� ������>�����
1.8 ��������>���������� � ��� �������������
1.9 ��������>�������� ��� �����������
1.9.1 ��������>�������� ��� �����������>������� ����
2 ��������
2.1 ��������>�����
2.2 ��������>������������