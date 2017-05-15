-- 4.1 Получить информацию об оплате чека с id = 1 (включая плательщика и владельца чека)
SELECT payment.id_payment, bill.id_bill, payment.date, payment.price, payment.payer, bill.owner FROM payment
LEFT OUTER JOIN bill ON payment.id_bill = bill.id_bill WHERE bill.id_bill = 1;

+----+-------------+---------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
| id | select_type | table   | partitions | type  | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
+----+-------------+---------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | bill    | NULL       | const | PRIMARY       | PRIMARY | 4       | const |    1 |   100.00 | NULL  |
|  1 | SIMPLE      | payment | NULL       | ref   | id_bill       | id_bill | 4       | const |    3 |   100.00 | NULL  |
+----+-------------+---------+------------+-------+---------------+---------+---------+-------+------+----------+-------+

-- 4.2 Получить информацию об оплате чека с id = 1 (включая плательщика и владельца чека)
SELECT payment.id_payment, bill.id_bill, payment.date, payment.price, payment.payer, bill.owner FROM bill
RIGHT OUTER JOIN payment ON payment.id_bill = bill.id_bill WHERE bill.id_bill = 1;

id	select_type	table	partitions	type	possible_keys	key	key_len	ref	rows	filtered	Extra
1	SIMPLE	bill	    NULL	    const	PRIMARY	PRIMARY	4	const	1	100.00	NULL
1	SIMPLE	payment	    NULL	    ref	    id_bill	id_bill	4	const	3	100.00	NULL

-- 4.3 Получить имена, возраст и место работы клиентов, которые сделали заказ не раньше 11 мая 2017 года
--     суммой более 50000 рублей
SELECT client.name, client.age, client.job FROM client LEFT OUTER JOIN contract ON client.id_client = contract.id_client
WHERE contract.date >= '2017-05-11' AND contract.price > 50000;

id	select_type	table	partitions	type	possible_keys	key	    key_len	ref	                    rows	    filtered	Extra
1	SIMPLE	contract	NULL	    range	id_client,date	date	7	    NULL	                3	        33.33	    Using index condition; Using where
1	SIMPLE	client	    NULL	    eq_ref	PRIMARY	PRIMARY	4	    inventories.contract.id_client	1	100.00	NULL

-- 4.4 Получить информацию о чеках на сумму менее 10000 рублей которые были выписаны контрактами 12 мая 2017 года
SELECT * FROM bill LEFT OUTER JOIN contract ON bill.id_contract = contract.id_contract
WHERE bill.price < 10000 AND contract.date = '2017-05-12';

id	select_type	table	partitions	type	            possible_keys	key	key_len	ref	                    rows	filtered	Extra
1	SIMPLE	contract	NULL	    ref	PRIMARY,date	date	3	const	                                    1	100.00	    Using index condition
1	SIMPLE	bill	    NULL	    ref	id_contract,price	id_contract	4	inventories.contract.id_contract	1	50.00	    Using where

-- 4.5 Получить информацию о контрактах с чеком на сумму более 9000 рублей совершенных с 1 марта 2017 года
--     людьми в возрасте от 40 лет
SELECT * FROM contract LEFT OUTER JOIN bill ON contract.id_contract = bill.id_contract
LEFT OUTER JOIN client ON contract.id_client = client.id_client
WHERE bill.price >= 9000 AND client.age >= 40 AND contract.date >= '2017-03-01';

id	select_type	table	partitions	type	possible_keys	        key	key_len	ref	                                        rows	filtered	                Extra
1	SIMPLE	contract	NULL	    range	PRIMARY,id_client,date	date	3	NULL	                                    159	    100.00	                    Using index condition
1	SIMPLE	bill	    NULL	    ref	id_contract,price	        id_contract	4	inventories.contract.id_contract	    1	    10.16	                    Using where
1	SIMPLE	client	    NULL	    eq_ref	PRIMARY	PRIMARY	4	    inventories.contract.id_client	1	33.33	Using where

-- 4.6 Получить информацию о контрактах которые были заключены для 1-го инвентаря
SELECT * FROM contract WHERE id_contract IN
(SELECT id_contract FROM inventory_in_contract WHERE id_inventory = 1);

id	select_type	table	partitions	type	    possible_keys	key	key_len	ref	rows	filtered	Extra
1	SIMPLE	<subquery2>	NULL	    ALL	NULL	NULL	NULL	NULL	NULL	100.00	NULL
1	SIMPLE	contract	NULL	    eq_ref	PRIMARY	PRIMARY	4	<subquery2>.id_contract	1	100.00	NULL
2	MATERIALIZED	    inventory_in_contract	NULL	ref	id_inventory,id_contract	id_inventory	4	const	1	100.00	NULL

-- 4.7 Получить информацию об оплатах чеков на сумму 10000 рублей
SELECT * FROM payment WHERE id_bill IN
(SELECT id_bill FROM bill WHERE price = 10000);

id	select_type	table	partitions	type	possible_keys	key	key_len	ref	rows	filtered	Extra
1	SIMPLE	bill	NULL	ref	PRIMARY,price	price	4	const	2	100.00	Using index
1	SIMPLE	payment	NULL	ref	id_bill	id_bill	4	inventories.bill.id_bill	1	100.00	NULL

-- 4.8 Получить информацию обо всех клиентах в отсортированном виде по возрасту
SELECT * FROM client WHERE age = 25 ORDER BY age;

id	select_type	table	partitions	type	possible_keys	key	key_len	ref	rows	filtered	Extra
1	SIMPLE	client	NULL	ref	age_name_idx	age_name_idx	4	const	469	100.00	NULL

-- 4.9 Получить информацию обо всех клиентах в отсортированном виде по возрасту и в алфавитном порядке
SELECT * FROM client WHERE age = 21 ORDER BY age, name;

id	select_type	table	partitions	type	possible_keys	key	key_len	ref	rows	filtered	Extra
1	SIMPLE	client	NULL	ref	age_name_idx	age_name_idx	4	const	484	100.00	Using index condition

