--Склейка и форматирование.
--Дана таблица с остатками по счетам.
--Написать запрос, который сформирует отчёт нижеприведённого вида, упорядоченный по номерам счетов:
--Клиент Кузнецов имеет счет 40817810001234567890 с остатком 1938848.72 RUB
--Клиент Крыленко имеет счет 40817810001234567891 с остатком 1064.00 EUR
--Клиент Зайцев имеет счет 40817810001234567892 с остатком 0.20 USD
drop table acc_blnc;
create table acc_blnc(client_name varchar2(50), account_code number(20), balance number(20,2), currency_code char(3));
insert into acc_blnc(client_name, account_code, balance, currency_code) values('Кузнецов', 40817810001234567890, to_number('1938848.72','99999999.99', 'NLS_NUMERIC_CHARACTERS = "."'), 'RUB');
insert into acc_blnc(client_name, account_code, balance, currency_code) values('Зайцев', 40817810001234567892, to_number('0.20','9.99', 'NLS_NUMERIC_CHARACTERS = "."'), 'USD');
insert into acc_blnc(client_name, account_code, balance, currency_code) values('Крыленко', 40817810001234567891, to_number('1064.00', '9990.99'), 'EUR');

select * from acc_blnc;

SELECT
    'Клиент'
    || ' '
    || client_name
    || ' '
    || 'имеет счет'
    || ' '
    || account_code
    || ' '
    || 'с остатком'
    || ' '
    || to_char(balance, '9999990.99')
    || ' '
    || currency_code
FROM
    acc_blnc
ORDER BY
    client_name;