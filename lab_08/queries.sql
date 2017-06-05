-- 1. Успешная транзакция
START TRANSACTION;
    UPDATE bill SET bill.price = bill.price + 1000 WHERE bill.id_bill='1';
    UPDATE bill SET bill.price = bill.price - 1000 WHERE bill.id_bill='2';
COMMIT;

-- 2. Транзакция с откатом
START TRANSACTION;
    UPDATE bill SET bill.price = bill.price + 1000 WHERE bill.id_bill='1';
    UPDATE bill SET bill.price = bill.price - 1000 WHERE bill.id_bill='2';
ROLLBACK;
