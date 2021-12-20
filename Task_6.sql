Дана таблица классификации существ:

create table classification(unit varchar2(30), name varchar2(200));
insert into classification(unit, name) values('1', 'животные');
insert into classification(unit, name) values('1.1', 'принадлежащие Императору');
insert into classification(unit, name) values('1.1.1', 'конь Буцефал');
insert into classification(unit, name) values('1.1.2', 'левретка Земира');
insert into classification(unit, name) values('1.2', 'набальзамированные');
insert into classification(unit, name) values('1.2.1', 'кошки');
insert into classification(unit, name) values('1.2.1.1', 'мумия египетской кошки');
insert into classification(unit, name) values('1.3', 'прирученные');
insert into classification(unit, name) values('1.3.1', 'Лис');
insert into classification(unit, name) values('1.4', 'молочные поросята');
insert into classification(unit, name) values('1.4.1', 'Борька');
insert into classification(unit, name) values('1.4.2', 'Зорька');
insert into classification(unit, name) values('1.5', 'сирены');
insert into classification(unit, name) values('1.5.1', 'дюгоневые');
insert into classification(unit, name) values('1.5.1.1', 'морская корова');
insert into classification(unit, name) values('1.5.2', 'ламантиновые');
insert into classification(unit, name) values('1.5.2.1', 'Амазонский ламантин');
insert into classification(unit, name) values('1.5.2.2', 'карликовый ламантин');
insert into classification(unit, name) values('1.6', 'сказочные');
insert into classification(unit, name) values('1.6.1', 'змеи');
insert into classification(unit, name) values('1.6.1.1', 'одноголовые');
insert into classification(unit, name) values('1.6.1.2', 'трёхголовые');
insert into classification(unit, name) values('1.6.1.2.1', 'Горыныч');
insert into classification(unit, name) values('1.7', 'бродячие собаки');
insert into classification(unit, name) values('1.7.1', 'Шарик');
insert into classification(unit, name) values('1.8', 'включённые в эту классификацию');
insert into classification(unit, name) values('1.9', 'бегающие как сумасшедшие');
insert into classification(unit, name) values('1.9.1', 'курочка Ряба');
insert into classification(unit, name) values('1.10', 'бесчисленные');
insert into classification(unit, name) values('1.10.1', 'комары');
insert into classification(unit, name) values('1.11', 'нарисованные тончайшей кистью из верблюжьей шерсти');
insert into classification(unit, name) values('1.12', 'прочие');
insert into classification(unit, name) values('1.12.1', 'муха цеце');
insert into classification(unit, name) values('1.13', 'разбившие цветочную вазу');
insert into classification(unit, name) values('1.13.1', 'свинка Пеппа');
insert into classification(unit, name) values('1.13.2', 'Дональд Дак');
insert into classification(unit, name) values('1.14', 'похожие издали на мух');
insert into classification(unit, name) values('1.14.1', 'шерстистые');
insert into classification(unit, name) values('1.14.1.1', 'шерстистый носорог');
insert into classification(unit, name) values('1.14.1.2', 'мамонт');
insert into classification(unit, name) values('2', 'растения');
insert into classification(unit, name) values('2.1', 'астра');
insert into classification(unit, name) values('2.2', 'альстромерия');

Написать запрос, который развернёт по каждому существу полный путь от вершины классификации до конечного элемента.

SELECT (unit || ' ' || regexp_replace(sys_connect_by_path(name, '>'), '^>') ) AS result
FROM (SELECT unit, CASE WHEN instr(unit, '.') > 0 THEN regexp_replace(unit, '[.][[:digit:]]+$')
END parent_unit, name FROM classification)
START WITH
    parent_unit IS NULL
CONNECT BY
    PRIOR unit = parent_unit;
    
Должен получиться такой результат:
1 животные
1.1 животные>принадлежащие Императору
1.1.1 животные>принадлежащие Императору>конь Буцефал
1.1.2 животные>принадлежащие Императору>левретка Земира
1.10  животные>бесчисленные
1.10.1  животные>бесчисленные>комары
1.11  животные>нарисованные тончайшей кистью из верблюжьей шерсти
1.12  животные>прочие
1.12.1  животные>прочие>муха цеце
1.13  животные>разбившие цветочную вазу
1.13.1  животные>разбившие цветочную вазу>свинка Пеппа
1.13.2  животные>разбившие цветочную вазу>Дональд Дак
1.14  животные>похожие издали на мух
1.14.1  животные>похожие издали на мух>шерстистые
1.14.1.1  животные>похожие издали на мух>шерстистые>шерстистый носорог
1.14.1.2  животные>похожие издали на мух>шерстистые>мамонт
1.2 животные>набальзамированные
1.2.1 животные>набальзамированные>кошки
1.2.1.1 животные>набальзамированные>кошки>мумия египетской кошки
1.3 животные>прирученные
1.3.1 животные>прирученные>Лис
1.4 животные>молочные поросята
1.4.1 животные>молочные поросята>Борька
1.4.2 животные>молочные поросята>Зорька
1.5 животные>сирены
1.5.1 животные>сирены>дюгоневые
1.5.1.1 животные>сирены>дюгоневые>морская корова
1.5.2 животные>сирены>ламантиновые
1.5.2.1 животные>сирены>ламантиновые>Амазонский ламантин
1.5.2.2 животные>сирены>ламантиновые>карликовый ламантин
1.6 животные>сказочные
1.6.1 животные>сказочные>змеи
1.6.1.1 животные>сказочные>змеи>одноголовые
1.6.1.2 животные>сказочные>змеи>трёхголовые
1.6.1.2.1 животные>сказочные>змеи>трёхголовые>Горыныч
1.7 животные>бродячие собаки
1.7.1 животные>бродячие собаки>Шарик
1.8 животные>включённые в эту классификацию
1.9 животные>бегающие как сумасшедшие
1.9.1 животные>бегающие как сумасшедшие>курочка Ряба
2 растения
2.1 растения>астра
2.2 растения>альстромерия