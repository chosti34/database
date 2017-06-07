-- 1. Успешная транзакция
START TRANSACTION;
    UPDATE bill SET bill.price = bill.price + 1000 WHERE bill.id_bill = '1';
    UPDATE bill SET bill.price = bill.price - 1000 WHERE bill.id_bill = '2';
COMMIT;

-- 2. Транзакция с откатом
START TRANSACTION;
    UPDATE bill SET bill.price = bill.price - 1000 WHERE bill.id_bill = '1';
    UPDATE bill SET bill.price = bill.price - 1000 WHERE bill.id_bill = '1';
ROLLBACK;
    UPDATE bill SET bill.price = bill.price + 2000 WHERE bill.id_bill = '1';
COMMIT;

-- 3. Создать хранимую процедуру с параметрами и вызвать ее
DROP PROCEDURE IF EXISTS GetSum;

DELIMITER //
CREATE PROCEDURE GetSum(IN lhs INT, IN rhs INT, OUT total INT)
BEGIN
    SET total = lhs + rhs;
END //
DELIMITER ;

SET @val = NULL;
CALL GetSum(10, 20, @val);
SELECT @val;

-- 4. Создать триггер и вызвать его
DROP TRIGGER IF EXISTS OnBillDelete;

DELIMITER //
CREATE TRIGGER OnBillDelete BEFORE DELETE ON bill
FOR EACH ROW
BEGIN
    DELETE FROM payment WHERE payment.id_bill = OLD.id_bill;
END //
DELIMITER ;
