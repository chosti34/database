-- 4.1 �������� ���������� �� ������ ���� � id = 1 (������� ����������� � ��������� ����)
SELECT payment.id_payment, bill.id_bill, payment.date, payment.price, payment.payer, bill.owner FROM payment
LEFT OUTER JOIN bill ON payment.id_bill = bill.id_bill WHERE bill.id_bill = 1;

+----+-------------+---------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
| id | select_type | table   | partitions | type  | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
+----+-------------+---------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | bill    | NULL       | const | PRIMARY       | PRIMARY | 4       | const |    1 |   100.00 | NULL  |
|  1 | SIMPLE      | payment | NULL       | ref   | id_bill       | id_bill | 4       | const |    3 |   100.00 | NULL  |
+----+-------------+---------+------------+-------+---------------+---------+---------+-------+------+----------+-------+

-- 4.2 �������� ���������� �� ������ ���� � id = 1 (������� ����������� � ��������� ����)
SELECT payment.id_payment, bill.id_bill, payment.date, payment.price, payment.payer, bill.owner FROM bill
RIGHT OUTER JOIN payment ON payment.id_bill = bill.id_bill WHERE bill.id_bill = 1;

id	select_type	table	partitions	type	possible_keys	key	key_len	ref	rows	filtered	Extra
1	SIMPLE	bill	    NULL	    const	PRIMARY	PRIMARY	4	const	1	100.00	NULL
1	SIMPLE	payment	    NULL	    ref	    id_bill	id_bill	4	const	3	100.00	NULL

-- 4.3 �������� �����, ������� � ����� ������ ��������, ������� ������� ����� �� ������ 11 ��� 2017 ����
--     ������ ����� 50000 ������
SELECT client.name, client.age, client.job FROM client LEFT OUTER JOIN contract ON client.id_client = contract.id_client
WHERE contract.date >= '2017-05-11' AND contract.price > 50000;

id	select_type	table	partitions	type	possible_keys	key	    key_len	ref	                    rows	    filtered	Extra
1	SIMPLE	contract	NULL	    range	id_client,date	date	7	    NULL	                3	        33.33	    Using index condition; Using where
1	SIMPLE	client	    NULL	    eq_ref	PRIMARY	PRIMARY	4	    inventories.contract.id_client	1	100.00	NULL

-- 4.4 �������� ���������� � ����� �� ����� ����� 10000 ������ ������� ���� �������� ����������� 12 ��� 2017 ����
SELECT * FROM bill LEFT OUTER JOIN contract ON bill.id_contract = contract.id_contract
WHERE bill.price < 10000 AND contract.date = '2017-05-12';

id	select_type	table	partitions	type	            possible_keys	key	key_len	ref	                    rows	filtered	Extra
1	SIMPLE	contract	NULL	    ref	PRIMARY,date	date	3	const	                                    1	100.00	    Using index condition
1	SIMPLE	bill	    NULL	    ref	id_contract,price	id_contract	4	inventories.contract.id_contract	1	50.00	    Using where

-- 4.5 �������� ���������� � ���������� � ����� �� ����� ����� 9000 ������ ����������� � 1 ����� 2017 ����
--     ������ � �������� �� 40 ���
SELECT * FROM contract LEFT OUTER JOIN bill ON contract.id_contract = bill.id_contract
LEFT OUTER JOIN client ON contract.id_client = client.id_client
WHERE bill.price >= 9000 AND client.age >= 40 AND contract.date >= '2017-03-01';

id	select_type	table	partitions	type	possible_keys	        key	key_len	ref	                                        rows	filtered	                Extra
1	SIMPLE	contract	NULL	    range	PRIMARY,id_client,date	date	3	NULL	                                    159	    100.00	                    Using index condition
1	SIMPLE	bill	    NULL	    ref	id_contract,price	        id_contract	4	inventories.contract.id_contract	    1	    10.16	                    Using where
1	SIMPLE	client	    NULL	    eq_ref	PRIMARY	PRIMARY	4	    inventories.contract.id_client	1	33.33	Using where

-- 4.6 �������� ���������� � ���������� ������� ���� ��������� ��� 1-�� ���������
SELECT * FROM contract WHERE id_contract IN
(SELECT id_contract FROM inventory_in_contract WHERE id_inventory = 1);

id	select_type	table	partitions	type	    possible_keys	key	key_len	ref	rows	filtered	Extra
1	SIMPLE	<subquery2>	NULL	    ALL	NULL	NULL	NULL	NULL	NULL	100.00	NULL
1	SIMPLE	contract	NULL	    eq_ref	PRIMARY	PRIMARY	4	<subquery2>.id_contract	1	100.00	NULL
2	MATERIALIZED	    inventory_in_contract	NULL	ref	id_inventory,id_contract	id_inventory	4	const	1	100.00	NULL

-- 4.7 �������� ���������� �� ������� ����� �� ����� 10000 ������
SELECT * FROM payment WHERE id_bill IN
(SELECT id_bill FROM bill WHERE price = 10000);

id	select_type	table	partitions	type	possible_keys	key	key_len	ref	rows	filtered	Extra
1	SIMPLE	bill	NULL	ref	PRIMARY,price	price	4	const	2	100.00	Using index
1	SIMPLE	payment	NULL	ref	id_bill	id_bill	4	inventories.bill.id_bill	1	100.00	NULL

-- 4.8 �������� ���������� ��� ���� �������� � ��������������� ���� �� ��������
SELECT * FROM client WHERE age = 25 ORDER BY age;

id	select_type	table	partitions	type	possible_keys	key	key_len	ref	rows	filtered	Extra
1	SIMPLE	client	NULL	ref	age_name_idx	age_name_idx	4	const	469	100.00	NULL

-- 4.9 �������� ���������� ��� ���� �������� � ��������������� ���� �� �������� � � ���������� �������
SELECT * FROM client WHERE age = 21 ORDER BY age, name;

id	select_type	table	partitions	type	possible_keys	key	key_len	ref	rows	filtered	Extra
1	SIMPLE	client	NULL	ref	age_name_idx	age_name_idx	4	const	484	100.00	Using index condition

