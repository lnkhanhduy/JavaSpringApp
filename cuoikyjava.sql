-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 17, 2022 lúc 03:20 PM
-- Phiên bản máy phục vụ: 10.4.24-MariaDB
-- Phiên bản PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `cuoikyjava`
--
CREATE DATABASE IF NOT EXISTS `cuoikyjava` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `cuoikyjava`;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `account`
--

DROP TABLE IF EXISTS `account`;
CREATE TABLE IF NOT EXISTS `account` (
  `username` varchar(100) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(1000) NOT NULL,
  `role` varchar(20) NOT NULL DEFAULT 'user',
  PRIMARY KEY (`username`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `account`
--

INSERT INTO `account` (`username`, `fullname`, `email`, `password`, `role`) VALUES
('admin', 'Lê Nguyễn Khánh Duy', 'admin@gmail.com', '1000:15db8edcb1d6010fff9042b5e8f5b4c5:b2c4ed38de561392e8189b33853349b68ec5a207b4ef29ee1751644e16c1043cfc42cc8e8f776457fbe52d02fd0368b9ca57661b34f3e846d1754f84c01407f0', 'admin'),
('lnkhanhduy', 'Lê Nguyễn Khánh Duy', 'khanhduyhby731@gmail.com', '1000:fb2140ebc82145c78d19ecb8221f81d7:4d0d2e1162b89c45e1efd70719fc6892404c963c80cbbb3dff6d26914da73c4f6e5d97633ce061f17ece70c8b33dbdf0ccd189cffd0ca853f595a8e79da89953', 'user');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart`
--

DROP TABLE IF EXISTS `cart`;
CREATE TABLE IF NOT EXISTS `cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idFlower` int(11) NOT NULL,
  `nameFlower` varchar(100) NOT NULL,
  `quantityFlower` int(11) NOT NULL,
  `priceFlower` int(11) NOT NULL,
  `imageFlower` varchar(500) NOT NULL,
  `username` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `total` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `flower`
--

DROP TABLE IF EXISTS `flower`;
CREATE TABLE IF NOT EXISTS `flower` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `price` int(11) NOT NULL,
  `description` varchar(500) NOT NULL,
  `quantity` int(11) NOT NULL,
  `category` varchar(100) NOT NULL,
  `image1` varchar(500) DEFAULT NULL,
  `image2` varchar(500) DEFAULT NULL,
  `image3` varchar(500) DEFAULT NULL,
  `image4` varchar(500) DEFAULT NULL,
  `image5` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `flower`
--

INSERT INTO `flower` (`id`, `name`, `price`, `description`, `quantity`, `category`, `image1`, `image2`, `image3`, `image4`, `image5`) VALUES
(1, 'Hoa sinh nhật - Chuyện yêu', 600000, 'Hoa sinh nhật - Chuyện yêu', 50, 'Hoa sinh nhật', '17-12-2022 21-01-43 13376_chuyen-yeu.jpg', NULL, NULL, NULL, NULL),
(2, 'Hoa sinh nhật - Tình đầu thơ ngây', 400000, 'Hoa sinh nhật - Tình đầu thơ ngây', 100, 'Hoa sinh nhật', '17-12-2022 21-02-19 13262_tinh-dau-tho-ngay.jpg', NULL, NULL, NULL, NULL),
(3, 'Hoa chúc mừng - Congrats', 450000, 'Hoa chúc mừng - Congrats', 50, 'Hoa chúc mừng', '17-12-2022 21-03-17 13237_congrats.jpg', NULL, NULL, NULL, NULL),
(4, 'Hoa chúc mừng - Kệ Chúc Mừng', 800000, 'Hoa chúc mừng - Kệ Chúc Mừng', 50, 'Hoa chúc mừng', '17-12-2022 21-03-57 13150_ke-chuc-mung.jpg', NULL, NULL, NULL, NULL),
(5, 'Hoa tình yêu - Luôn bên em', 499000, 'Hoa tình yêu - Luôn bên em', 50, 'Hoa tình yêu', '17-12-2022 21-18-09 8524_all-of-love.jpg', NULL, NULL, NULL, NULL),
(6, 'Hoa tình yêu -Chung đôi', 1099000, 'Hoa tình yêu -Chung đôi', 50, 'Hoa tình yêu', '17-12-2022 21-06-50 BOUQUET4216_June-500x500.jpg', NULL, NULL, NULL, NULL),
(7, 'Hoa khai trương - Song hành', 700000, 'Hoa khai trương - Song hành', 100, 'Hoa khai trương', '17-12-2022 21-07-58 12889_song-hanh.jpg', NULL, NULL, NULL, NULL),
(8, 'Hoa khai trương - Tươi sáng', 800000, 'Hoa khai trương - Tươi sáng', 100, 'Hoa khai trương', '17-12-2022 21-08-43 4048_tuoi-sang.png', NULL, NULL, NULL, NULL),
(9, 'Hoa đám cưới - Congrats mini size', 950000, 'Hoa đám cưới - Congrats mini size', 50, 'Hoa đám cưới', '17-12-2022 21-11-44 13369_congrats-mini-size.png', NULL, NULL, NULL, NULL),
(10, 'Hoa đám cưới - Trăm năm hạnh phúc', 2000000, 'Hoa đám cưới - Trăm năm hạnh phúc', 30, 'Hoa đám cưới', '17-12-2022 21-13-47 13113_dinh-cao.jpg', NULL, NULL, NULL, NULL),
(11, 'Hoa ngoại nhập - Luxury vase', 2200000, 'Hoa ngoại nhập - Luxury vase', 20, 'Hoa ngoại nhập', '17-12-2022 21-15-29 12577_luxury-vase.jpg', NULL, NULL, NULL, NULL),
(12, 'Hoa ngoại nhập - Premium vase', 3000000, 'Hoa ngoại nhập - Premium vase', 10, 'Hoa ngoại nhập', '17-12-2022 21-17-05 13309_premium-vase.jpg', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orderflower`
--

DROP TABLE IF EXISTS `orderflower`;
CREATE TABLE IF NOT EXISTS `orderflower` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idOrder` varchar(100) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phonenumber` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `idFlower` int(11) NOT NULL,
  `nameFlower` varchar(100) NOT NULL,
  `quantityFlower` int(11) NOT NULL,
  `totalPriceFlower` int(11) NOT NULL,
  `status` varchar(100) NOT NULL,
  `shipment` varchar(100) NOT NULL,
  `payment` varchar(100) NOT NULL,
  `priceShipment` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `timeOrder` varchar(100) NOT NULL,
  `timeResponse` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
