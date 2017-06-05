-- Вариант 11
-- 1) Выдать информацию о клиентах гостиницы “Алтай”, проживающих в номерах категории “люкс”.
SELECT client.id_client, client.name, client.telephone FROM client
    INNER JOIN settle
      ON client.id_client = settle.id_client
    INNER JOIN room
      ON settle.id_room = room.id_room
    INNER JOIN room_type
      ON room.id_room_type = room_type.id_room_type
    INNER JOIN hotel
      ON room.id_hotel = hotel.id_hotel
WHERE hotel.name = "Алтай" AND room_type.name = "Люкс";

-- 2) Дать список свободных номеров всех гостиниц на 30.05.12.
SELECT DISTINCT hotel.name, room.number, room.id_room FROM room
  LEFT OUTER JOIN settle
    ON room.id_room = settle.id_room
  INNER JOIN hotel
    ON room.id_hotel = hotel.id_hotel
WHERE room.id_room NOT IN (SELECT settle.id_room FROM settle WHERE settle.date_in <= '2012-05-30' AND
                                  settle.date_out >= '2012-05-30');

-- 3) Дать количество проживающих в гостинице “Восток” на 25.05.12 по каждому номеру,
--    где зарегистрировано более двух клиентов.
SELECT room.number, COUNT(settle.id_room) FROM room
  INNER JOIN settle
    ON room.id_room = settle.id_room
  INNER JOIN hotel
    ON room.id_hotel = hotel.id_hotel
WHERE '2012-05-25' BETWEEN settle.date_in AND settle.date_out
GROUP BY settle.id_room HAVING COUNT(settle.id_room) > 2;

-- 4) Дать список последних проживавших клиентов по всем комнатам гостиницы “Космос”,
--    выехавшим в апреле 2012 с указанием даты выезда. Если комната не была занята,
--    выдать в полях фамилии клиента и даты NULL.
SELECT room.id_room,
       (CASE
         WHEN settle.date_out NOT BETWEEN '2012-04-01' AND '2012-04-30' THEN NULL
         ELSE client.name
        END) AS client_name,
       (CASE
         WHEN settle.date_out NOT BETWEEN '2012-04-01' AND '2012-04-30' THEN NULL
         ELSE settle.date_out
        END) AS date_out
FROM room
  INNER JOIN hotel
    ON room.id_hotel = hotel.id_hotel
  LEFT OUTER JOIN settle
    ON settle.id_room = room.id_room
  LEFT OUTER JOIN client
    ON settle.id_settle = client.id_client
WHERE hotel.name = 'Космос';

-- 5) Продлить до 30.05.12 дату проживания в гостинице “Сокол” всем клиентам комнат категории “люкс”,
--    которые заселились 15.05.12, а выезжают 28.05.12.
UPDATE settle
  INNER JOIN room
    ON settle.id_room = room.id_room
  INNER JOIN hotel
    ON room.id_hotel = hotel.id_hotel
  INNER JOIN room_type
    ON room.id_room_type = room_type.id_room_type
SET settle.date_out = '2012-05-30'
WHERE hotel.name = 'Сокол' AND room_type.name = 'Люкс' AND
      settle.date_in = '2012-05-15' AND settle.date_out = '2012-05-28';
