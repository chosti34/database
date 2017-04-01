-- 1.1 --
INSERT INTO telephone VALUES (NULL, 891232123, 'Йота', 'iPhone 3', 12321223);

-- 1.2 --
INSERT INTO payment (id_payment, date, money_amount, id_service) VALUES (NULL, CURRENT_DATE, 1000, 1);

-- 1.3 --
INSERT INTO service (id_service, total_revenue, address, time_spend, id_telephone_in_service, id_payment, id_service_type)
SELECT id_service, 2000, 'г. Москва, ул. Красноармейская, д.3', 3, 1, 1, id_payment FROM payment;


-- 2.1 --
DELETE FROM service_type;

-- 2.2 --
DELETE FROM service_type WHERE cost < 100;

-- 2.3 --
TRUNCATE service_type;


-- 3.1 --
UPDATE service SET total_revenue = 1000;

-- 3.2 --
UPDATE telephone SET model = 'ЙотаФон' WHERE tariff_plan = 'Йота';

-- 3.3 --
UPDATE telephone SET model = 'iPhone', tariff_plan = 'МегаФон' WHERE imei = 12321223;


-- 4.1 --
SELECT id_service, total_revenue, address FROM service;

-- 4.2 --
SELECT * FROM telephone;

-- 4.3 --
SELECT * FROM telephone WHERE tariff_plan = 'МегаФон';
