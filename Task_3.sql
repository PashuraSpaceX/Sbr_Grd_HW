��������� �����:
������, ���������� ���������, ����� ���������, ���������� ��������, ����� ��������. ����������� �� ����� �������.
������ ����������
����������� 2 1205846,15  0 0
������  0 0 0 0
������  0 0 2 789246,4
��������� 2 95945,57  1 67,32
�������  1 123,45  2 99179,45


create table bank_clients(client_name varchar2(100));
insert into bank_clients(client_name) values('���������');
insert into bank_clients(client_name) values('������');
insert into bank_clients(client_name) values('�����������');
insert into bank_clients(client_name) values('������');
insert into bank_clients(client_name) values('�������');

create table bank_deposits(client_name varchar2(100), deposit_id integer, deposit_amount number(18,2));
insert into bank_deposits(client_name, deposit_id, deposit_amount) values('���������', 1, 88489.32);
insert into bank_deposits(client_name, deposit_id, deposit_amount) values('���������', 2, 7456.25);
insert into bank_deposits(client_name, deposit_id, deposit_amount) values('�����������', 3, 456990.15);
insert into bank_deposits(client_name, deposit_id, deposit_amount) values('�����������', 4, 748856.00);
insert into bank_deposits(client_name, deposit_id, deposit_amount) values('�������', 5, 123.45);


create table bank_credits(client_name varchar2(100), credit_id integer, credit_amount number(18,2));
insert into bank_credits(client_name, credit_id, credit_amount) values('���������', 1, 67.32);
insert into bank_credits(client_name, credit_id, credit_amount) values('������', 2, 742256.25);
insert into bank_credits(client_name, credit_id, credit_amount) values('������', 3, 46990.15);
insert into bank_credits(client_name, credit_id, credit_amount) values('�������', 4, 56.00);
insert into bank_credits(client_name, credit_id, credit_amount) values('�������', 5, 99123.45);


SELECT
    a.client_name,
    nvl(d.num_deposits, 0) AS num_deposits,
    nvl(d.sum_deposits, 0) AS sum_deposits,
    nvl(c.num_credits, 0)  AS num_credits,
    nvl(c.sum_credits, 0)  AS sum_credits
FROM
    bank_clients a,
    (SELECT client_name,
            COUNT(deposit_id)   AS num_deposits,
            SUM(deposit_amount) AS sum_deposits
     FROM bank_deposits
     GROUP BY client_name)  d,
    (SELECT client_name,
            COUNT(credit_id)   AS num_credits,
            SUM(credit_amount) AS sum_credits
     FROM bank_credits
     GROUP BY client_name)  c
     WHERE a.client_name = d.client_name (+)
     AND a.client_name = c.client_name (+)
    ORDER BY a.client_name
