--������� � ��������������.
--���� ������� � ��������� �� ������.
--�������� ������, ������� ���������� ����� ��������������� ����, ������������� �� ������� ������:
--������ �������� ����� ���� 40817810001234567890 � �������� 1938848.72 RUB
--������ �������� ����� ���� 40817810001234567891 � �������� 1064.00 EUR
--������ ������ ����� ���� 40817810001234567892 � �������� 0.20 USD
drop table acc_blnc;
create table acc_blnc(client_name varchar2(50), account_code number(20), balance number(20,2), currency_code char(3));
insert into acc_blnc(client_name, account_code, balance, currency_code) values('��������', 40817810001234567890, to_number('1938848.72','99999999.99', 'NLS_NUMERIC_CHARACTERS = "."'), 'RUB');
insert into acc_blnc(client_name, account_code, balance, currency_code) values('������', 40817810001234567892, to_number('0.20','9.99', 'NLS_NUMERIC_CHARACTERS = "."'), 'USD');
insert into acc_blnc(client_name, account_code, balance, currency_code) values('��������', 40817810001234567891, to_number('1064.00', '9990.99'), 'EUR');

select * from acc_blnc;

SELECT
    '������'
    || ' '
    || client_name
    || ' '
    || '����� ����'
    || ' '
    || account_code
    || ' '
    || '� ��������'
    || ' '
    || to_char(balance, '9999990.99')
    || ' '
    || currency_code
FROM
    acc_blnc
ORDER BY
    client_name;