-- 1.* SELECT LIMIT/TOP (в MySQL отсутсвует TOP) --

-- 1.1 - получить две первые записи таблицы `apartments` со всеми полями --
SELECT * FROM `apartment` LIMIT 2;

-- 2.* WHERE --

-- 2.1 NULL --
-- получить все записи таблицы `service` где поле `provider` имеет значение равное NULL --
SELECT * FROM `service` WHERE `provider` IS NULL;

-- 2.2 NOT NULL --
-- получить все записи таблицы `service` где поле `provider` имеет значение не равное NULL --
SELECT * FROM `service` WHERE `provider` IS NOT NULL;

-- 2.3 BETWEEN --
-- получить все квартиры, площадь которых находится в пределах от 70 до 80 (кв. м.) --
SELECT * FROM `apartment` WHERE `area` BETWEEN 70 AND 80;

-- 2.4 IN --
-- получить все совершённые оплаты, где сумма платежа равна одному из значений внутри оператора IN --
SELECT * FROM `payment` WHERE `price` IN(10000, 7000, 5000);

-- 2.5 = --
-- получить все трёхкомнатные квартиры --
SELECT * FROM `apartment` WHERE `rooms_count` = 3;

-- 2.6 != -
-- получить все нетрёхкомнатные квартиры --
SELECT * FROM `apartment` WHERE `rooms_count` != 3;

-- 3.* ORDER --

-- 3.1 ASC --
-- получить все записи с квартирами отсортированные по цене по возрастанию --
SELECT * FROM `apartment` ORDER BY `price` ASC;

-- 3.2 DESC --
-- получить все записи с квартирами отсортированные по цене по убыванию --
SELECT * FROM `apartment` ORDER BY `price` DESC;

-- 3.3 по двум аттрибутам --
-- получить все тарифы услуг так, чтобы они были отсортированы по цене по убыванию, и,
-- если цены одинаковы сортировать по имени по возрастанию
SELECT * FROM `tariff_service` ORDER BY `price` DESC, `name` ASC;

-- 3.4 по первому аттрибуту, из списка извлекаемых --
-- получить все квартиры отсортированные по первому полю (id) по убыванию --
SELECT * FROM `apartment` ORDER BY 1 DESC;

-- 4.* Функции агрегации --

-- 4.1 MIN --
-- получить минимальную сумму оплаты коммунального платежа
SELECT MIN(`price`) FROM `payment`;

-- 4.2 MAX --
-- получить максимальную сумму оплаты коммунального платежа
SELECT MAX(`price`) FROM `payment`;

-- 4.3 AVG --
-- получить среднее арифметическое суммы всех оплат коммунальных платежей, не учитывая сумму от Василия --
SELECT AVG(`price`) FROM `payment` WHERE `payer` != 'Василий';

-- 4.4 SUM --
-- получить общую сумму всех оплат коммунальных платежей --
SELECT SUM(`price`) FROM `payment`;

-- 5.* DISTINCT, COUNT --

-- 5.1 DISTINCT --
-- получить всех владельцев квартир которые работают на разных работах (должностях) --
SELECT DISTINCT `job` FROM `apartment_owner`;

-- 5.2 COUNT(DISTINCT) --
-- получить кол-во всех владельцев квартир которые работают на разных работах (должностях) --
SELECT COUNT(DISTINCT `job`) FROM `apartment_owner`;

-- 6.* GROUP BY --

-- 6.1 SUM GROUP BY --
-- получить средние цены за квартиры с определённым кол-вом комнат
SELECT `rooms_count`, AVG(`price`) FROM `apartment` GROUP BY `rooms_count`;

-- 6.2 SUM WHERE GROUP BY
-- получить средние цены за квартиры с определённым кол-вом комнат,
-- игнорируя квартиры с площадью >= 90 (кв. м.)
SELECT `rooms_count`, AVG(`price`) FROM `apartment` WHERE `area` < 90 GROUP BY `rooms_count`;

-- 6.3 SUM GROUP BY HAVING --
-- получить средние цены за квартиры с определённым кол-вом комнат,
-- такие, что цена будет больше 2000000 (HAVING применяется после группировки)
SELECT `rooms_count`, AVG(`price`) FROM `apartment` GROUP BY `rooms_count` HAVING AVG(`price`) > 2000000;
