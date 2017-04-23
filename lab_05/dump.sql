-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Апр 21 2017 г., 21:14
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

-- --------------------------------------------------------

--
-- Структура таблицы `apartment`
--

CREATE TABLE `apartment` (
  `id_apartment` int(11) NOT NULL,
  `address` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `rooms_count` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `apartment`
--

INSERT INTO `apartment` (`id_apartment`, `address`, `price`, `rooms_count`) VALUES
(1, 'село Вятское, ул. Новикова, дом 3, кв. 34', 1200000, 3),
(2, 'г. Йошкар-Ола, ул. Панфилова, д. 36', 2300000, 2),
(3, 'г. Козьмодемьянск, ул. Гагарина, д. 6', 4000000, 4),
(4, 'с. Оршанка, ул. Рябинина, д. 5', 2500000, 3),
(5, 'п. Советский, ул. Пушкина', 1900000, 3),
(6, 'г. Йошкар-Ола, ул. Строителей, д. 34', 3100000, 4);

-- --------------------------------------------------------

--
-- Структура таблицы `bill`
--

CREATE TABLE `bill` (
  `id_bill` int(11) NOT NULL,
  `id_service_in_apartment` int(11) NOT NULL,
  `id_payment` int(11) NOT NULL,
  `date` date NOT NULL,
  `price` int(11) NOT NULL,
  `owner` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `bill`
--

INSERT INTO `bill` (`id_bill`, `id_service_in_apartment`, `id_payment`, `date`, `price`, `owner`) VALUES
(2, 1, 3, '2017-04-06', 3000, 'Василий'),
(3, 3, 2, '2017-04-20', 4000, 'Михаил'),
(4, 3, 3, '2017-04-09', 5000, 'Иван');

-- --------------------------------------------------------

--
-- Структура таблицы `payment`
--

CREATE TABLE `payment` (
  `id_payment` int(11) NOT NULL,
  `date` date NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `payment`
--

INSERT INTO `payment` (`id_payment`, `date`, `price`) VALUES
(2, '2017-04-05', 3000),
(3, '2017-04-12', 5000),
(4, '2017-04-17', 10000);

-- --------------------------------------------------------

--
-- Структура таблицы `service`
--

CREATE TABLE `service` (
  `id_service` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `provider` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `service`
--

INSERT INTO `service` (`id_service`, `name`, `description`, `provider`) VALUES
(1, 'Газ', 'Поставка газа в дом', 'ОАО "Газораспределение"'),
(2, 'Теплоснабжение', 'Поставка тепла в дом', 'ТЭЦ'),
(3, 'Электроэнергия', 'Поставка электроэнергии в дом', 'ГЭС');

-- --------------------------------------------------------

--
-- Структура таблицы `service_in_apartment`
--

CREATE TABLE `service_in_apartment` (
  `id_service_in_apartment` int(11) NOT NULL,
  `id_apartment` int(11) NOT NULL,
  `id_tariff_service` int(11) NOT NULL,
  `date` date NOT NULL,
  `service_no` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `service_in_apartment`
--

INSERT INTO `service_in_apartment` (`id_service_in_apartment`, `id_apartment`, `id_tariff_service`, `date`, `service_no`) VALUES
(1, 1, 4, '2017-04-06', 4),
(2, 2, 2, '2017-04-06', 6),
(3, 4, 5, '2017-04-19', 3);

-- --------------------------------------------------------

--
-- Структура таблицы `tariff_service`
--

CREATE TABLE `tariff_service` (
  `id_tariff_service` int(11) NOT NULL,
  `id_service` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `tariff_service`
--

INSERT INTO `tariff_service` (`id_tariff_service`, `id_service`, `name`, `description`) VALUES
(1, 1, 'Газ Город', 'Поставка газа с учётом городской обстановки'),
(2, 2, 'Тепло Город', 'Поставка тепла с учётом городской обстановки'),
(3, 3, 'Электроэнергия Город', 'Поставка электроэнергии с учётом городской обстановки'),
(4, 1, 'Газ Посёлок', 'Поставка газа с учётом обстановки в посёлке'),
(5, 2, 'Тепло Посёлок', 'Поставка тепла с учётом обстановки в посёлке'),
(6, 3, 'Электроэнергия Посёлок', 'Поставка электроэнергии с учётом обстановки в посёлке');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `apartment`
--
ALTER TABLE `apartment`
  ADD PRIMARY KEY (`id_apartment`);

--
-- Индексы таблицы `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`id_bill`),
  ADD KEY `id_service_in_apartment` (`id_service_in_apartment`),
  ADD KEY `id_payment` (`id_payment`);

--
-- Индексы таблицы `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id_payment`);

--
-- Индексы таблицы `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`id_service`);

--
-- Индексы таблицы `service_in_apartment`
--
ALTER TABLE `service_in_apartment`
  ADD PRIMARY KEY (`id_service_in_apartment`),
  ADD KEY `id_apartment` (`id_apartment`),
  ADD KEY `id_tariff_service` (`id_tariff_service`);

--
-- Индексы таблицы `tariff_service`
--
ALTER TABLE `tariff_service`
  ADD PRIMARY KEY (`id_tariff_service`),
  ADD KEY `id_service` (`id_service`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `apartment`
--
ALTER TABLE `apartment`
  MODIFY `id_apartment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT для таблицы `bill`
--
ALTER TABLE `bill`
  MODIFY `id_bill` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT для таблицы `payment`
--
ALTER TABLE `payment`
  MODIFY `id_payment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT для таблицы `service`
--
ALTER TABLE `service`
  MODIFY `id_service` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `service_in_apartment`
--
ALTER TABLE `service_in_apartment`
  MODIFY `id_service_in_apartment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `tariff_service`
--
ALTER TABLE `tariff_service`
  MODIFY `id_tariff_service` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `bill`
--
ALTER TABLE `bill`
  ADD CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`id_service_in_apartment`) REFERENCES `service_in_apartment` (`id_service_in_apartment`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bill_ibfk_2` FOREIGN KEY (`id_payment`) REFERENCES `payment` (`id_payment`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `service_in_apartment`
--
ALTER TABLE `service_in_apartment`
  ADD CONSTRAINT `service_in_apartment_ibfk_1` FOREIGN KEY (`id_apartment`) REFERENCES `apartment` (`id_apartment`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `service_in_apartment_ibfk_2` FOREIGN KEY (`id_tariff_service`) REFERENCES `tariff_service` (`id_tariff_service`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `tariff_service`
--
ALTER TABLE `tariff_service`
  ADD CONSTRAINT `tariff_service_ibfk_1` FOREIGN KEY (`id_service`) REFERENCES `service` (`id_service`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
