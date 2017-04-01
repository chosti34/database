-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Апр 01 2017 г., 11:26
-- Версия сервера: 5.7.14
-- Версия PHP: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `telephones`
--

-- --------------------------------------------------------

--
-- Структура таблицы `payment`
--

CREATE TABLE `payment` (
  `id_payment` int(11) NOT NULL,
  `date` date NOT NULL,
  `money_amount` int(11) NOT NULL,
  `id_service` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `service`
--

CREATE TABLE `service` (
  `id_service` int(11) NOT NULL,
  `total_revenue` int(11) NOT NULL,
  `address` varchar(255) NOT NULL,
  `time_spend` time NOT NULL,
  `id_telephone_in_service` int(11) NOT NULL,
  `id_payment` int(11) NOT NULL,
  `id_service_type` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `service_type`
--

CREATE TABLE `service_type` (
  `id_service_type` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `short_description` text NOT NULL,
  `cost` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `telephone`
--

CREATE TABLE `telephone` (
  `id_telephone` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `tariff_plan` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `IMEI` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `telephone_in_service`
--

CREATE TABLE `telephone_in_service` (
  `id_telephone_in_service` int(11) NOT NULL,
  `id_telephone` int(11) NOT NULL,
  `id_service` int(11) NOT NULL,
  `defect_description` varchar(255) NOT NULL,
  `defect_date` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Индексы сохранённых таблиц
--

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
-- Индексы таблицы `service_type`
--
ALTER TABLE `service_type`
  ADD PRIMARY KEY (`id_service_type`);

--
-- Индексы таблицы `telephone`
--
ALTER TABLE `telephone`
  ADD PRIMARY KEY (`id_telephone`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `payment`
--
ALTER TABLE `payment`
  MODIFY `id_payment` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `service`
--
ALTER TABLE `service`
  MODIFY `id_service` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `service_type`
--
ALTER TABLE `service_type`
  MODIFY `id_service_type` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `telephone`
--
ALTER TABLE `telephone`
  MODIFY `id_telephone` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
