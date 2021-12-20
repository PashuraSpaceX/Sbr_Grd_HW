-- Для каждого города посчитать:
-- количество гласных букв в написании города !Готово!
-- минимальное количество пробелов 
-- максимальное количество пробелов
--Москва 2 0 3
--Севастополь 4 2 2
--Тверь 1 4 5

create table cities(name varchar2(100));
insert into cities(name) values('Москва   ');
insert into cities(name) values('Москва');
insert into cities(name) values('Москва ');
insert into cities(name) values('Тверь    ');
insert into cities(name) values('Тверь     ');
insert into cities(name) values('Севастополь  ');

select name, glasnye, min(probel), max(probel) from
(SELECT
    replace(name, ' ') as name,
    length(replace(translate(lower(name), 'бвгджзйклмнпрстфхцчшщьъ', '	'), ' ')) as glasnye,
    regexp_count(name, ' ') as probel
FROM
    cities)
group by name, glasnye
order by name;
