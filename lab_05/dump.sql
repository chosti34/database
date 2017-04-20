-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Апр 20 2017 г., 11:10
-- Версия сервера: 5.7.14
-- Версия PHP: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `apartments`
--
CREATE DATABASE IF NOT EXISTS `apartments` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `apartments`;

-- --------------------------------------------------------

--
-- Структура таблицы `apartment`
--

CREATE TABLE `apartment` (
  `id_apartment` int(11) NOT NULL,
  `address` varchar(255) NOT NULL,
  `rooms_count` int(11) NOT NULL,
  `area` int(11) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `apartment`
--

INSERT INTO `apartment` (`id_apartment`, `address`, `rooms_count`, `area`, `price`) VALUES
(1, 'г. Казань, ул. Четаева, 27А, 34', 3, 80, 3400000),
(2, 'г. Йошкар-Ола, ул. Успенская, 198А, 71', 4, 100, 5100000),
(3, 'г. Йошкар-Ола, Ленинский пр., 54А, 8', 3, 70, 4500000);

-- --------------------------------------------------------

--
-- Структура таблицы `apartment_in_communal_service`
--

CREATE TABLE `apartment_in_communal_service` (
  `id_apartment_in_communal_service` int(11) NOT NULL,
  `date` date NOT NULL,
  `id_communal_service_payment` int(11) NOT NULL,
  `id_communal_service` int(11) NOT NULL,
  `id_apartment` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `apartment_in_communal_service`
--

INSERT INTO `apartment_in_communal_service` (`id_apartment_in_communal_service`, `date`, `id_communal_service_payment`, `id_communal_service`, `id_apartment`) VALUES
(1, '2017-04-05', 1, 1, 2),
(2, '2017-04-07', 1, 4, 1),
(3, '2017-04-10', 1, 3, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `communal_payment_tariff`
--

CREATE TABLE `communal_payment_tariff` (
  `id_communal_payment_tariff` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `service_count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `communal_payment_tariff`
--

INSERT INTO `communal_payment_tariff` (`id_communal_payment_tariff`, `name`, `description`, `price`, `service_count`) VALUES
(1, 'Водоснабжение+', 'Повышенная поставка воды', 3000, 4),
(2, 'Газоснабжение+', 'Повышенная поставка газа', 4000, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `communal_service`
--

CREATE TABLE `communal_service` (
  `id_communal_service` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `provider` varchar(255) NOT NULL,
  `id_communal_payment_tariff` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `communal_service`
--

INSERT INTO `communal_service` (`id_communal_service`, `name`, `provider`, `id_communal_payment_tariff`) VALUES
(1, 'Поставка газа', 'ТЭЦ №2', 2),
(2, 'Поставка воды', 'ТЭЦ №2', 1),
(3, 'Поставка электроэнергии', 'ТЭЦ №3', 1),
(4, 'Теплоснабжение', 'ОАО "Марбиофарм"', 1),
(5, 'Поставка электроэнергии', 'ГЭС №1', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `communal_service_payment`
--

CREATE TABLE `communal_service_payment` (
  `id_communal_service_payment` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `payer` varchar(255) NOT NULL,
  `seller` varchar(255) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `communal_service_payment`
--

INSERT INTO `communal_service_payment` (`id_communal_service_payment`, `price`, `payer`, `seller`, `date`) VALUES
(1, 10000, 'Василий', 'ЖКХ г. Йошкар-Ола', '2017-04-18'),
(2, 15000, 'Михаил', 'ЖКХ г. Казань', '2017-04-04'),
(3, 7000, 'Евгений', 'ЖКХ г. Йошкар-Ола', '2017-04-08');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `apartment`
--
ALTER TABLE `apartment`
  ADD PRIMARY KEY (`id_apartment`);

--
-- Индексы таблицы `apartment_in_communal_service`
--
ALTER TABLE `apartment_in_communal_service`
  ADD PRIMARY KEY (`id_apartment_in_communal_service`),
  ADD KEY `id_communal_service_payment` (`id_communal_service_payment`),
  ADD KEY `id_communal_service` (`id_communal_service`),
  ADD KEY `id_apartment` (`id_apartment`);

--
-- Индексы таблицы `communal_payment_tariff`
--
ALTER TABLE `communal_payment_tariff`
  ADD PRIMARY KEY (`id_communal_payment_tariff`);

--
-- Индексы таблицы `communal_service`
--
ALTER TABLE `communal_service`
  ADD PRIMARY KEY (`id_communal_service`),
  ADD KEY `id_communal_payment_tariff` (`id_communal_payment_tariff`);

--
-- Индексы таблицы `communal_service_payment`
--
ALTER TABLE `communal_service_payment`
  ADD PRIMARY KEY (`id_communal_service_payment`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `apartment`
--
ALTER TABLE `apartment`
  MODIFY `id_apartment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `apartment_in_communal_service`
--
ALTER TABLE `apartment_in_communal_service`
  MODIFY `id_apartment_in_communal_service` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `communal_payment_tariff`
--
ALTER TABLE `communal_payment_tariff`
  MODIFY `id_communal_payment_tariff` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `communal_service`
--
ALTER TABLE `communal_service`
  MODIFY `id_communal_service` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT для таблицы `communal_service_payment`
--
ALTER TABLE `communal_service_payment`
  MODIFY `id_communal_service_payment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `apartment_in_communal_service`
--
ALTER TABLE `apartment_in_communal_service`
  ADD CONSTRAINT `apartment_in_communal_service_ibfk_1` FOREIGN KEY (`id_apartment`) REFERENCES `apartment` (`id_apartment`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `apartment_in_communal_service_ibfk_2` FOREIGN KEY (`id_communal_service_payment`) REFERENCES `communal_service_payment` (`id_communal_service_payment`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `apartment_in_communal_service_ibfk_3` FOREIGN KEY (`id_communal_service`) REFERENCES `communal_service` (`id_communal_service`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `communal_service`
--
ALTER TABLE `communal_service`
  ADD CONSTRAINT `communal_service_ibfk_2` FOREIGN KEY (`id_communal_payment_tariff`) REFERENCES `communal_payment_tariff` (`id_communal_payment_tariff`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
