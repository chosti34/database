-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Июн 05 2017 г., 08:14
-- Версия сервера: 5.7.14
-- Версия PHP: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `hotels`
--

-- --------------------------------------------------------

--
-- Структура таблицы `client`
--

CREATE TABLE `client` (
  `id_client` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `telephone` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `client`
--

INSERT INTO `client` (`id_client`, `name`, `telephone`) VALUES
(1, 'Николай', '+79122731823'),
(2, 'Валентин', '+712839128319'),
(3, 'Константин', '+7123131231231'),
(4, 'Роман', '+771251766127'),
(5, 'Дмитрий', '+7712635216357'),
(6, 'Владимир', '+798912873918'),
(7, 'Владислав', '+771276351276'),
(8, 'Андрей', '+791232312938');

-- --------------------------------------------------------

--
-- Структура таблицы `hotel`
--

CREATE TABLE `hotel` (
  `id_hotel` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `stars_count` int(1) NOT NULL,
  `address` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `hotel`
--

INSERT INTO `hotel` (`id_hotel`, `name`, `stars_count`, `address`) VALUES
(1, 'Алтай', 5, 'ул. Советская, дом 2'),
(2, 'Москва-Сити', 5, 'Москва-река'),
(3, 'Дубаи', 4, 'ул. Красноармейская'),
(4, 'Сокол', 3, 'ул. Виноградная'),
(5, 'Восток', 5, 'ул. Восточная, дом 3'),
(6, 'Космос', 5, 'ул. Космонавтов, дом 4');

-- --------------------------------------------------------

--
-- Структура таблицы `room`
--

CREATE TABLE `room` (
  `id_room` int(11) NOT NULL,
  `id_hotel` int(11) NOT NULL,
  `id_room_type` int(11) NOT NULL,
  `number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `room`
--

INSERT INTO `room` (`id_room`, `id_hotel`, `id_room_type`, `number`) VALUES
(1, 1, 1, 45),
(2, 1, 2, 34),
(3, 5, 1, 3),
(4, 6, 1, 1),
(5, 6, 3, 2),
(6, 4, 1, 1),
(7, 6, 1, 88888),
(8, 6, 5, 6754);

-- --------------------------------------------------------

--
-- Структура таблицы `room_price`
--

CREATE TABLE `room_price` (
  `id_room_price` int(11) NOT NULL,
  `id_hotel` int(11) NOT NULL,
  `id_room_type` int(11) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `room_price`
--

INSERT INTO `room_price` (`id_room_price`, `id_hotel`, `id_room_type`, `price`) VALUES
(1, 1, 1, 15000);

-- --------------------------------------------------------

--
-- Структура таблицы `room_type`
--

CREATE TABLE `room_type` (
  `id_room_type` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `min_price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `room_type`
--

INSERT INTO `room_type` (`id_room_type`, `name`, `min_price`) VALUES
(1, 'Люкс', 10000),
(2, 'Альфа', 12000),
(3, 'Омега', 9000),
(4, 'Бюджет', 6000),
(5, 'iiiioooo', 900);

-- --------------------------------------------------------

--
-- Структура таблицы `settle`
--

CREATE TABLE `settle` (
  `id_settle` int(11) NOT NULL,
  `id_room` int(11) NOT NULL,
  `id_client` int(11) NOT NULL,
  `date_in` date NOT NULL,
  `date_out` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `settle`
--

INSERT INTO `settle` (`id_settle`, `id_room`, `id_client`, `date_in`, `date_out`) VALUES
(1, 1, 1, '2017-05-03', '2017-05-11'),
(2, 1, 4, '2017-05-03', '2017-05-11'),
(3, 3, 6, '2012-05-25', '2012-05-29'),
(4, 3, 7, '2012-05-25', '2012-05-29'),
(5, 3, 8, '2012-05-24', '2012-05-29'),
(6, 4, 4, '2012-03-26', '2012-04-24'),
(7, 6, 3, '2012-05-15', '2012-05-30'),
(8, 1, 6, '2012-01-30', '2012-07-03'),
(9, 1, 2, '2012-01-13', '2012-07-13'),
(10, 1, 3, '2012-03-01', '2012-08-01'),
(11, 8, 1, '2017-06-06', '2017-06-15'),
(12, 2, 4, '2012-05-22', '2012-06-30');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id_client`);

--
-- Индексы таблицы `hotel`
--
ALTER TABLE `hotel`
  ADD PRIMARY KEY (`id_hotel`);

--
-- Индексы таблицы `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`id_room`),
  ADD KEY `id_hotel` (`id_hotel`),
  ADD KEY `id_room_type` (`id_room_type`);

--
-- Индексы таблицы `room_price`
--
ALTER TABLE `room_price`
  ADD PRIMARY KEY (`id_room_price`),
  ADD KEY `id_hotel` (`id_hotel`,`id_room_type`),
  ADD KEY `id_room_type` (`id_room_type`);

--
-- Индексы таблицы `room_type`
--
ALTER TABLE `room_type`
  ADD PRIMARY KEY (`id_room_type`);

--
-- Индексы таблицы `settle`
--
ALTER TABLE `settle`
  ADD PRIMARY KEY (`id_settle`),
  ADD KEY `id_room` (`id_room`,`id_client`),
  ADD KEY `id_client` (`id_client`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `client`
--
ALTER TABLE `client`
  MODIFY `id_client` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT для таблицы `hotel`
--
ALTER TABLE `hotel`
  MODIFY `id_hotel` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT для таблицы `room`
--
ALTER TABLE `room`
  MODIFY `id_room` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT для таблицы `room_price`
--
ALTER TABLE `room_price`
  MODIFY `id_room_price` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `room_type`
--
ALTER TABLE `room_type`
  MODIFY `id_room_type` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT для таблицы `settle`
--
ALTER TABLE `settle`
  MODIFY `id_settle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `room_ibfk_1` FOREIGN KEY (`id_hotel`) REFERENCES `hotel` (`id_hotel`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `room_ibfk_2` FOREIGN KEY (`id_room_type`) REFERENCES `room_type` (`id_room_type`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `room_price`
--
ALTER TABLE `room_price`
  ADD CONSTRAINT `room_price_ibfk_1` FOREIGN KEY (`id_hotel`) REFERENCES `hotel` (`id_hotel`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `room_price_ibfk_2` FOREIGN KEY (`id_room_type`) REFERENCES `room_type` (`id_room_type`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `settle`
--
ALTER TABLE `settle`
  ADD CONSTRAINT `settle_ibfk_1` FOREIGN KEY (`id_room`) REFERENCES `room` (`id_room`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `settle_ibfk_2` FOREIGN KEY (`id_client`) REFERENCES `client` (`id_client`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
