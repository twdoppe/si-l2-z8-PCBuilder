-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Time: Nov 05 2026 y., 15:24
-- Server version: 10.11.16-MariaDB
-- Version PHP: 8.3.36

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
--  `pckonfig`
--

-- --------------------------------------------------------

--
--  `dyski`
--

CREATE TABLE `dyski` (
  `id` int(11) NOT NULL,
  `producent` varchar(40) NOT NULL,
  `model` varchar(80) NOT NULL,
  `seria` varchar(50) NOT NULL,
  `typ_dysku` varchar(10) NOT NULL COMMENT 'SSD lub HDD',
  `format` varchar(30) NOT NULL COMMENT 'M.2 2280, 2.5 cala, 3.5 cala',
  `interfejs` varchar(20) NOT NULL COMMENT 'NVMe, SATA III',
  `standard_pcie` decimal(2,1) DEFAULT NULL COMMENT 'Wersja PCIe: 3.0, 4.0, 5.0 (NULL dla SATA)',
  `pojemnosc_gb` int(10) UNSIGNED NOT NULL,
  `predkosc_odczytu_mbs` int(10) UNSIGNED DEFAULT NULL COMMENT 'Prędkość sekwencyjna odczytu (MB/s)',
  `predkosc_zapisu_mbs` int(10) UNSIGNED DEFAULT NULL COMMENT 'Prędkość sekwencyjna zapisu (MB/s)',
  `pamiec_cache_mb` int(10) UNSIGNED DEFAULT NULL COMMENT 'DRAM Cache w MB (NULL jeśli DRAM-less lub brak info)',
  `typ_pamieci_nand` varchar(20) DEFAULT NULL COMMENT 'TLC, QLC, MLC (NULL dla HDD)',
  `tbw` int(10) UNSIGNED DEFAULT NULL COMMENT 'Trwałość Total Bytes Written (TBW)',
  `chlodzenie_radiator` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = posiada fabryczny radiator',
  `cena_pln` decimal(8,2) DEFAULT NULL,
  `rok_premiery` smallint(5) UNSIGNED NOT NULL,
  `zrodlo_danych` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
--  `dyski`
--

INSERT INTO `dyski` (`id`, `producent`, `model`, `seria`, `typ_dysku`, `format`, `interfejs`, `standard_pcie`, `pojemnosc_gb`, `predkosc_odczytu_mbs`, `predkosc_zapisu_mbs`, `pamiec_cache_mb`, `typ_pamieci_nand`, `tbw`, `chlodzenie_radiator`, `cena_pln`, `rok_premiery`, `zrodlo_danych`) VALUES
(1, 'Crucial', 'T705', 'T-Series', 'SSD', 'M.2 2280', 'NVMe', 5.0, 2000, 14500, 12700, 2048, 'TLC', 1200, 1, 1699.00, 2024, 'Ceneo / Sklepy PL'),
(2, 'Crucial', 'T705 (bez radiatora)', 'T-Series', 'SSD', 'M.2 2280', 'NVMe', 5.0, 1000, 13600, 10200, 1024, 'TLC', 600, 0, 949.00, 2024, 'Ceneo / Sklepy PL'),
(3, 'ADATA', 'Legend 970', 'Legend', 'SSD', 'M.2 2280', 'NVMe', 5.0, 2000, 10000, 10000, 2048, 'TLC', 1400, 1, 1450.00, 2023, 'Ceneo / Sklepy PL'),
(4, 'Corsair', 'MP700 PRO', 'Force Series', 'SSD', 'M.2 2280', 'NVMe', 5.0, 2000, 12400, 11800, 2048, 'TLC', 1400, 1, 1599.00, 2023, 'Ceneo / Sklepy PL'),
(5, 'Gigabyte', 'AORUS Gen5 12000', 'AORUS', 'SSD', 'M.2 2280', 'NVMe', 5.0, 2000, 12000, 11000, 4096, 'TLC', 1400, 1, 1499.00, 2023, 'Ceneo / Sklepy PL'),
(6, 'MSI', 'Spatium M570 Pro', 'Spatium', 'SSD', 'M.2 2280', 'NVMe', 5.0, 2000, 12400, 11800, 4096, 'TLC', 1400, 1, 1550.00, 2023, 'Ceneo / Sklepy PL'),
(7, 'MSI', 'Spatium M570 Pro', 'Spatium', 'SSD', 'M.2 2280', 'NVMe', 5.0, 1000, 11500, 8500, 2048, 'TLC', 700, 1, 950.00, 2023, 'Ceneo / Sklepy PL'),
(8, 'TeamGroup', 'T-Force Cardea Z540', 'Cardea', 'SSD', 'M.2 2280', 'NVMe', 5.0, 2000, 12000, 10000, 4096, 'TLC', 1400, 0, 1490.00, 2023, 'Ceneo / Sklepy PL'),
(9, 'Corsair', 'MP700', 'Force Series', 'SSD', 'M.2 2280', 'NVMe', 5.0, 1000, 9500, 8500, 2048, 'TLC', 700, 1, 899.00, 2023, 'Ceneo / Sklepy PL'),
(10, 'Corsair', 'MP700', 'Force Series', 'SSD', 'M.2 2280', 'NVMe', 5.0, 2000, 10000, 10000, 4096, 'TLC', 1400, 1, 1399.00, 2023, 'Ceneo / Sklepy PL'),
(11, 'PNY', 'CS3150', 'CS Series', 'SSD', 'M.2 2280', 'NVMe', 5.0, 2000, 12000, 11000, 4096, 'TLC', 1400, 1, 1590.00, 2024, 'Ceneo / Sklepy PL'),
(12, 'Samsung', '990 PRO', 'PRO', 'SSD', 'M.2 2280', 'NVMe', 4.0, 1000, 7450, 6900, 1024, 'TLC', 600, 0, 489.00, 2022, 'Ceneo / Sklepy PL'),
(13, 'Samsung', '990 PRO z radiatorem', 'PRO', 'SSD', 'M.2 2280', 'NVMe', 4.0, 2000, 7450, 6900, 2048, 'TLC', 1200, 1, 849.00, 2022, 'Ceneo / Sklepy PL'),
(14, 'Samsung', '990 PRO', 'PRO', 'SSD', 'M.2 2280', 'NVMe', 4.0, 4000, 7450, 6900, 4096, 'TLC', 2400, 0, 1599.00, 2023, 'Ceneo / Sklepy PL'),
(15, 'WD', 'Black SN850X', 'Black', 'SSD', 'M.2 2280', 'NVMe', 4.0, 1000, 7300, 6300, 1024, 'TLC', 600, 0, 449.00, 2022, 'Ceneo / Sklepy PL'),
(16, 'WD', 'Black SN850X', 'Black', 'SSD', 'M.2 2280', 'NVMe', 4.0, 2000, 7300, 6600, 2048, 'TLC', 1200, 0, 799.00, 2022, 'Ceneo / Sklepy PL'),
(17, 'WD', 'Black SN850X', 'Black', 'SSD', 'M.2 2280', 'NVMe', 4.0, 4000, 7300, 6600, 4096, 'TLC', 2400, 0, 1499.00, 2022, 'Ceneo / Sklepy PL'),
(18, 'Kingston', 'KC3000', 'KC', 'SSD', 'M.2 2280', 'NVMe', 4.0, 1000, 7000, 6000, 1024, 'TLC', 800, 0, 399.00, 2021, 'Ceneo / Sklepy PL'),
(19, 'Kingston', 'KC3000', 'KC', 'SSD', 'M.2 2280', 'NVMe', 4.0, 2000, 7000, 7000, 2048, 'TLC', 1600, 0, 749.00, 2021, 'Ceneo / Sklepy PL'),
(20, 'Kingston', 'Fury Renegade', 'Fury', 'SSD', 'M.2 2280', 'NVMe', 4.0, 2000, 7300, 7000, 2048, 'TLC', 2000, 1, 819.00, 2021, 'Ceneo / Sklepy PL'),
(21, 'Seagate', 'FireCuda 530', 'FireCuda', 'SSD', 'M.2 2280', 'NVMe', 4.0, 1000, 7300, 6000, 1024, 'TLC', 1275, 0, 469.00, 2021, 'Ceneo / Sklepy PL'),
(22, 'ADATA', 'XPG Gammix S70 Blade', 'Gammix', 'SSD', 'M.2 2280', 'NVMe', 4.0, 2000, 7400, 6800, 2048, 'TLC', 1480, 1, 689.00, 2021, 'Ceneo / Sklepy PL'),
(23, 'ADATA', 'Legend 960', 'Legend', 'SSD', 'M.2 2280', 'NVMe', 4.0, 1000, 7400, 6000, 1024, 'TLC', 780, 1, 419.00, 2022, 'Ceneo / Sklepy PL'),
(24, 'Lexar', 'NM800 Pro', 'NM', 'SSD', 'M.2 2280', 'NVMe', 4.0, 1000, 7500, 6300, 1024, 'TLC', 1000, 0, 429.00, 2022, 'Ceneo / Sklepy PL'),
(25, 'Lexar', 'NM800 Pro z radiatorem', 'NM', 'SSD', 'M.2 2280', 'NVMe', 4.0, 2000, 7500, 6500, 2048, 'TLC', 2000, 1, 799.00, 2022, 'Ceneo / Sklepy PL'),
(26, 'Solidigm', 'P44 Pro', 'P-Series', 'SSD', 'M.2 2280', 'NVMe', 4.0, 1000, 7000, 6500, 1024, 'TLC', 750, 0, 419.00, 2022, 'Ceneo / Sklepy PL'),
(27, 'Solidigm', 'P44 Pro', 'P-Series', 'SSD', 'M.2 2280', 'NVMe', 4.0, 2000, 7000, 6500, 2048, 'TLC', 1200, 0, 759.00, 2022, 'Ceneo / Sklepy PL'),
(28, 'Lexar', 'NM790', 'NM', 'SSD', 'M.2 2280', 'NVMe', 4.0, 1000, 7400, 6500, NULL, 'TLC', 1000, 0, 349.00, 2023, 'Ceneo / Sklepy PL - HMB zamiast DRAM'),
(29, 'Lexar', 'NM790', 'NM', 'SSD', 'M.2 2280', 'NVMe', 4.0, 2000, 7400, 6500, NULL, 'TLC', 1500, 0, 599.00, 2023, 'Ceneo / Sklepy PL - HMB zamiast DRAM'),
(30, 'WD', 'Black SN770', 'Black', 'SSD', 'M.2 2280', 'NVMe', 4.0, 1000, 5150, 4900, NULL, 'TLC', 600, 0, 329.00, 2022, 'Ceneo / Sklepy PL - Świetny DRAM-less'),
(31, 'WD', 'Black SN770', 'Black', 'SSD', 'M.2 2280', 'NVMe', 4.0, 2000, 5150, 4850, NULL, 'TLC', 1200, 0, 619.00, 2022, 'Ceneo / Sklepy PL - Świetny DRAM-less'),
(32, 'Kingston', 'NV2', 'NV', 'SSD', 'M.2 2280', 'NVMe', 4.0, 1000, 3500, 2100, NULL, 'QLC', 320, 0, 269.00, 2022, 'Ceneo / Sklepy PL - Budżetowy'),
(33, 'Kingston', 'NV2', 'NV', 'SSD', 'M.2 2280', 'NVMe', 4.0, 2000, 3500, 2800, NULL, 'QLC', 640, 0, 489.00, 2022, 'Ceneo / Sklepy PL - Budżetowy'),
(34, 'Crucial', 'P3 Plus', 'P-Series', 'SSD', 'M.2 2280', 'NVMe', 4.0, 1000, 5000, 3600, NULL, 'QLC', 220, 0, 319.00, 2022, 'Ceneo / Sklepy PL'),
(35, 'KIOXIA', 'Exceria Plus G3', 'Exceria', 'SSD', 'M.2 2280', 'NVMe', 4.0, 1000, 5000, 3900, NULL, 'TLC', 400, 0, 299.00, 2023, 'Ceneo / Sklepy PL'),
(36, 'ADATA', 'Legend 850', 'Legend', 'SSD', 'M.2 2280', 'NVMe', 4.0, 1000, 5000, 4500, NULL, 'TLC', 1000, 0, 319.00, 2022, 'Ceneo / Sklepy PL'),
(37, 'KIOXIA', 'Exceria Pro', 'Exceria', 'SSD', 'M.2 2280', 'NVMe', 4.0, 1000, 7300, 6400, 1024, 'TLC', 400, 0, 439.00, 2021, 'Ceneo / Sklepy PL'),
(38, 'KIOXIA', 'Exceria Pro', 'Exceria', 'SSD', 'M.2 2280', 'NVMe', 4.0, 2000, 7300, 6400, 2048, 'TLC', 800, 0, 779.00, 2021, 'Ceneo / Sklepy PL'),
(39, 'Silicon Power', 'XS70', 'XPOWER', 'SSD', 'M.2 2280', 'NVMe', 4.0, 1000, 7300, 6000, 1024, 'TLC', 700, 1, 399.00, 2022, 'Ceneo / Sklepy PL'),
(40, 'Silicon Power', 'XS70', 'XPOWER', 'SSD', 'M.2 2280', 'NVMe', 4.0, 2000, 7300, 6800, 2048, 'TLC', 1400, 1, 689.00, 2022, 'Ceneo / Sklepy PL'),
(41, 'TeamGroup', 'MP44', 'MP', 'SSD', 'M.2 2280', 'NVMe', 4.0, 2000, 7400, 7000, NULL, 'TLC', 1450, 0, 589.00, 2023, 'Ceneo / Sklepy PL'),
(42, 'Patriot', 'Viper VP4300 Lite', 'Viper', 'SSD', 'M.2 2280', 'NVMe', 4.0, 1000, 7400, 6400, NULL, 'TLC', 800, 0, 379.00, 2023, 'Ceneo / Sklepy PL'),
(43, 'Patriot', 'Viper VP4300 Lite', 'Viper', 'SSD', 'M.2 2280', 'NVMe', 4.0, 2000, 7400, 6800, NULL, 'TLC', 1600, 0, 649.00, 2023, 'Ceneo / Sklepy PL'),
(44, 'Samsung', '970 EVO Plus', 'EVO', 'SSD', 'M.2 2280', 'NVMe', 3.0, 1000, 3500, 3300, 1024, 'TLC', 600, 0, 399.00, 2019, 'Zakończona produkcja, wciąż na rynku'),
(45, 'WD', 'Blue SN570', 'Blue', 'SSD', 'M.2 2280', 'NVMe', 3.0, 1000, 3500, 3000, NULL, 'TLC', 600, 0, 289.00, 2021, 'Zastąpiony przez SN580'),
(46, 'Lexar', 'NM620', 'NM', 'SSD', 'M.2 2280', 'NVMe', 3.0, 1000, 3300, 3000, NULL, 'TLC', 500, 0, 259.00, 2021, 'Ceneo / Sklepy PL'),
(47, 'Kingston', 'A2000', 'A-Series', 'SSD', 'M.2 2280', 'NVMe', 3.0, 500, 2200, 2000, 512, 'TLC', 350, 0, 199.00, 2019, 'Zakończona produkcja'),
(48, 'Kingston', 'A2000', 'A-Series', 'SSD', 'M.2 2280', 'NVMe', 3.0, 1000, 2200, 2000, 1024, 'TLC', 600, 0, 299.00, 2019, 'Zakończona produkcja'),
(49, 'KIOXIA', 'Exceria G2', 'Exceria', 'SSD', 'M.2 2280', 'NVMe', 3.0, 1000, 2100, 1700, 1024, 'TLC', 400, 0, 269.00, 2021, 'Ceneo / Sklepy PL'),
(50, 'KIOXIA', 'Exceria G2', 'Exceria', 'SSD', 'M.2 2280', 'NVMe', 3.0, 500, 2100, 1700, 512, 'TLC', 200, 0, 169.00, 2021, 'Ceneo / Sklepy PL'),
(51, 'WD', 'Blue SN570', 'Blue', 'SSD', 'M.2 2280', 'NVMe', 3.0, 500, 3500, 2300, NULL, 'TLC', 300, 0, 199.00, 2021, 'Ceneo / Sklepy PL'),
(52, 'Crucial', 'P3', 'P-Series', 'SSD', 'M.2 2280', 'NVMe', 3.0, 1000, 3500, 3000, NULL, 'QLC', 220, 0, 289.00, 2022, 'Ceneo / Sklepy PL'),
(53, 'Crucial', 'P3', 'P-Series', 'SSD', 'M.2 2280', 'NVMe', 3.0, 2000, 3500, 3000, NULL, 'QLC', 440, 0, 549.00, 2022, 'Ceneo / Sklepy PL'),
(54, 'ADATA', 'XPG SX8200 Pro', 'XPG', 'SSD', 'M.2 2280', 'NVMe', 3.0, 1000, 3500, 3000, 1024, 'TLC', 640, 1, 319.00, 2018, 'Klasyk PCIe 3.0'),
(55, 'Samsung', '870 EVO', 'EVO', 'SSD', '2.5 cala', 'SATA III', NULL, 1000, 560, 530, 1024, 'TLC', 600, 0, 419.00, 2021, 'Najlepszy w klasie SATA'),
(56, 'Samsung', '870 EVO', 'EVO', 'SSD', '2.5 cala', 'SATA III', NULL, 2000, 560, 530, 2048, 'TLC', 1200, 0, 749.00, 2021, 'Najlepszy w klasie SATA'),
(57, 'Crucial', 'MX500', 'MX', 'SSD', '2.5 cala', 'SATA III', NULL, 1000, 540, 510, 1024, 'TLC', 360, 0, 349.00, 2018, 'Klasyk TLC z DRAM Cache'),
(58, 'Crucial', 'BX500', 'BX', 'SSD', '2.5 cala', 'SATA III', NULL, 1000, 540, 500, NULL, 'QLC', 360, 0, 289.00, 2018, 'Budżetowy DRAM-less'),
(59, 'Kingston', 'A400', 'A-Series', 'SSD', '2.5 cala', 'SATA III', NULL, 960, 500, 450, NULL, 'TLC', 300, 0, 269.00, 2017, 'Jeden z najtańszych 1TB'),
(60, 'Goodram', 'CX400 gen. 2', 'CX', 'SSD', '2.5 cala', 'SATA III', NULL, 512, 550, 500, NULL, 'TLC', 350, 0, 159.00, 2020, 'Budżetowy polski dysk'),
(61, 'ADATA', 'SU650', 'SU', 'SSD', '2.5 cala', 'SATA III', NULL, 512, 520, 450, NULL, 'TLC', 280, 0, 155.00, 2018, 'Ceneo / Sklepy PL'),
(62, 'Patriot', 'P210', 'P-Series', 'SSD', '2.5 cala', 'SATA III', NULL, 512, 520, 430, NULL, 'TLC', 240, 0, 139.00, 2020, 'Ceneo / Sklepy PL'),
(63, 'Patriot', 'P210', 'P-Series', 'SSD', '2.5 cala', 'SATA III', NULL, 1000, 520, 430, NULL, 'TLC', 480, 0, 249.00, 2020, 'Ceneo / Sklepy PL'),
(64, 'Patriot', 'Burst Elite', 'Burst', 'SSD', '2.5 cala', 'SATA III', NULL, 480, 450, 320, NULL, 'TLC', 400, 0, 129.00, 2021, 'Ceneo / Sklepy PL'),
(65, 'Kingston', 'KC600', 'KC', 'SSD', '2.5 cala', 'SATA III', NULL, 1024, 550, 520, 1024, 'TLC', 600, 0, 389.00, 2019, 'Ceneo / Sklepy PL'),
(66, 'WD', 'Blue SA510', 'Blue', 'SSD', '2.5 cala', 'SATA III', NULL, 1000, 560, 520, NULL, 'TLC', 400, 0, 349.00, 2022, 'Ceneo / Sklepy PL'),
(67, 'WD', 'Green', 'Green', 'SSD', '2.5 cala', 'SATA III', NULL, 480, 545, 430, NULL, 'TLC', 200, 0, 149.00, 2021, 'Ceneo / Sklepy PL'),
(68, 'KIOXIA', 'Exceria SATA', 'Exceria', 'SSD', '2.5 cala', 'SATA III', NULL, 480, 555, 540, NULL, 'TLC', 120, 0, 159.00, 2020, 'Ceneo / Sklepy PL'),
(69, 'Seagate', 'BarraCuda', 'BarraCuda', 'HDD', '3.5 cala', 'SATA III', NULL, 2000, 220, 220, 256, NULL, NULL, 0, 259.00, 2020, 'Zapis SMR - Magazyn danych'),
(70, 'WD', 'Blue', 'Blue', 'HDD', '3.5 cala', 'SATA III', NULL, 2000, 215, 215, 256, NULL, NULL, 0, 269.00, 2021, 'Zapis SMR (seria EZAZ)'),
(71, 'WD', 'Red Plus', 'Red', 'HDD', '3.5 cala', 'SATA III', NULL, 4000, 175, 175, 128, NULL, NULL, 0, 489.00, 2020, 'Zapis CMR - dedykowany do NAS'),
(72, 'Seagate', 'IronWolf', 'IronWolf', 'HDD', '3.5 cala', 'SATA III', NULL, 4000, 202, 202, 256, NULL, NULL, 0, 499.00, 2021, 'Zapis CMR - dedykowany do NAS'),
(73, 'Toshiba', 'P300', 'P-Series', 'HDD', '3.5 cala', 'SATA III', NULL, 2000, 200, 200, 64, NULL, NULL, 0, 289.00, 2019, 'CMR/SMR zależnie od wersji rewizji'),
(74, 'WD', 'Black', 'Black', 'HDD', '3.5 cala', 'SATA III', NULL, 4000, 256, 256, 256, NULL, NULL, 0, 699.00, 2022, 'Najwyższa wydajność HDD 7200 RPM CMR'),
(75, 'Seagate', 'Exos X18', 'Exos', 'HDD', '3.5 cala', 'SATA III', NULL, 18000, 270, 270, 256, NULL, NULL, 0, 1399.00, 2021, 'Dysk Enterprise CMR z Helem'),
(76, 'WD', 'Purple', 'Purple', 'HDD', '3.5 cala', 'SATA III', NULL, 4000, 175, 175, 256, NULL, NULL, 0, 439.00, 2020, 'Do monitoringu CMR'),
(77, 'WD', 'Purple', 'Purple', 'HDD', '3.5 cala', 'SATA III', NULL, 8000, 194, 194, 256, NULL, NULL, 0, 949.00, 2020, 'Do monitoringu CMR'),
(78, 'Seagate', 'SkyHawk', 'SkyHawk', 'HDD', '3.5 cala', 'SATA III', NULL, 4000, 180, 180, 256, NULL, NULL, 0, 459.00, 2020, 'Do monitoringu CMR'),
(79, 'Toshiba', 'N300', 'N-Series', 'HDD', '3.5 cala', 'SATA III', NULL, 8000, 248, 248, 256, NULL, NULL, 0, 899.00, 2021, 'NAS CMR'),
(80, 'Toshiba', 'X300', 'X-Series', 'HDD', '3.5 cala', 'SATA III', NULL, 8000, 260, 260, 256, NULL, NULL, 0, 929.00, 2021, 'High-End Desktop CMR');

-- --------------------------------------------------------

--
--  `karty_graficzne`
--

CREATE TABLE `karty_graficzne` (
  `id` int(11) NOT NULL,
  `producent` varchar(20) NOT NULL,
  `model` varchar(60) NOT NULL,
  `seria` varchar(30) NOT NULL,
  `architektura` varchar(30) NOT NULL,
  `uklad_gpu` varchar(20) NOT NULL,
  `proces_nm` tinyint(3) UNSIGNED DEFAULT NULL,
  `rdzenie_gpu` smallint(5) UNSIGNED DEFAULT NULL COMMENT 'CUDA cores / stream processors / shadery Xe',
  `taktowanie_boost_mhz` smallint(5) UNSIGNED DEFAULT NULL COMMENT 'boost/game clock wg specyfikacji referencyjnej',
  `pamiec_vram_gb` tinyint(3) UNSIGNED NOT NULL,
  `typ_pamieci` varchar(10) NOT NULL,
  `szyna_pamieci_bit` smallint(5) UNSIGNED NOT NULL,
  `pcie_wersja` decimal(2,1) NOT NULL COMMENT 'wersja PCIe karty (3.0/4.0/5.0)',
  `pcie_linie` tinyint(3) UNSIGNED NOT NULL COMMENT 'liczba linii PCIe karty (4/8/16)',
  `tdp_w` smallint(5) UNSIGNED NOT NULL COMMENT 'TGP/TBP referencyjne',
  `zalecany_zasilacz_w` smallint(5) UNSIGNED NOT NULL COMMENT 'min. zasilacz zalecany przez producenta GPU',
  `zlacze_zasilania` varchar(40) NOT NULL,
  `ray_tracing` tinyint(1) NOT NULL,
  `segment_rynku` varchar(20) NOT NULL,
  `rok_premiery` smallint(5) UNSIGNED NOT NULL,
  `cena_rynkowa_pln` decimal(8,2) NOT NULL COMMENT 'aktualna orientacyjna cena rynkowa, PLN'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
--  `karty_graficzne`
--

INSERT INTO `karty_graficzne` (`id`, `producent`, `model`, `seria`, `architektura`, `uklad_gpu`, `proces_nm`, `rdzenie_gpu`, `taktowanie_boost_mhz`, `pamiec_vram_gb`, `typ_pamieci`, `szyna_pamieci_bit`, `pcie_wersja`, `pcie_linie`, `tdp_w`, `zalecany_zasilacz_w`, `zlacze_zasilania`, `ray_tracing`, `segment_rynku`, `rok_premiery`, `cena_rynkowa_pln`) VALUES
(1, 'NVIDIA', 'GeForce GTX 1060 3GB', 'GeForce GTX 10', 'Pascal', 'GP106', 16, 1152, 1708, 3, 'GDDR5', 192, 3.0, 16, 120, 400, '1x 6-pin', 0, 'sredni', 2016, 280.00),
(2, 'NVIDIA', 'GeForce GTX 1060 6GB', 'GeForce GTX 10', 'Pascal', 'GP106', 16, 1280, 1708, 6, 'GDDR5', 192, 3.0, 16, 120, 400, '1x 6-pin', 0, 'sredni', 2016, 320.00),
(3, 'NVIDIA', 'GeForce GTX 1070', 'GeForce GTX 10', 'Pascal', 'GP104', 16, 1920, 1683, 8, 'GDDR5', 256, 3.0, 16, 150, 500, '1x 8-pin', 0, 'wysoki', 2016, 420.00),
(4, 'NVIDIA', 'GeForce GTX 1070 Ti', 'GeForce GTX 10', 'Pascal', 'GP104', 16, 2432, 1683, 8, 'GDDR5', 256, 3.0, 16, 180, 500, '1x 8-pin', 0, 'wysoki', 2017, 480.00),
(5, 'NVIDIA', 'GeForce GTX 1080', 'GeForce GTX 10', 'Pascal', 'GP104', 16, 2560, 1733, 8, 'GDDR5X', 256, 3.0, 16, 180, 500, '1x 8-pin', 0, 'wysoki', 2016, 520.00),
(6, 'NVIDIA', 'GeForce GTX 1080 Ti', 'GeForce GTX 10', 'Pascal', 'GP102', 16, 3584, 1582, 11, 'GDDR5X', 352, 3.0, 16, 250, 600, '6-pin + 8-pin', 0, 'entuzjasta', 2017, 650.00),
(7, 'NVIDIA', 'GeForce GTX 1650', 'GeForce GTX 16', 'Turing', 'TU117', 12, 896, 1665, 4, 'GDDR5', 128, 3.0, 16, 75, 300, 'brak', 0, 'budzetowy', 2019, 380.00),
(8, 'NVIDIA', 'GeForce GTX 1650 GDDR6', 'GeForce GTX 16', 'Turing', 'TU117', 12, 896, 1590, 4, 'GDDR6', 128, 3.0, 16, 75, 300, 'brak', 0, 'budzetowy', 2020, 400.00),
(9, 'NVIDIA', 'GeForce GTX 1650 Super', 'GeForce GTX 16', 'Turing', 'TU116', 12, 1280, 1725, 4, 'GDDR6', 128, 3.0, 16, 100, 350, '1x 6-pin', 0, 'budzetowy', 2019, 420.00),
(10, 'NVIDIA', 'GeForce GTX 1660', 'GeForce GTX 16', 'Turing', 'TU116', 12, 1408, 1785, 6, 'GDDR5', 192, 3.0, 16, 120, 450, '1x 8-pin', 0, 'sredni', 2019, 430.00),
(11, 'NVIDIA', 'GeForce GTX 1660 Super', 'GeForce GTX 16', 'Turing', 'TU116', 12, 1408, 1785, 6, 'GDDR6', 192, 3.0, 16, 125, 450, '1x 8-pin', 0, 'sredni', 2019, 450.00),
(12, 'NVIDIA', 'GeForce GTX 1660 Ti', 'GeForce GTX 16', 'Turing', 'TU116', 12, 1536, 1770, 6, 'GDDR6', 192, 3.0, 16, 120, 450, '1x 8-pin', 0, 'sredni', 2019, 470.00),
(13, 'NVIDIA', 'GeForce GTX 1630', 'GeForce GTX 16', 'Turing', 'TU117', 12, 512, 1785, 4, 'GDDR6', 64, 3.0, 16, 75, 300, 'brak', 0, 'budzetowy', 2022, 250.00),
(14, 'NVIDIA', 'GeForce RTX 2060', 'GeForce RTX 20', 'Turing', 'TU106', 12, 1920, 1680, 6, 'GDDR6', 192, 3.0, 16, 160, 500, '1x 8-pin', 1, 'sredni', 2019, 550.00),
(15, 'NVIDIA', 'GeForce RTX 2060 12GB', 'GeForce RTX 20', 'Turing', 'TU106', 12, 2176, 1650, 12, 'GDDR6', 192, 3.0, 16, 185, 500, '1x 8-pin', 1, 'sredni', 2021, 650.00),
(16, 'NVIDIA', 'GeForce RTX 2060 Super', 'GeForce RTX 20', 'Turing', 'TU106', 12, 2176, 1650, 8, 'GDDR6', 256, 3.0, 16, 175, 550, '1x 8-pin', 1, 'sredni', 2019, 600.00),
(17, 'NVIDIA', 'GeForce RTX 2070', 'GeForce RTX 20', 'Turing', 'TU106', 12, 2304, 1620, 8, 'GDDR6', 256, 3.0, 16, 175, 550, '1x 8-pin', 1, 'wysoki', 2018, 650.00),
(18, 'NVIDIA', 'GeForce RTX 2070 Super', 'GeForce RTX 20', 'Turing', 'TU104', 12, 2560, 1770, 8, 'GDDR6', 256, 3.0, 16, 215, 650, '6-pin + 8-pin', 1, 'wysoki', 2019, 750.00),
(19, 'NVIDIA', 'GeForce RTX 2080', 'GeForce RTX 20', 'Turing', 'TU104', 12, 2944, 1710, 8, 'GDDR6', 256, 3.0, 16, 215, 650, '6-pin + 8-pin', 1, 'wysoki', 2018, 800.00),
(20, 'NVIDIA', 'GeForce RTX 2080 Super', 'GeForce RTX 20', 'Turing', 'TU104', 12, 3072, 1815, 8, 'GDDR6', 256, 3.0, 16, 250, 650, '6-pin + 8-pin', 1, 'wysoki', 2019, 850.00),
(21, 'NVIDIA', 'GeForce RTX 2080 Ti', 'GeForce RTX 20', 'Turing', 'TU102', 12, 4352, 1545, 11, 'GDDR6', 352, 3.0, 16, 250, 650, '2x 8-pin', 1, 'entuzjasta', 2018, 1100.00),
(22, 'NVIDIA', 'GeForce RTX 3050 6GB', 'GeForce RTX 30', 'Ampere', 'GA107', 8, 2304, 1470, 6, 'GDDR6', 96, 4.0, 8, 70, 300, 'brak', 1, 'budzetowy', 2024, 650.00),
(23, 'NVIDIA', 'GeForce RTX 3050 8GB', 'GeForce RTX 30', 'Ampere', 'GA106', 8, 2560, 1777, 8, 'GDDR6', 128, 4.0, 8, 130, 550, '1x 8-pin', 1, 'budzetowy', 2022, 800.00),
(24, 'NVIDIA', 'GeForce RTX 3060', 'GeForce RTX 30', 'Ampere', 'GA106', 8, 3584, 1777, 12, 'GDDR6', 192, 4.0, 16, 170, 550, '1x 8-pin', 1, 'sredni', 2021, 1450.00),
(25, 'NVIDIA', 'GeForce RTX 3060 8GB', 'GeForce RTX 30', 'Ampere', 'GA106', 8, 3584, 1777, 8, 'GDDR6', 128, 4.0, 16, 170, 550, '1x 8-pin', 1, 'sredni', 2022, 1350.00),
(26, 'NVIDIA', 'GeForce RTX 3060 Ti', 'GeForce RTX 30', 'Ampere', 'GA104', 8, 4864, 1665, 8, 'GDDR6', 256, 4.0, 16, 200, 600, '1x 8-pin', 1, 'wysoki', 2020, 1100.00),
(27, 'NVIDIA', 'GeForce RTX 3060 Ti GDDR6X', 'GeForce RTX 30', 'Ampere', 'GA104', 8, 4864, 1665, 8, 'GDDR6X', 256, 4.0, 16, 200, 600, '1x 8-pin', 1, 'wysoki', 2022, 1150.00),
(28, 'NVIDIA', 'GeForce RTX 3070', 'GeForce RTX 30', 'Ampere', 'GA104', 8, 5888, 1725, 8, 'GDDR6', 256, 4.0, 16, 220, 650, '1x 8-pin', 1, 'wysoki', 2020, 1300.00),
(29, 'NVIDIA', 'GeForce RTX 3070 Ti', 'GeForce RTX 30', 'Ampere', 'GA104', 8, 6144, 1770, 8, 'GDDR6X', 256, 4.0, 16, 290, 750, '12-pin (FE) / 2x 8-pin (AIB)', 1, 'wysoki', 2021, 1450.00),
(30, 'NVIDIA', 'GeForce RTX 3080 10GB', 'GeForce RTX 30', 'Ampere', 'GA102', 8, 8704, 1710, 10, 'GDDR6X', 320, 4.0, 16, 320, 750, '12-pin (FE) / 2x-3x 8-pin (AIB)', 1, 'entuzjasta', 2020, 1900.00),
(31, 'NVIDIA', 'GeForce RTX 3080 12GB', 'GeForce RTX 30', 'Ampere', 'GA102', 8, 8960, 1710, 12, 'GDDR6X', 384, 4.0, 16, 350, 750, '12-pin (FE) / 2x-3x 8-pin (AIB)', 1, 'entuzjasta', 2022, 2100.00),
(32, 'NVIDIA', 'GeForce RTX 3080 Ti', 'GeForce RTX 30', 'Ampere', 'GA102', 8, 10240, 1665, 12, 'GDDR6X', 384, 4.0, 16, 350, 750, '12-pin (FE) / 2x-3x 8-pin (AIB)', 1, 'entuzjasta', 2021, 2400.00),
(33, 'NVIDIA', 'GeForce RTX 3090', 'GeForce RTX 30', 'Ampere', 'GA102', 8, 10496, 1695, 24, 'GDDR6X', 384, 4.0, 16, 350, 750, '12-pin (FE) / 2x-3x 8-pin (AIB)', 1, 'entuzjasta', 2020, 2700.00),
(34, 'NVIDIA', 'GeForce RTX 3090 Ti', 'GeForce RTX 30', 'Ampere', 'GA102', 8, 10752, 1860, 24, 'GDDR6X', 384, 4.0, 16, 450, 850, '12VHPWR', 1, 'entuzjasta', 2022, 3200.00),
(35, 'NVIDIA', 'GeForce RTX 4060', 'GeForce RTX 40', 'Ada Lovelace', 'AD107', 5, 3072, 2460, 8, 'GDDR6', 128, 4.0, 8, 115, 550, '1x 8-pin', 1, 'sredni', 2023, 1450.00),
(36, 'NVIDIA', 'GeForce RTX 4060 Ti 8GB', 'GeForce RTX 40', 'Ada Lovelace', 'AD106', 5, 4352, 2535, 8, 'GDDR6', 128, 4.0, 8, 160, 550, '1x 8-pin', 1, 'sredni', 2023, 1700.00),
(37, 'NVIDIA', 'GeForce RTX 4060 Ti 16GB', 'GeForce RTX 40', 'Ada Lovelace', 'AD106', 5, 4352, 2535, 16, 'GDDR6', 128, 4.0, 8, 165, 550, '1x 8-pin', 1, 'sredni', 2023, 1950.00),
(38, 'NVIDIA', 'GeForce RTX 4070', 'GeForce RTX 40', 'Ada Lovelace', 'AD104', 5, 5888, 2475, 12, 'GDDR6X', 192, 4.0, 16, 200, 650, '12VHPWR', 1, 'wysoki', 2023, 2500.00),
(39, 'NVIDIA', 'GeForce RTX 4070 GDDR6', 'GeForce RTX 40', 'Ada Lovelace', 'AD104', 5, 5888, 2475, 12, 'GDDR6', 192, 4.0, 16, 200, 650, '12VHPWR', 1, 'wysoki', 2024, 2450.00),
(40, 'NVIDIA', 'GeForce RTX 4070 Super', 'GeForce RTX 40', 'Ada Lovelace', 'AD104', 5, 7168, 2475, 12, 'GDDR6X', 192, 4.0, 16, 220, 650, '12VHPWR', 1, 'wysoki', 2024, 2900.00),
(41, 'NVIDIA', 'GeForce RTX 4070 Ti', 'GeForce RTX 40', 'Ada Lovelace', 'AD104', 5, 7680, 2610, 12, 'GDDR6X', 192, 4.0, 16, 285, 700, '12VHPWR', 1, 'wysoki', 2023, 3400.00),
(42, 'NVIDIA', 'GeForce RTX 4070 Ti Super', 'GeForce RTX 40', 'Ada Lovelace', 'AD103', 5, 8448, 2610, 16, 'GDDR6X', 256, 4.0, 16, 285, 700, '12VHPWR', 1, 'wysoki', 2024, 3900.00),
(43, 'NVIDIA', 'GeForce RTX 4080', 'GeForce RTX 40', 'Ada Lovelace', 'AD103', 5, 9728, 2505, 16, 'GDDR6X', 256, 4.0, 16, 320, 750, '12VHPWR', 1, 'entuzjasta', 2022, 5200.00),
(44, 'NVIDIA', 'GeForce RTX 4080 Super', 'GeForce RTX 40', 'Ada Lovelace', 'AD103', 5, 10240, 2550, 16, 'GDDR6X', 256, 4.0, 16, 320, 750, '12VHPWR', 1, 'entuzjasta', 2024, 5400.00),
(45, 'NVIDIA', 'GeForce RTX 4090', 'GeForce RTX 40', 'Ada Lovelace', 'AD102', 5, 16384, 2520, 24, 'GDDR6X', 384, 4.0, 16, 450, 850, '12VHPWR', 1, 'entuzjasta', 2022, 9500.00),
(46, 'NVIDIA', 'GeForce RTX 5050', 'GeForce RTX 50', 'Blackwell', 'GB207', 5, 2560, 2572, 8, 'GDDR6', 128, 5.0, 8, 130, 550, '1x 8-pin', 1, 'budzetowy', 2025, 1999.00),
(47, 'NVIDIA', 'GeForce RTX 5060', 'GeForce RTX 50', 'Blackwell', 'GB206', 5, 3840, 2497, 8, 'GDDR7', 128, 5.0, 8, 145, 550, '1x 8-pin', 1, 'sredni', 2025, 2445.00),
(48, 'NVIDIA', 'GeForce RTX 5060 Ti 8GB', 'GeForce RTX 50', 'Blackwell', 'GB206', 5, 4608, 2572, 8, 'GDDR7', 128, 5.0, 8, 180, 600, '1x 8-pin', 1, 'sredni', 2025, 2594.00),
(49, 'NVIDIA', 'GeForce RTX 5060 Ti 16GB', 'GeForce RTX 50', 'Blackwell', 'GB206', 5, 4608, 2572, 16, 'GDDR7', 128, 5.0, 8, 180, 600, '1x 8-pin', 1, 'sredni', 2025, 3482.00),
(50, 'NVIDIA', 'GeForce RTX 5070', 'GeForce RTX 50', 'Blackwell', 'GB205', 5, 6144, 2512, 12, 'GDDR7', 192, 5.0, 16, 250, 650, '12V-2x6', 1, 'wysoki', 2025, 4199.00),
(51, 'NVIDIA', 'GeForce RTX 5070 Ti', 'GeForce RTX 50', 'Blackwell', 'GB203', 5, 8960, 2452, 16, 'GDDR7', 256, 5.0, 16, 300, 750, '12V-2x6', 1, 'wysoki', 2025, 5799.00),
(52, 'NVIDIA', 'GeForce RTX 5080', 'GeForce RTX 50', 'Blackwell', 'GB203', 5, 10752, 2617, 16, 'GDDR7', 256, 5.0, 16, 360, 850, '12V-2x6', 1, 'entuzjasta', 2025, 8125.00),
(53, 'NVIDIA', 'GeForce RTX 5090', 'GeForce RTX 50', 'Blackwell', 'GB202', 5, 21760, 2407, 32, 'GDDR7', 512, 5.0, 16, 575, 1000, '12V-2x6', 1, 'entuzjasta', 2025, 35000.00),
(54, 'AMD', 'Radeon RX 5600 XT', 'Radeon RX 5000', 'RDNA 1', 'Navi 10', 7, 2304, 1560, 6, 'GDDR6', 192, 4.0, 16, 150, 500, '1x 8-pin', 0, 'sredni', 2020, 420.00),
(55, 'AMD', 'Radeon RX 6400', 'Radeon RX 6000', 'RDNA 2', 'Navi 24', 6, 768, 2321, 4, 'GDDR6', 64, 4.0, 4, 53, 350, 'brak', 1, 'budzetowy', 2022, 280.00),
(56, 'AMD', 'Radeon RX 6500 XT', 'Radeon RX 6000', 'RDNA 2', 'Navi 24', 6, 1024, 2815, 4, 'GDDR6', 64, 4.0, 4, 107, 400, '1x 6-pin', 1, 'budzetowy', 2022, 330.00),
(57, 'AMD', 'Radeon RX 6600', 'Radeon RX 6000', 'RDNA 2', 'Navi 23', 7, 1792, 2491, 8, 'GDDR6', 128, 4.0, 8, 132, 450, '1x 8-pin', 1, 'sredni', 2021, 650.00),
(58, 'AMD', 'Radeon RX 6600 XT', 'Radeon RX 6000', 'RDNA 2', 'Navi 23', 7, 2048, 2589, 8, 'GDDR6', 128, 4.0, 8, 160, 500, '1x 8-pin', 1, 'sredni', 2021, 720.00),
(59, 'AMD', 'Radeon RX 6650 XT', 'Radeon RX 6000', 'RDNA 2', 'Navi 23', 7, 2048, 2635, 8, 'GDDR6', 128, 4.0, 8, 180, 500, '1x 8-pin', 1, 'sredni', 2022, 750.00),
(60, 'AMD', 'Radeon RX 6700', 'Radeon RX 6000', 'RDNA 2', 'Navi 22', 7, 2304, 2450, 10, 'GDDR6', 160, 4.0, 16, 175, 550, '1x 8-pin', 1, 'sredni', 2021, 850.00),
(61, 'AMD', 'Radeon RX 6700 XT', 'Radeon RX 6000', 'RDNA 2', 'Navi 22', 7, 2560, 2581, 12, 'GDDR6', 192, 4.0, 16, 230, 650, '6-pin + 8-pin', 1, 'wysoki', 2021, 1000.00),
(62, 'AMD', 'Radeon RX 6750 XT', 'Radeon RX 6000', 'RDNA 2', 'Navi 22', 7, 2560, 2600, 12, 'GDDR6', 192, 4.0, 16, 250, 650, '6-pin + 8-pin', 1, 'wysoki', 2022, 1050.00),
(63, 'AMD', 'Radeon RX 6800', 'Radeon RX 6000', 'RDNA 2', 'Navi 21', 7, 3840, 2105, 16, 'GDDR6', 256, 4.0, 16, 250, 550, '2x 8-pin', 1, 'wysoki', 2020, 1350.00),
(64, 'AMD', 'Radeon RX 6800 XT', 'Radeon RX 6000', 'RDNA 2', 'Navi 21', 7, 4608, 2250, 16, 'GDDR6', 256, 4.0, 16, 300, 750, '2x 8-pin', 1, 'wysoki', 2020, 1600.00),
(65, 'AMD', 'Radeon RX 6900 XT', 'Radeon RX 6000', 'RDNA 2', 'Navi 21', 7, 5120, 2250, 16, 'GDDR6', 256, 4.0, 16, 300, 850, '2x 8-pin', 1, 'entuzjasta', 2020, 1750.00),
(66, 'AMD', 'Radeon RX 6950 XT', 'Radeon RX 6000', 'RDNA 2', 'Navi 21', 7, 5120, 2310, 16, 'GDDR6', 256, 4.0, 16, 335, 850, '2x 8-pin', 1, 'entuzjasta', 2022, 1850.00),
(67, 'AMD', 'Radeon RX 7600', 'Radeon RX 7000', 'RDNA 3', 'Navi 33', 6, 2048, 2655, 8, 'GDDR6', 128, 4.0, 8, 165, 550, '1x 8-pin', 1, 'sredni', 2023, 950.00),
(68, 'AMD', 'Radeon RX 7600 XT', 'Radeon RX 7000', 'RDNA 3', 'Navi 33', 6, 2048, 2755, 16, 'GDDR6', 128, 4.0, 8, 190, 600, '1x 8-pin', 1, 'sredni', 2024, 1150.00),
(69, 'AMD', 'Radeon RX 7700 XT', 'Radeon RX 7000', 'RDNA 3', 'Navi 32', 5, 3456, 2544, 12, 'GDDR6', 192, 4.0, 16, 245, 700, '2x 8-pin', 1, 'wysoki', 2023, 1700.00),
(70, 'AMD', 'Radeon RX 7800 XT', 'Radeon RX 7000', 'RDNA 3', 'Navi 32', 5, 3840, 2430, 16, 'GDDR6', 256, 4.0, 16, 263, 700, '2x 8-pin', 1, 'wysoki', 2023, 1950.00),
(71, 'AMD', 'Radeon RX 7900 GRE', 'Radeon RX 7000', 'RDNA 3', 'Navi 31', 5, 5120, 2245, 16, 'GDDR6', 256, 4.0, 16, 260, 750, '2x 8-pin', 1, 'wysoki', 2024, 2450.00),
(72, 'AMD', 'Radeon RX 7900 XT', 'Radeon RX 7000', 'RDNA 3', 'Navi 31', 5, 5376, 2400, 20, 'GDDR6', 320, 4.0, 16, 315, 750, '2x 8-pin', 1, 'entuzjasta', 2022, 2900.00),
(73, 'AMD', 'Radeon RX 7900 XTX', 'Radeon RX 7000', 'RDNA 3', 'Navi 31', 5, 6144, 2500, 24, 'GDDR6', 384, 4.0, 16, 355, 800, '2x 8-pin', 1, 'entuzjasta', 2022, 3400.00),
(74, 'AMD', 'Radeon RX 9060 XT 8GB', 'Radeon RX 9000', 'RDNA 4', 'Navi 44', 4, 2048, 3130, 8, 'GDDR6', 128, 5.0, 16, 150, 450, '1x 8-pin', 1, 'sredni', 2025, 2050.00),
(75, 'AMD', 'Radeon RX 9060 XT 16GB', 'Radeon RX 9000', 'RDNA 4', 'Navi 44', 4, 2048, 3130, 16, 'GDDR6', 128, 5.0, 16, 160, 450, '1x 8-pin', 1, 'sredni', 2025, 2349.00),
(76, 'AMD', 'Radeon RX 9070', 'Radeon RX 9000', 'RDNA 4', 'Navi 48', 4, 3584, 2520, 16, 'GDDR6', 256, 5.0, 16, 220, 650, '2x 8-pin', 1, 'wysoki', 2025, 3499.00),
(77, 'AMD', 'Radeon RX 9070 GRE', 'Radeon RX 9000', 'RDNA 4', 'Navi 48', 4, 3072, 2790, 12, 'GDDR6', 192, 5.0, 16, 220, 650, '2x 8-pin', 1, 'wysoki', 2025, 2789.00),
(78, 'AMD', 'Radeon RX 9070 XT', 'Radeon RX 9000', 'RDNA 4', 'Navi 48', 4, 4096, 2970, 16, 'GDDR6', 256, 5.0, 16, 304, 750, '2x 8-pin', 1, 'wysoki', 2025, 4288.00),
(79, 'Intel', 'Arc B570', 'Arc B-Series', 'Xe2 (Battlemage)', 'BMG-G21', 5, 2304, 2500, 10, 'GDDR6', 160, 4.0, 8, 150, 450, '1x 8-pin', 1, 'budzetowy', 2025, 1399.00),
(80, 'Intel', 'Arc B580', 'Arc B-Series', 'Xe2 (Battlemage)', 'BMG-G21', 5, 2560, 2670, 12, 'GDDR6', 192, 4.0, 8, 190, 600, '1x 8-pin', 1, 'budzetowy', 2024, 1799.00);

-- --------------------------------------------------------

--
--  `pamiec_ram`
--

CREATE TABLE `pamiec_ram` (
  `id` int(11) NOT NULL,
  `producent` varchar(30) NOT NULL,
  `model` varchar(80) NOT NULL,
  `seria` varchar(50) NOT NULL,
  `typ_pamieci` varchar(10) NOT NULL,
  `pojemnosc_calkowita_gb` smallint(5) UNSIGNED NOT NULL,
  `liczba_modulow` tinyint(3) UNSIGNED NOT NULL,
  `pojemnosc_modulu_gb` smallint(5) UNSIGNED NOT NULL,
  `taktowanie_mhz` smallint(5) UNSIGNED NOT NULL,
  `opoznienie_cl` tinyint(3) UNSIGNED NOT NULL,
  `timingi` varchar(20) DEFAULT NULL,
  `napiecie_v` decimal(4,2) NOT NULL,
  `profil_oc` varchar(50) DEFAULT NULL,
  `chlodzenie` tinyint(1) NOT NULL,
  `wysokosc_mm` decimal(5,2) DEFAULT NULL,
  `kolor` varchar(40) DEFAULT NULL,
  `segment_rynku` varchar(20) NOT NULL,
  `rok_premiery` smallint(5) UNSIGNED NOT NULL,
  `cena_rynkowa_pln_od` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
--  `pamiec_ram`
--

INSERT INTO `pamiec_ram` (`id`, `producent`, `model`, `seria`, `typ_pamieci`, `pojemnosc_calkowita_gb`, `liczba_modulow`, `pojemnosc_modulu_gb`, `taktowanie_mhz`, `opoznienie_cl`, `timingi`, `napiecie_v`, `profil_oc`, `chlodzenie`, `wysokosc_mm`, `kolor`, `segment_rynku`, `rok_premiery`, `cena_rynkowa_pln_od`) VALUES
(1, 'Corsair', 'Vengeance LPX', 'Vengeance', 'DDR4', 16, 2, 8, 3200, 16, '16-18-18-36', 1.35, 'XMP 2.0', 1, 33.50, 'Czarny', 'budzetowy', 2020, 165.00),
(2, 'Corsair', 'Vengeance LPX', 'Vengeance', 'DDR4', 32, 2, 16, 3600, 18, '18-22-22-42', 1.35, 'XMP 2.0', 1, 33.50, 'Czarny', 'sredni', 2020, 319.00),
(3, 'Kingston', 'Fury Beast', 'Fury Beast', 'DDR4', 16, 2, 8, 3200, 16, '16-18-18-36', 1.35, 'XMP 2.0', 1, 34.10, 'Czarny', 'budzetowy', 2021, 169.00),
(4, 'Kingston', 'Fury Beast', 'Fury Beast', 'DDR4', 32, 2, 16, 3600, 18, '18-22-22-39', 1.35, 'XMP 2.0', 1, 34.10, 'Czarny', 'sredni', 2021, 329.00),
(5, 'G.Skill', 'Aegis', 'Aegis', 'DDR4', 16, 2, 8, 3200, 16, '16-18-18-38', 1.35, 'XMP 2.0', 0, 31.20, 'Czarno-czerwony', 'budzetowy', 2020, 149.00),
(6, 'G.Skill', 'Ripjaws V', 'Ripjaws V', 'DDR4', 32, 2, 16, 3600, 16, '16-19-19-39', 1.35, 'XMP 2.0', 1, 42.00, 'Czarny', 'sredni', 2020, 359.00),
(7, 'Crucial', 'Ballistix', 'Ballistix', 'DDR4', 16, 2, 8, 3200, 16, '16-18-18-36', 1.35, 'XMP 2.0', 1, 39.00, 'Czerwony', 'sredni', 2021, 199.00),
(8, 'Lexar', 'Thor', 'Thor', 'DDR4', 32, 2, 16, 3200, 16, '16-18-18-38', 1.35, 'XMP 2.0', 1, 35.20, 'Ciemnoszary', 'budzetowy', 2022, 279.00),
(9, 'Patriot', 'Viper Steel', 'Viper Steel', 'DDR4', 16, 2, 8, 3600, 18, '18-22-22-42', 1.35, 'XMP 2.0', 1, 44.40, 'Szary', 'sredni', 2020, 185.00),
(10, 'ADATA', 'XPG Gammix D10', 'Gammix', 'DDR4', 32, 2, 16, 3600, 18, '18-22-22-42', 1.35, 'XMP 2.0', 1, 36.00, 'Czarny', 'sredni', 2021, 299.00),
(11, 'Goodram', 'IRDM PRO', 'IRDM', 'DDR4', 16, 2, 8, 3600, 18, '18-22-22-42', 1.35, 'XMP 2.0', 1, 33.00, 'Czarny', 'budzetowy', 2021, 179.00),
(12, 'Goodram', 'IRDM PRO Deep Black', 'IRDM', 'DDR4', 32, 2, 16, 3600, 18, '18-22-22-42', 1.35, 'XMP 2.0', 1, 33.00, 'Czarny mat', 'sredni', 2021, 315.00),
(13, 'TeamGroup', 'T-Force Vulcan Z', 'Vulcan Z', 'DDR4', 16, 2, 8, 3200, 16, '16-18-18-38', 1.35, 'XMP 2.0', 1, 32.00, 'Czerwony', 'budzetowy', 2020, 159.00),
(14, 'TeamGroup', 'T-Force Vulcan Z', 'Vulcan Z', 'DDR4', 32, 2, 16, 3600, 18, '18-22-22-42', 1.35, 'XMP 2.0', 1, 32.00, 'Szary', 'sredni', 2021, 299.00),
(15, 'Silicon Power', 'Turbine', 'XPOWER', 'DDR4', 16, 2, 8, 3200, 16, '16-18-18-36', 1.35, 'XMP 2.0', 1, 38.20, 'Niebieski', 'budzetowy', 2020, 155.00),
(16, 'G.Skill', 'Trident Z Neo', 'Trident Z', 'DDR4', 32, 2, 16, 3600, 16, '16-19-19-39', 1.35, 'XMP 2.0', 1, 44.00, 'Srebrno-czarny', 'wysoki', 2020, 449.00),
(17, 'G.Skill', 'Trident Z Royal', 'Trident Z', 'DDR4', 32, 2, 16, 4000, 18, '18-22-22-42', 1.40, 'XMP 2.0', 1, 44.00, 'Srebrny', 'entuzjasta', 2021, 599.00),
(18, 'Patriot', 'Viper Steel', 'Viper Steel', 'DDR4', 16, 2, 8, 4400, 19, '19-19-19-39', 1.45, 'XMP 2.0', 1, 44.40, 'Szary', 'entuzjasta', 2020, 329.00),
(19, 'Corsair', 'Vengeance RGB Pro', 'Vengeance', 'DDR4', 64, 2, 32, 3600, 18, '18-22-22-42', 1.35, 'XMP 2.0', 1, 51.00, 'Czarny', 'wysoki', 2021, 649.00),
(20, 'Kingston', 'Fury Renegade RGB', 'Fury Renegade', 'DDR4', 32, 2, 16, 3600, 16, '16-20-20-39', 1.35, 'XMP 2.0', 1, 41.20, 'Czarny', 'wysoki', 2021, 419.00),
(21, 'Corsair', 'Dominator Platinum RGB', 'Dominator', 'DDR4', 32, 2, 16, 3600, 18, '18-22-22-42', 1.35, 'XMP 2.0', 1, 56.00, 'Czarny', 'entuzjasta', 2020, 549.00),
(22, 'Corsair', 'Dominator Platinum RGB', 'Dominator', 'DDR4', 32, 2, 16, 4000, 19, '19-23-23-45', 1.35, 'XMP 2.0', 1, 56.00, 'Biały', 'entuzjasta', 2021, 629.00),
(23, 'ADATA', 'XPG Spectrix D50', 'Spectrix', 'DDR4', 32, 2, 16, 3600, 18, '18-22-22-42', 1.35, 'XMP 2.0', 1, 40.00, 'Biały', 'wysoki', 2021, 349.00),
(24, 'G.Skill', 'Trident Z RGB', 'Trident Z', 'DDR4', 32, 2, 16, 3200, 16, '16-18-18-38', 1.35, 'XMP 2.0', 1, 44.00, 'Czarny', 'wysoki', 2020, 389.00),
(25, 'Patriot', 'Viper RGB', 'Viper', 'DDR4', 16, 2, 8, 3600, 17, '17-19-19-39', 1.35, 'XMP 2.0', 1, 45.00, 'Czarny', 'wysoki', 2020, 249.00),
(26, 'Crucial', 'Pro', 'Pro', 'DDR5', 32, 2, 16, 5600, 46, '46-45-45-90', 1.10, 'XMP 3.0 / EXPO', 1, 31.80, 'Czarny', 'budzetowy', 2023, 389.00),
(27, 'Kingston', 'Fury Beast', 'Fury Beast', 'DDR5', 32, 2, 16, 5200, 40, '40-40-40-80', 1.25, 'XMP 3.0 / EXPO', 1, 34.90, 'Czarny', 'budzetowy', 2022, 399.00),
(28, 'Lexar', 'Ares RGB', 'Ares', 'DDR5', 32, 2, 16, 5600, 32, '32-36-36-68', 1.20, 'XMP 3.0 / EXPO', 1, 43.30, 'Czarny', 'budzetowy', 2023, 429.00),
(29, 'Corsair', 'Vengeance', 'Vengeance', 'DDR5', 32, 2, 16, 5200, 40, '40-40-40-77', 1.25, 'XMP 3.0', 1, 35.00, 'Czarny', 'budzetowy', 2022, 419.00),
(30, 'ADATA', 'XPG Lancer', 'Lancer', 'DDR5', 32, 2, 16, 5200, 38, '38-38-38-76', 1.25, 'XMP 3.0', 1, 40.00, 'Czarny', 'budzetowy', 2022, 409.00),
(31, 'Goodram', 'IRDM DDR5', 'IRDM', 'DDR5', 32, 2, 16, 5600, 30, '30-36-36-76', 1.25, 'XMP 3.0 / EXPO', 1, 33.00, 'Czarny', 'budzetowy', 2023, 399.00),
(32, 'TeamGroup', 'T-Force Vulcan', 'Vulcan', 'DDR5', 32, 2, 16, 5600, 36, '36-36-36-76', 1.20, 'XMP 3.0 / EXPO', 1, 32.70, 'Czerwony', 'budzetowy', 2022, 389.00),
(33, 'Patriot', 'Viper Venom', 'Viper Venom', 'DDR5', 32, 2, 16, 5600, 36, '36-36-36-72', 1.25, 'XMP 3.0', 1, 43.00, 'Czarno-srebrny', 'budzetowy', 2022, 399.00),
(34, 'Kingston', 'ValueRAM', 'ValueRAM', 'DDR5', 16, 1, 16, 4800, 40, '40-39-39-77', 1.10, 'JEDEC', 0, 31.25, 'Zielony', 'budzetowy', 2021, 219.00),
(35, 'Crucial', 'Basics', 'Basics', 'DDR5', 32, 2, 16, 4800, 40, '40-39-39-77', 1.10, 'JEDEC', 0, 31.25, 'Czarny', 'budzetowy', 2021, 349.00),
(36, 'GeIL', 'Polaris RGB', 'Polaris', 'DDR5', 32, 2, 16, 5200, 34, '34-38-38-78', 1.25, 'XMP 3.0', 1, 44.00, 'Szary', 'budzetowy', 2022, 419.00),
(37, 'Silicon Power', 'Zenith', 'XPOWER', 'DDR5', 32, 2, 16, 5600, 40, '40-40-40-77', 1.25, 'XMP 3.0 / EXPO', 1, 38.50, 'Srebrny', 'budzetowy', 2023, 379.00),
(38, 'G.Skill', 'Flare X5', 'Flare', 'DDR5', 32, 2, 16, 6000, 30, '30-38-38-96', 1.35, 'EXPO', 1, 33.00, 'Czarny', 'sredni', 2022, 499.00),
(39, 'G.Skill', 'Trident Z5 Neo RGB', 'Trident Z5', 'DDR5', 32, 2, 16, 6000, 30, '30-38-38-96', 1.35, 'EXPO', 1, 44.00, 'Czarny', 'wysoki', 2022, 569.00),
(40, 'Corsair', 'Vengeance', 'Vengeance', 'DDR5', 32, 2, 16, 6000, 30, '30-36-36-76', 1.40, 'XMP 3.0 / EXPO', 1, 35.00, 'Czarny', 'sredni', 2023, 499.00),
(41, 'Corsair', 'Vengeance RGB', 'Vengeance', 'DDR5', 64, 2, 32, 6000, 30, '30-36-36-76', 1.40, 'XMP 3.0 / EXPO', 1, 44.00, 'Biały', 'wysoki', 2023, 999.00),
(42, 'Kingston', 'Fury Beast RGB', 'Fury Beast', 'DDR5', 32, 2, 16, 6000, 36, '36-38-38-80', 1.35, 'XMP 3.0 / EXPO', 1, 42.20, 'Czarny', 'sredni', 2022, 519.00),
(43, 'Lexar', 'Ares RGB', 'Ares', 'DDR5', 32, 2, 16, 6400, 32, '32-38-38-76', 1.40, 'XMP 3.0 / EXPO', 1, 43.30, 'Biały', 'wysoki', 2023, 529.00),
(44, 'TeamGroup', 'T-Create Expert', 'T-Create', 'DDR5', 32, 2, 16, 6000, 30, '30-36-36-76', 1.35, 'XMP 3.0', 1, 32.00, 'Czarny', 'sredni', 2023, 489.00),
(45, 'TeamGroup', 'T-Force Delta RGB', 'Delta RGB', 'DDR5', 32, 2, 16, 6400, 40, '40-40-40-84', 1.35, 'XMP 3.0', 1, 46.10, 'Biały', 'sredni', 2022, 539.00),
(46, 'ADATA', 'XPG Lancer Blade', 'Lancer', 'DDR5', 32, 2, 16, 6000, 30, '30-40-40-76', 1.35, 'XMP 3.0 / EXPO', 1, 33.80, 'Czarny', 'sredni', 2023, 479.00),
(47, 'Patriot', 'Viper Venom', 'Viper Venom', 'DDR5', 32, 2, 16, 6400, 32, '32-40-40-84', 1.40, 'XMP 3.0 / EXPO', 1, 43.00, 'Czarno-srebrny', 'wysoki', 2023, 499.00),
(48, 'G.Skill', 'Trident Z5 RGB', 'Trident Z5', 'DDR5', 32, 2, 16, 6000, 36, '36-36-36-96', 1.35, 'XMP 3.0', 1, 44.00, 'Srebrny', 'sredni', 2022, 529.00),
(49, 'Goodram', 'IRDM PRO DDR5', 'IRDM', 'DDR5', 32, 2, 16, 6000, 30, '30-36-36-76', 1.35, 'XMP 3.0 / EXPO', 1, 33.00, 'Srebrny', 'sredni', 2023, 489.00),
(50, 'Kingston', 'Fury Renegade RGB', 'Fury Renegade', 'DDR5', 32, 2, 16, 6400, 32, '32-39-39-80', 1.40, 'XMP 3.0', 1, 44.00, 'Biało-srebrny', 'wysoki', 2023, 599.00),
(51, 'Corsair', 'Vengeance RGB', 'Vengeance', 'DDR5', 32, 2, 16, 6400, 32, '32-40-40-84', 1.40, 'XMP 3.0', 1, 44.00, 'Czarny', 'wysoki', 2023, 579.00),
(52, 'ADATA', 'XPG Lancer RGB', 'Lancer', 'DDR5', 32, 2, 16, 6000, 30, '30-40-40-76', 1.35, 'XMP 3.0 / EXPO', 1, 40.00, 'Czarny', 'sredni', 2022, 519.00),
(53, 'Crucial', 'Pro Overclocking', 'Pro', 'DDR5', 32, 2, 16, 6000, 36, '36-38-38-80', 1.35, 'XMP 3.0 / EXPO', 1, 32.00, 'Czarny', 'sredni', 2024, 469.00),
(54, 'Lexar', 'Thor OC', 'Thor', 'DDR5', 32, 2, 16, 6000, 32, '32-38-38-76', 1.35, 'XMP 3.0 / EXPO', 1, 35.00, 'Czarny', 'sredni', 2024, 459.00),
(55, 'GeIL', 'ORION V RGB', 'ORION', 'DDR5', 32, 2, 16, 6000, 30, '30-38-38-96', 1.35, 'EXPO / XMP 3.0', 1, 38.00, 'Titanium Gray', 'sredni', 2023, 479.00),
(56, 'G.Skill', 'Trident Z5 RGB', 'Trident Z5', 'DDR5', 32, 2, 16, 7200, 34, '34-45-45-115', 1.40, 'XMP 3.0', 1, 44.00, 'Czarny', 'wysoki', 2023, 699.00),
(57, 'G.Skill', 'Trident Z5 RGB', 'Trident Z5', 'DDR5', 48, 2, 24, 7200, 36, '36-46-46-115', 1.35, 'XMP 3.0', 1, 44.00, 'Srebrny', 'entuzjasta', 2024, 999.00),
(58, 'Corsair', 'Dominator Titanium RGB', 'Dominator', 'DDR5', 32, 2, 16, 7200, 34, '34-44-44-96', 1.40, 'XMP 3.0', 1, 57.30, 'Biały', 'entuzjasta', 2024, 849.00),
(59, 'Corsair', 'Vengeance', 'Vengeance', 'DDR5', 32, 2, 16, 7000, 34, '34-42-42-96', 1.40, 'XMP 3.0', 1, 35.00, 'Czarny', 'wysoki', 2023, 629.00),
(60, 'Kingston', 'Fury Renegade', 'Fury Renegade', 'DDR5', 32, 2, 16, 7200, 38, '38-44-44-105', 1.45, 'XMP 3.0', 1, 39.20, 'Srebrno-czarny', 'wysoki', 2023, 689.00),
(61, 'TeamGroup', 'T-Force Delta RGB', 'Delta RGB', 'DDR5', 32, 2, 16, 7600, 36, '36-46-46-84', 1.40, 'XMP 3.0', 1, 46.10, 'Biały', 'entuzjasta', 2023, 789.00),
(62, 'Patriot', 'Viper Elite 5', 'Elite 5', 'DDR5', 32, 2, 16, 7000, 38, '38-48-48-84', 1.40, 'XMP 3.0', 1, 44.00, 'Biały', 'wysoki', 2024, 639.00),
(63, 'ADATA', 'XPG Lancer RGB', 'Lancer', 'DDR5', 32, 2, 16, 7200, 34, '34-46-46-115', 1.40, 'XMP 3.0', 1, 40.00, 'Biały', 'wysoki', 2023, 659.00),
(64, 'G.Skill', 'Trident Z5 CK', 'Trident Z5', 'DDR5', 48, 2, 24, 7600, 36, '36-46-46-120', 1.40, 'XMP 3.0', 1, 44.00, 'Czarny Piano', 'entuzjasta', 2024, 1099.00),
(65, 'TeamGroup', 'T-Force Xtreem ARGB', 'Xtreem', 'DDR5', 32, 2, 16, 7200, 34, '34-42-42-84', 1.40, 'XMP 3.0', 1, 48.80, 'Biały', 'wysoki', 2024, 749.00),
(66, 'Corsair', 'Vengeance RGB', 'Vengeance', 'DDR5', 48, 2, 24, 7000, 36, '36-44-44-96', 1.40, 'XMP 3.0', 1, 44.00, 'Czarny', 'wysoki', 2024, 819.00),
(67, 'G.Skill', 'Trident Z5 Royal', 'Trident Z5', 'DDR5', 48, 2, 24, 8400, 40, '40-52-52-134', 1.40, 'XMP 3.0', 1, 44.00, 'Złoty', 'entuzjasta', 2024, 1999.00),
(68, 'G.Skill', 'Trident Z5 RGB', 'Trident Z5', 'DDR5', 48, 2, 24, 8200, 40, '40-52-52-131', 1.35, 'XMP 3.0', 1, 44.00, 'Czarny', 'entuzjasta', 2024, 1499.00),
(69, 'Corsair', 'Dominator Titanium', 'Dominator', 'DDR5', 48, 2, 24, 8000, 38, '38-48-48-98', 1.40, 'XMP 3.0', 1, 57.30, 'Czarny', 'entuzjasta', 2024, 1399.00),
(70, 'Patriot', 'Viper Xtreme 5', 'Xtreme 5', 'DDR5', 48, 2, 24, 8200, 38, '38-48-48-84', 1.45, 'XMP 3.0', 1, 47.00, 'Czarny', 'entuzjasta', 2024, 1349.00),
(71, 'TeamGroup', 'T-Force Xtreem', 'Xtreem', 'DDR5', 48, 2, 24, 8200, 38, '38-49-49-84', 1.40, 'XMP 3.0', 1, 48.80, 'Czarny', 'entuzjasta', 2024, 1459.00),
(72, 'G.Skill', 'Trident Z5 CK', 'Trident Z5', 'DDR5', 48, 2, 24, 8800, 42, '42-54-54-136', 1.45, 'XMP 3.0', 1, 44.00, 'Srebrny Chrome', 'entuzjasta', 2025, 2199.00),
(73, 'V-Color', 'Manta XFinity RGB', 'Manta', 'DDR5', 48, 2, 24, 8400, 40, '40-52-52-130', 1.40, 'XMP 3.0', 1, 43.50, 'Czarny gold', 'entuzjasta', 2024, 1699.00),
(74, 'Corsair', 'Vengeance', 'Vengeance', 'DDR5', 96, 2, 48, 5600, 40, '40-40-40-77', 1.25, 'XMP 3.0 / EXPO', 1, 35.00, 'Czarny', 'wysoki', 2023, 1299.00),
(75, 'G.Skill', 'Ripjaws S5', 'Ripjaws S5', 'DDR5', 64, 2, 32, 6000, 30, '30-40-40-96', 1.40, 'XMP 3.0', 1, 33.00, 'Czarny', 'wysoki', 2023, 949.00),
(76, 'Kingston', 'Fury Renegade Pro', 'Fury Renegade', 'DDR5', 128, 4, 32, 6000, 32, '32-38-38-80', 1.35, 'EXPO', 1, 35.00, 'Srebrno-czarny', 'entuzjasta', 2024, 2399.00),
(77, 'TeamGroup', 'T-Create Expert', 'T-Create', 'DDR5', 64, 2, 32, 6400, 34, '34-39-39-84', 1.35, 'XMP 3.0', 1, 32.00, 'Czarny', 'wysoki', 2023, 999.00),
(78, 'Crucial', 'Pro Overclocking', 'Pro', 'DDR5', 96, 2, 48, 6000, 36, '36-38-38-80', 1.35, 'XMP 3.0 / EXPO', 1, 31.80, 'Czarny', 'wysoki', 2024, 1349.00),
(79, 'Corsair', 'Vengeance RGB', 'Vengeance', 'DDR5', 192, 4, 48, 5200, 38, '38-38-38-84', 1.25, 'XMP 3.0 / EXPO', 1, 44.00, 'Czarny', 'entuzjasta', 2024, 2799.00),
(80, 'G.Skill', 'Zeta R5 Neo', 'Zeta R5', 'DDR5', 128, 4, 32, 6400, 32, '32-39-39-102', 1.40, 'EXPO', 1, 42.00, 'Czarny', 'entuzjasta', 2024, 3199.00);

-- --------------------------------------------------------

--
--  `pc_cases`
--

CREATE TABLE `pc_cases` (
  `id` int(11) NOT NULL,
  `brand` varchar(50) NOT NULL,
  `model` varchar(100) NOT NULL,
  `form_factor` varchar(20) NOT NULL,
  `color` varchar(30) NOT NULL,
  `length_mm` int(11) NOT NULL,
  `width_mm` int(11) NOT NULL,
  `height_mm` int(11) NOT NULL,
  `fan_count` tinyint(4) NOT NULL,
  `has_side_window` tinyint(1) NOT NULL DEFAULT 1,
  `size_class` varchar(10) GENERATED ALWAYS AS (case when `length_mm` <= 400 then 'Compact' when `length_mm` <= 450 then 'Mid' else 'Full' end) STORED,
  `price_pln` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
--  `pc_cases`
--

INSERT INTO `pc_cases` (`id`, `brand`, `model`, `form_factor`, `color`, `length_mm`, `width_mm`, `height_mm`, `fan_count`, `has_side_window`, `price_pln`) VALUES
(1, 'NZXT', 'H510', 'ATX', 'Black', 428, 230, 460, 2, 1, 349.00),
(2, 'NZXT', 'H7 Flow', 'ATX', 'White', 480, 230, 480, 3, 1, 549.00),
(3, 'Corsair', '4000D Airflow', 'ATX', 'Black', 453, 230, 466, 2, 1, 439.00),
(4, 'Corsair', '5000D Airflow', 'E-ATX', 'White', 520, 245, 520, 3, 1, 799.00),
(5, 'Corsair', '2000D Airflow', 'Mini-ITX', 'Black', 352, 210, 380, 2, 0, 399.00),
(6, 'Fractal', 'Meshify 2', 'ATX', 'Gray', 474, 232, 475, 3, 1, 629.00),
(7, 'Fractal', 'North', 'ATX', 'Chalk White', 453, 215, 469, 2, 1, 699.00),
(8, 'Fractal', 'Define 7 Mini', 'Micro-ATX', 'Black', 420, 210, 457, 2, 0, 599.00),
(9, 'Lian Li', 'O11 Dynamic', 'ATX', 'Black', 445, 272, 446, 3, 1, 749.00),
(10, 'Lian Li', 'O11 Air Mini', 'Micro-ATX', 'White', 359, 215, 406, 2, 1, 499.00),
(11, 'Lian Li', 'Lancool 216', 'ATX', 'Black', 480, 236, 476, 3, 1, 549.00),
(12, 'be quiet!', 'Pure Base 500DX', 'ATX', 'Black', 450, 232, 462, 3, 1, 569.00),
(13, 'be quiet!', 'Silent Base 802', 'E-ATX', 'Black', 490, 232, 510, 3, 1, 899.00),
(14, 'be quiet!', 'Dark Base 701', 'E-ATX', 'Black', 493, 240, 520, 4, 1, 1099.00),
(15, 'Cooler Master', 'MasterBox TD500', 'ATX', 'Black', 493, 220, 468, 3, 1, 499.00),
(16, 'Cooler Master', 'NR200', 'Mini-ITX', 'White', 292, 185, 376, 1, 0, 429.00),
(17, 'Cooler Master', 'H500', 'ATX', 'Black', 494, 229, 485, 2, 1, 599.00),
(18, 'Phanteks', 'P400A', 'ATX', 'Black', 480, 210, 465, 3, 1, 449.00),
(19, 'Phanteks', 'Eclipse G360A', 'ATX', 'White', 440, 215, 465, 4, 1, 599.00),
(20, 'Phanteks', 'XT Pro', 'Micro-ATX', 'Black', 463, 209, 468, 2, 1, 479.00),
(21, 'MSI', 'MAG Forge 100R', 'ATX', 'Black', 406, 216, 460, 3, 1, 389.00),
(22, 'MSI', 'MPG Gungnir 300', 'ATX', 'Black', 466, 233, 493, 4, 1, 679.00),
(23, 'Asus', 'TUF Gaming GT301', 'ATX', 'Black', 440, 215, 462, 3, 1, 599.00),
(24, 'Asus', 'ROG Strix Helios', 'E-ATX', 'White', 555, 240, 546, 3, 1, 1299.00),
(25, 'Thermaltake', 'Core V1', 'Mini-ITX', 'Black', 281, 281, 281, 1, 0, 349.00),
(26, 'Thermaltake', 'View 71', 'E-ATX', 'Black', 577, 250, 578, 4, 1, 1199.00),
(27, 'Deepcool', 'CH510', 'ATX', 'Black', 466, 212, 460, 3, 1, 369.00),
(28, 'Deepcool', 'CK500', 'ATX', 'Black', 454, 220, 466, 4, 1, 459.00),
(29, 'SilverStone', 'FARA R1', 'ATX', 'Black', 423, 213, 465, 1, 1, 299.00),
(30, 'SilverStone', 'SETA A1', 'ATX', 'White', 465, 232, 490, 4, 1, 749.00);

-- --------------------------------------------------------

--
--  `plyty_glowne`
--

CREATE TABLE `plyty_glowne` (
  `id` int(11) NOT NULL,
  `producent` varchar(30) NOT NULL,
  `model` varchar(150) NOT NULL,
  `socket` varchar(20) NOT NULL,
  `chipset` varchar(20) NOT NULL,
  `typ_pamieci` varchar(10) NOT NULL,
  `format` varchar(20) NOT NULL,
  `liczba_slotow_ram` tinyint(4) NOT NULL,
  `maksymalna_pamiec_gb` smallint(6) NOT NULL,
  `liczba_slotow_m2` tinyint(4) NOT NULL,
  `liczba_portow_sata` tinyint(4) NOT NULL,
  `standard_pcie_gpu` varchar(30) NOT NULL,
  `lan` varchar(30) NOT NULL,
  `wifi` varchar(20) NOT NULL,
  `bluetooth` varchar(30) NOT NULL,
  `usb4_thunderbolt` varchar(60) NOT NULL,
  `cena_pln` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
--  `plyty_glowne`
--

INSERT INTO `plyty_glowne` (`id`, `producent`, `model`, `socket`, `chipset`, `typ_pamieci`, `format`, `liczba_slotow_ram`, `maksymalna_pamiec_gb`, `liczba_slotow_m2`, `liczba_portow_sata`, `standard_pcie_gpu`, `lan`, `wifi`, `bluetooth`, `usb4_thunderbolt`, `cena_pln`) VALUES
(1, 'ASUS', 'ROG CROSSHAIR X870E HERO', 'AM5', 'X870E', 'DDR5', 'ATX', 4, 256, 5, 4, 'PCIe 5.0 x16', '5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 2799.00),
(3, 'ASUS', 'ROG STRIX X870E-E GAMING WIFI', 'AM5', 'X870E', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 1986.00),
(4, 'ASUS', 'ROG STRIX X870E-A GAMING WIFI', 'AM5', 'X870E', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 2620.00),
(5, 'ASUS', 'PROART X870E-CREATOR WIFI', 'AM5', 'X870E', 'DDR5', 'ATX', 4, 256, 5, 4, 'PCIe 5.0 x16', '10 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 1785.00),
(6, 'MSI', 'MEG X870E GODLIKE', 'AM5', 'X870E', 'DDR5', 'E-ATX', 4, 256, 5, 4, 'PCIe 5.0 x16', '10 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 6150.00),
(7, 'MSI', 'MEG X870E ACE MAX', 'AM5', 'X870E', 'DDR5', 'ATX', 4, 256, 5, 4, 'PCIe 5.0 x16', '5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 3049.00),
(8, 'MSI', 'MPG X870E CARBON WIFI', 'AM5', 'X870E', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 1249.00),
(9, 'MSI', 'MAG X870E TOMAHAWK WIFI', 'AM5', 'X870E', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 1355.00),
(10, 'GIGABYTE', 'X870E AORUS XTREME AI TOP', 'AM5', 'X870E', 'DDR5', 'E-ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 2030.00),
(11, 'GIGABYTE', 'X870E AORUS MASTER', 'AM5', 'X870E', 'DDR5', 'E-ATX', 4, 256, 5, 4, 'PCIe 5.0 x16', '5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 3380.00),
(13, 'ASRock', 'X870E Taichi', 'AM5', 'X870E', 'DDR5', 'E-ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 1969.00),
(14, 'ASRock', 'X870E Taichi Lite', 'AM5', 'X870E', 'DDR5', 'E-ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 1605.00),
(15, 'ASRock', 'X870E Nova WiFi', 'AM5', 'X870E', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 2620.00),
(16, 'ASRock', 'X870E Steel Legend WiFi', 'AM5', 'X870E', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 2030.00),
(17, 'ASUS', 'ROG STRIX X870-F GAMING WIFI', 'AM5', 'X870', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 975.00),
(18, 'ASUS', 'TUF GAMING X870-PLUS WIFI', 'AM5', 'X870', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 1038.00),
(19, 'ASUS', 'PRIME X870-P WIFI', 'AM5', 'X870', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 965.00),
(20, 'MSI', 'MAG X870 TOMAHAWK WIFI', 'AM5', 'X870', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 1350.00),
(21, 'MSI', 'PRO X870-P WIFI', 'AM5', 'X870', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 1000.00),
(22, 'GIGABYTE', 'X870 AORUS ELITE WIFI7', 'AM5', 'X870', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 919.00),
(23, 'GIGABYTE', 'X870 GAMING X WIFI7', 'AM5', 'X870', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 1020.00),
(24, 'ASRock', 'X870 Riptide WiFi', 'AM5', 'X870', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 1120.00),
(25, 'ASRock', 'X870 Pro RS WiFi', 'AM5', 'X870', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', '2 × USB4', 950.00),
(26, 'ASUS', 'ROG STRIX B850-E GAMING WIFI', 'AM5', 'B850', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 1310.00),
(27, 'ASUS', 'TUF GAMING B850-PLUS WIFI', 'AM5', 'B850', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 1039.00),
(28, 'ASUS', 'PRIME B850-PLUS WIFI', 'AM5', 'B850', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 710.00),
(29, 'ASUS', 'PRIME B850M-A WIFI', 'AM5', 'B850', 'DDR5', 'micro-ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 749.00),
(30, 'MSI', 'MAG B850 TOMAHAWK MAX WIFI', 'AM5', 'B850', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 1227.00),
(31, 'MSI', 'PRO B850-P WIFI', 'AM5', 'B850', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 710.00),
(32, 'MSI', 'B850M GAMING PLUS WIFI', 'AM5', 'B850', 'DDR5', 'micro-ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 840.00),
(33, 'GIGABYTE', 'B850 AORUS ELITE WIFI7', 'AM5', 'B850', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 1010.00),
(34, 'GIGABYTE', 'B850 EAGLE WIFI7', 'AM5', 'B850', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 750.00),
(35, 'GIGABYTE', 'B850M AORUS ELITE WIFI6E', 'AM5', 'B850', 'DDR5', 'micro-ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 6E', 'Bluetooth 5.3', 'Brak', 1010.00),
(36, 'ASRock', 'B850 Steel Legend WiFi', 'AM5', 'B850', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 1010.00),
(37, 'ASRock', 'B850 Pro RS WiFi', 'AM5', 'B850', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 655.00),
(38, 'ASRock', 'B850M Pro RS WiFi', 'AM5', 'B850', 'DDR5', 'micro-ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 710.00),
(39, 'ASRock', 'B850I Lightning WiFi', 'AM5', 'B850', 'DDR5', 'mini-ITX', 2, 128, 2, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 830.00),
(40, 'ASUS', 'ROG STRIX B650E-E GAMING WIFI', 'AM5', 'B650E', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 1750.00),
(41, 'ASUS', 'TUF GAMING B650-PLUS WIFI', 'AM5', 'B650', 'DDR5', 'ATX', 4, 256, 2, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 639.00),
(43, 'ASUS', 'PRIME B650M-A WIFI II', 'AM5', 'B650', 'DDR5', 'micro-ATX', 4, 256, 2, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 620.00),
(44, 'MSI', 'MAG B650 TOMAHAWK WIFI', 'AM5', 'B650', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 880.00),
(45, 'MSI', 'MPG B650 CARBON WIFI', 'AM5', 'B650', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 1140.00),
(46, 'MSI', 'PRO B650-P WIFI', 'AM5', 'B650', 'DDR5', 'ATX', 4, 256, 2, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 620.00),
(47, 'MSI', 'B650M MORTAR WIFI', 'AM5', 'B650', 'DDR5', 'micro-ATX', 4, 256, 3, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 880.00),
(48, 'GIGABYTE', 'B650 AORUS ELITE AX', 'AM5', 'B650', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 509.00),
(49, 'ASUS', 'ROG CROSSHAIR VIII HERO', 'AM4', 'B550', 'DDR4', 'ATX', 4, 128, 4, 6, 'PCIe 4.0 x16', '5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 1010.00),
(51, 'ASUS', 'ROG STRIX X570-E GAMING', 'AM4', 'X570', 'DDR4', 'ATX', 4, 128, 3, 6, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 1310.00),
(52, 'ASUS', 'TUF GAMING X570-PLUS WIFI', 'AM4', 'X570', 'DDR4', 'ATX', 4, 128, 2, 6, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 840.00),
(54, 'MSI', 'MEG X570 GODLIKE', 'AM4', 'X570', 'DDR4', 'E-ATX', 4, 128, 4, 6, 'PCIe 4.0 x16', '10 GbE', 'Wi-Fi 6', 'Bluetooth 5.2', 'Brak', 3070.00),
(55, 'MSI', 'MEG X570 ACE', 'AM4', 'X570', 'DDR4', 'ATX', 4, 128, 4, 6, 'PCIe 4.0 x16', '5 GbE', 'Wi-Fi 6', 'Bluetooth 5.2', 'Brak', 1690.00),
(56, 'MSI', 'MPG X570 GAMING EDGE WIFI', 'AM4', 'X570', 'DDR4', 'ATX', 4, 128, 2, 6, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 750.00),
(57, 'MSI', 'MAG X570 TOMAHAWK WIFI', 'AM4', 'X570', 'DDR4', 'ATX', 4, 128, 3, 6, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 1010.00),
(58, 'GIGABYTE', 'X570 AORUS XTREME', 'AM4', 'X570', 'DDR4', 'E-ATX', 4, 128, 3, 6, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.2', 'Brak', 1010.00),
(59, 'GIGABYTE', 'X570 AORUS MASTER', 'AM4', 'X570', 'DDR4', 'ATX', 4, 128, 4, 6, 'PCIe 4.0 x16', '5 GbE', 'Wi-Fi 6', 'Bluetooth 5.2', 'Brak', 1690.00),
(61, 'ASRock', 'X570 Taichi', 'AM4', 'X570', 'DDR4', 'ATX', 4, 128, 4, 6, 'PCIe 4.0 x16', '5 GbE', 'Wi-Fi 6', 'Bluetooth 5.2', 'Brak', 1690.00),
(65, 'ASUS', 'ROG STRIX B550-F GAMING WIFI II', 'AM4', 'B550', 'DDR4', 'ATX', 4, 128, 3, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 790.00),
(66, 'ASUS', 'TUF GAMING B550-PLUS WIFI II', 'AM4', 'B550', 'DDR4', 'ATX', 4, 128, 2, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 579.00),
(68, 'ASUS', 'TUF GAMING B550M-PLUS WIFI II', 'AM4', 'B550', 'DDR4', 'micro-ATX', 4, 128, 2, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 500.00),
(70, 'MSI', 'MPG B550 GAMING CARBON WIFI', 'AM4', 'B550', 'DDR4', 'ATX', 4, 128, 3, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 790.00),
(72, 'MSI', 'MAG B550M MORTAR WIFI', 'AM4', 'B550', 'DDR4', 'micro-ATX', 4, 128, 3, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 610.00),
(73, 'MSI', 'B550M PRO-VDH WIFI', 'AM4', 'B550', 'DDR4', 'micro-ATX', 4, 128, 2, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 450.00),
(78, 'ASRock', 'B550 Taichi', 'AM4', 'B550', 'DDR4', 'ATX', 4, 128, 4, 6, 'PCIe 4.0 x16', '5 GbE', 'Wi-Fi 6', 'Bluetooth 5.2', 'Brak', 1010.00),
(82, 'ASRock', 'B550 Phantom Gaming-ITX/ax', 'AM4', 'B550', 'DDR4', 'mini-ITX', 2, 64, 2, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 500.00),
(86, 'ASUS', 'ROG MAXIMUS Z890 EXTREME', 'LGA1851', 'Z890', 'DDR5', 'E-ATX', 4, 256, 5, 4, 'PCIe 5.0 x16', '10 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Thunderbolt 4 / USB4', 6150.00),
(88, 'ASUS', 'ROG STRIX Z890-E GAMING WIFI', 'LGA1851', 'Z890', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 2620.00),
(89, 'ASUS', 'ROG STRIX Z890-F GAMING WIFI', 'LGA1851', 'Z890', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 2620.00),
(90, 'ASUS', 'PROART Z890-CREATOR WIFI', 'LGA1851', 'Z890', 'DDR5', 'ATX', 4, 256, 5, 4, 'PCIe 5.0 x16', '10 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Thunderbolt 4 / USB4', 3380.00),
(91, 'MSI', 'MEG Z890 GODLIKE', 'LGA1851', 'Z890', 'DDR5', 'E-ATX', 4, 256, 5, 4, 'PCIe 5.0 x16', '10 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Thunderbolt 4 / USB4', 6150.00),
(92, 'MSI', 'MEG Z890 ACE', 'LGA1851', 'Z890', 'DDR5', 'E-ATX', 4, 256, 5, 4, 'PCIe 5.0 x16', '5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Thunderbolt 4 / USB4', 3380.00),
(93, 'MSI', 'MPG Z890 CARBON WIFI', 'LGA1851', 'Z890', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 2620.00),
(94, 'MSI', 'MAG Z890 TOMAHAWK WIFI', 'LGA1851', 'Z890', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 2030.00),
(95, 'GIGABYTE', 'Z890 AORUS XTREME AI TOP', 'LGA1851', 'Z890', 'DDR5', 'E-ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 2030.00),
(96, 'GIGABYTE', 'Z890 AORUS MASTER', 'LGA1851', 'Z890', 'DDR5', 'E-ATX', 4, 256, 5, 4, 'PCIe 5.0 x16', '5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 3380.00),
(98, 'ASRock', 'Z890 Taichi', 'LGA1851', 'Z890', 'DDR5', 'ATX', 4, 256, 5, 4, 'PCIe 5.0 x16', '5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 3380.00),
(99, 'ASRock', 'Z890 Nova WiFi', 'LGA1851', 'Z890', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 2620.00),
(100, 'ASRock', 'Z890 Steel Legend WiFi', 'LGA1851', 'Z890', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 2030.00),
(101, 'ASUS', 'ROG STRIX B860-F GAMING WIFI', 'LGA1851', 'B860', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 1220.00),
(102, 'ASUS', 'TUF GAMING B860-PLUS WIFI', 'LGA1851', 'B860', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 780.00),
(103, 'ASUS', 'PRIME B860-PLUS WIFI', 'LGA1851', 'B860', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 660.00),
(104, 'ASUS', 'PRIME B860M-A WIFI', 'LGA1851', 'B860', 'DDR5', 'micro-ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 660.00),
(105, 'MSI', 'MAG B860 TOMAHAWK WIFI', 'LGA1851', 'B860', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 950.00),
(106, 'MSI', 'PRO B860-P WIFI', 'LGA1851', 'B860', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 660.00),
(107, 'MSI', 'B860M GAMING PLUS WIFI', 'LGA1851', 'B860', 'DDR5', 'micro-ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 780.00),
(108, 'GIGABYTE', 'B860 AORUS ELITE WIFI7', 'LGA1851', 'B860', 'DDR5', 'ATX', 4, 256, 4, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 950.00),
(109, 'GIGABYTE', 'B860 GAMING X WIFI6E', 'LGA1851', 'B860', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 6E', 'Bluetooth 5.3', 'Brak', 780.00),
(111, 'ASRock', 'B860 Steel Legend WiFi', 'LGA1851', 'B860', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 950.00),
(112, 'ASRock', 'B860 Pro RS WiFi', 'LGA1851', 'B860', 'DDR5', 'ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 660.00),
(113, 'ASRock', 'B860M Pro RS WiFi', 'LGA1851', 'B860', 'DDR5', 'micro-ATX', 4, 256, 3, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 660.00),
(114, 'ASRock', 'B860I Lightning WiFi', 'LGA1851', 'B860', 'DDR5', 'mini-ITX', 2, 128, 2, 4, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 770.00),
(115, 'ASUS', 'PRIME H810M-A WIFI', 'LGA1851', 'H810', 'DDR5', 'micro-ATX', 4, 256, 2, 4, 'PCIe 4.0 x16', '1 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 490.00),
(116, 'ASUS', 'ROG MAXIMUS Z790 HERO', 'LGA1700', 'Z790', 'DDR5', 'ATX', 4, 192, 5, 6, 'PCIe 5.0 x16', '5 GbE', 'Wi-Fi 6E', 'Bluetooth 5.2', 'Thunderbolt 4 (wariant zależny od modelu)', 4510.00),
(117, 'ASUS', 'ROG STRIX Z790-E GAMING WIFI II', 'LGA1700', 'Z790', 'DDR5', 'ATX', 4, 192, 4, 6, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 1920.00),
(118, 'ASUS', 'ROG STRIX Z790-F GAMING WIFI II', 'LGA1700', 'Z790', 'DDR5', 'ATX', 4, 192, 4, 6, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 1920.00),
(119, 'ASUS', 'TUF GAMING Z790-PRO WIFI', 'LGA1700', 'Z790', 'DDR5', 'ATX', 4, 192, 3, 6, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 1230.00),
(120, 'MSI', 'MEG Z790 GODLIKE MAX', 'LGA1700', 'Z790', 'DDR5', 'E-ATX', 4, 192, 5, 6, 'PCIe 5.0 x16', '10 GbE', 'Wi-Fi 6E', 'Bluetooth 5.2', 'Thunderbolt 4 (wariant zależny od modelu)', 4510.00),
(121, 'MSI', 'MEG Z790 ACE MAX', 'LGA1700', 'Z790', 'DDR5', 'E-ATX', 4, 192, 5, 6, 'PCIe 5.0 x16', '5 GbE', 'Wi-Fi 6E', 'Bluetooth 5.2', 'Thunderbolt 4 (wariant zależny od modelu)', 2480.00),
(122, 'MSI', 'MPG Z790 CARBON WIFI II', 'LGA1700', 'Z790', 'DDR5', 'ATX', 4, 192, 4, 6, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 1920.00),
(123, 'MSI', 'MAG Z790 TOMAHAWK MAX WIFI', 'LGA1700', 'Z790', 'DDR5', 'ATX', 4, 192, 4, 6, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 1480.00),
(124, 'GIGABYTE', 'Z790 AORUS XTREME X', 'LGA1700', 'Z790', 'DDR5', 'E-ATX', 4, 192, 4, 6, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 6E', 'Bluetooth 5.2', 'Brak', 1480.00),
(125, 'GIGABYTE', 'Z790 AORUS MASTER X', 'LGA1700', 'Z790', 'DDR5', 'E-ATX', 4, 192, 5, 6, 'PCIe 5.0 x16', '5 GbE', 'Wi-Fi 6E', 'Bluetooth 5.2', 'Brak', 2480.00),
(126, 'GIGABYTE', 'Z790 AORUS ELITE X WIFI7', 'LGA1700', 'Z790', 'DDR5', 'ATX', 4, 192, 4, 6, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 7', 'Bluetooth 5.4', 'Brak', 1480.00),
(127, 'ASRock', 'Z790 Taichi', 'LGA1700', 'Z790', 'DDR5', 'ATX', 4, 192, 5, 6, 'PCIe 5.0 x16', '5 GbE', 'Wi-Fi 6E', 'Bluetooth 5.2', 'Brak', 2480.00),
(128, 'ASRock', 'Z790 Nova WiFi', 'LGA1700', 'Z790', 'DDR5', 'ATX', 4, 192, 4, 6, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 1920.00),
(129, 'ASRock', 'Z790 Steel Legend WiFi', 'LGA1700', 'Z790', 'DDR5', 'ATX', 4, 192, 3, 6, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 1480.00),
(130, 'ASUS', 'PRIME Z790-P WIFI', 'LGA1700', 'Z790', 'DDR5', 'ATX', 4, 192, 3, 6, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 1040.00),
(131, 'ASUS', 'TUF GAMING B760-PLUS WIFI', 'LGA1700', 'B760', 'DDR5', 'ATX', 4, 192, 2, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 620.00),
(132, 'ASUS', 'ROG STRIX B760-F GAMING WIFI', 'LGA1700', 'B760', 'DDR5', 'ATX', 4, 192, 3, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 960.00),
(133, 'ASUS', 'PRIME B760M-A WIFI', 'LGA1700', 'B760', 'DDR5', 'micro-ATX', 4, 192, 2, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 520.00),
(135, 'MSI', 'MAG B760 TOMAHAWK WIFI', 'LGA1700', 'B760', 'DDR5', 'ATX', 4, 192, 3, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 740.00),
(136, 'MSI', 'PRO B760-P WIFI', 'LGA1700', 'B760', 'DDR5', 'ATX', 4, 192, 2, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 520.00),
(137, 'MSI', 'B760M MORTAR WIFI II', 'LGA1700', 'B760', 'DDR5', 'micro-ATX', 4, 192, 3, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 740.00),
(138, 'MSI', 'PRO B760M-A WIFI DDR4', 'LGA1700', 'B760', 'DDR4', 'micro-ATX', 4, 128, 2, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 520.00),
(139, 'GIGABYTE', 'B760 AORUS ELITE AX', 'LGA1700', 'B760', 'DDR5', 'ATX', 4, 192, 3, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 740.00),
(140, 'GIGABYTE', 'B760 GAMING X AX', 'LGA1700', 'B760', 'DDR5', 'ATX', 4, 192, 2, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 620.00),
(141, 'GIGABYTE', 'B760M DS3H AX DDR4', 'LGA1700', 'B760', 'DDR4', 'micro-ATX', 4, 128, 2, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 500.00),
(142, 'ASRock', 'B760 Steel Legend WiFi', 'LGA1700', 'B760', 'DDR5', 'ATX', 4, 192, 2, 4, 'PCIe 4.0 x16', '2.5 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 740.00),
(146, 'ASUS', 'PRIME H610M-A WIFI D4', 'LGA1700', 'H610', 'DDR4', 'micro-ATX', 4, 128, 1, 4, 'PCIe 4.0 x16', '1 GbE', 'Wi-Fi 5', 'Bluetooth 5.0/5.2', 'Brak', 280.00),
(150, 'ASUS', 'PRIME Z690-P WIFI', 'LGA1700', 'Z690', 'DDR5', 'ATX', 4, 192, 3, 6, 'PCIe 5.0 x16', '2.5 GbE', 'Wi-Fi 6', 'Bluetooth 5.0/5.2', 'Brak', 810.00);

-- --------------------------------------------------------

--
--  `power_supplies`
--

CREATE TABLE `power_supplies` (
  `id` int(10) UNSIGNED NOT NULL,
  `manufacturer` varchar(50) NOT NULL,
  `model` varchar(80) NOT NULL,
  `wattage_w` smallint(5) UNSIGNED NOT NULL,
  `wattage_class` enum('entry','mainstream','high','enthusiast') NOT NULL,
  `form_factor` enum('ATX','SFX') NOT NULL,
  `efficiency_cert` enum('80 Plus Bronze','80 Plus Gold','80 Plus Platinum','80 Plus Titanium') NOT NULL,
  `modularity` enum('Non-modular','Fully modular') NOT NULL,
  `atx_standard` enum('ATX 2.x','ATX 3.0','ATX 3.1') NOT NULL,
  `native_12v_2x6` tinyint(1) NOT NULL COMMENT '1 = native 12VHPWR / 12V-2x6 cable included',
  `pcie_8pin_connectors` tinyint(3) UNSIGNED NOT NULL COMMENT 'approx. number of PCIe 6+2 pin connectors',
  `fan_size_mm` smallint(5) UNSIGNED NOT NULL,
  `warranty_years` tinyint(3) UNSIGNED NOT NULL,
  `price_pln` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
--  `power_supplies`
--

INSERT INTO `power_supplies` (`id`, `manufacturer`, `model`, `wattage_w`, `wattage_class`, `form_factor`, `efficiency_cert`, `modularity`, `atx_standard`, `native_12v_2x6`, `pcie_8pin_connectors`, `fan_size_mm`, `warranty_years`, `price_pln`) VALUES
(1, 'be quiet!', 'System Power 10 450W', 450, 'entry', 'ATX', '80 Plus Bronze', 'Non-modular', 'ATX 2.x', 0, 2, 120, 3, 199.00),
(2, 'Endorfy', 'Elementum E5 500W', 500, 'entry', 'ATX', '80 Plus Bronze', 'Non-modular', 'ATX 2.x', 0, 2, 120, 3, 189.00),
(3, 'Corsair', 'CV550', 550, 'entry', 'ATX', '80 Plus Bronze', 'Non-modular', 'ATX 2.x', 0, 2, 120, 3, 229.00),
(4, 'MSI', 'MAG A550BN', 550, 'entry', 'ATX', '80 Plus Bronze', 'Non-modular', 'ATX 2.x', 0, 2, 120, 3, 229.00),
(5, 'be quiet!', 'SFX Power 3 450W', 450, 'entry', 'SFX', '80 Plus Bronze', 'Non-modular', 'ATX 2.x', 0, 2, 80, 3, 269.00),
(6, 'Thermaltake', 'Smart BX1 550W', 550, 'entry', 'ATX', '80 Plus Bronze', 'Non-modular', 'ATX 2.x', 0, 2, 120, 3, 219.00),
(7, 'Endorfy', 'Vero L5 Bronze 600W', 600, 'mainstream', 'ATX', '80 Plus Bronze', 'Non-modular', 'ATX 2.x', 0, 2, 120, 3, 259.00),
(8, 'Corsair', 'CX650', 650, 'mainstream', 'ATX', '80 Plus Bronze', 'Non-modular', 'ATX 2.x', 0, 2, 120, 3, 319.00),
(9, 'be quiet!', 'Pure Power 12 M 650W', 650, 'mainstream', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.0', 1, 3, 120, 5, 369.00),
(10, 'Corsair', 'RM650e', 650, 'mainstream', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.1', 1, 3, 120, 7, 449.00),
(11, 'Corsair', 'RM750e', 750, 'mainstream', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.1', 1, 4, 120, 7, 499.00),
(12, 'Seasonic', 'Focus GX-750', 750, 'mainstream', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.1', 1, 4, 120, 10, 579.00),
(13, 'be quiet!', 'Pure Power 12 M 750W', 750, 'mainstream', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.0', 1, 4, 120, 5, 449.00),
(14, 'MSI', 'MAG A750GL PCIE5', 750, 'mainstream', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.0', 1, 4, 120, 10, 379.00),
(15, 'Gigabyte', 'UD750GM PG5', 750, 'mainstream', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.0', 1, 4, 120, 5, 369.00),
(16, 'ASUS', 'TUF Gaming 750G', 750, 'mainstream', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.0', 1, 4, 120, 10, 449.00),
(17, 'Fractal Design', 'Ion+ 2 Platinum 760W', 760, 'mainstream', 'ATX', '80 Plus Platinum', 'Fully modular', 'ATX 2.x', 0, 4, 140, 10, 649.00),
(18, 'Corsair', 'SF750 Platinum (2024)', 750, 'mainstream', 'SFX', '80 Plus Platinum', 'Fully modular', 'ATX 3.1', 1, 3, 92, 7, 699.00),
(19, 'Thermaltake', 'Toughpower GF A3 850W', 850, 'high', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.0', 1, 4, 140, 7, 549.00),
(20, 'Corsair', 'RM850x (2024)', 850, 'high', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.1', 1, 4, 135, 10, 649.00),
(21, 'be quiet!', 'Pure Power 12 M 850W', 850, 'high', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.0', 1, 4, 120, 5, 519.00),
(22, 'MSI', 'MAG A850GL PCIE5', 850, 'high', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.0', 1, 4, 120, 10, 429.00),
(23, 'Gigabyte', 'UD850GM PG5', 850, 'high', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.0', 1, 4, 120, 5, 449.00),
(24, 'ASUS', 'ROG Strix 850G', 850, 'high', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.0', 1, 4, 135, 10, 649.00),
(25, 'Seasonic', 'Focus GX-850', 850, 'high', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.1', 1, 4, 120, 10, 659.00),
(26, 'Cooler Master', 'V850 SFX Gold', 850, 'high', 'SFX', '80 Plus Gold', 'Fully modular', 'ATX 3.0', 1, 3, 92, 10, 649.00),
(27, 'be quiet!', 'Straight Power 12 850W', 850, 'high', 'ATX', '80 Plus Platinum', 'Fully modular', 'ATX 3.0', 1, 4, 135, 10, 799.00),
(28, 'NZXT', 'C1000 Gold (ATX 3.1)', 1000, 'high', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.1', 1, 4, 135, 10, 749.00),
(29, 'Corsair', 'RM1000x', 1000, 'high', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.1', 1, 4, 135, 10, 799.00),
(30, 'MSI', 'MPG A1000G PCIE5', 1000, 'high', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.0', 1, 4, 135, 10, 629.00),
(31, 'Thermaltake', 'Toughpower GF3 1000W', 1000, 'high', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.0', 1, 4, 140, 10, 729.00),
(32, 'Super Flower', 'Leadex VII XG 1000W', 1000, 'high', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.0', 1, 4, 135, 10, 799.00),
(33, 'Seasonic', 'Vertex GX-1000', 1000, 'high', 'ATX', '80 Plus Gold', 'Fully modular', 'ATX 3.0', 1, 4, 135, 12, 899.00),
(34, 'be quiet!', 'Straight Power 12 1000W', 1000, 'high', 'ATX', '80 Plus Platinum', 'Fully modular', 'ATX 3.0', 1, 4, 135, 10, 949.00),
(35, 'Corsair', 'HX1000i (2023)', 1000, 'high', 'ATX', '80 Plus Platinum', 'Fully modular', 'ATX 3.0', 1, 4, 140, 10, 1099.00),
(36, 'be quiet!', 'Dark Power 13 1000W', 1000, 'high', 'ATX', '80 Plus Titanium', 'Fully modular', 'ATX 3.0', 1, 4, 135, 10, 1399.00),
(37, 'be quiet!', 'Straight Power 12 1200W', 1200, 'enthusiast', 'ATX', '80 Plus Platinum', 'Fully modular', 'ATX 3.0', 1, 6, 135, 10, 1139.00),
(38, 'ASUS', 'ROG Thor 1200W Platinum II', 1200, 'enthusiast', 'ATX', '80 Plus Platinum', 'Fully modular', 'ATX 3.0', 1, 6, 135, 10, 1749.00),
(39, 'Corsair', 'HX1500i', 1500, 'enthusiast', 'ATX', '80 Plus Platinum', 'Fully modular', 'ATX 3.0', 1, 6, 140, 10, 1499.00),
(40, 'Corsair', 'AX1600i', 1600, 'enthusiast', 'ATX', '80 Plus Titanium', 'Fully modular', 'ATX 2.x', 0, 8, 140, 10, 2899.00);

-- --------------------------------------------------------

--
--  `procesory`
--

CREATE TABLE `procesory` (
  `id` int(10) UNSIGNED NOT NULL,
  `producent` varchar(20) NOT NULL,
  `model` varchar(100) NOT NULL,
  `seria` varchar(60) NOT NULL,
  `architektura` varchar(40) NOT NULL,
  `socket` varchar(20) NOT NULL,
  `rdzenie` tinyint(3) UNSIGNED NOT NULL,
  `watki` smallint(5) UNSIGNED NOT NULL,
  `taktowanie_boost_ghz` decimal(3,1) NOT NULL,
  `cache_l3_mb` smallint(5) UNSIGNED NOT NULL,
  `tdp_w` smallint(5) UNSIGNED NOT NULL,
  `limit_mocy_turbo_w` smallint(5) UNSIGNED NOT NULL,
  `pamiec_ram` varchar(20) NOT NULL,
  `pcie` varchar(30) NOT NULL,
  `zintegrowana_grafika` tinyint(1) NOT NULL DEFAULT 0,
  `cena_pln` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
--  `procesory`
--

INSERT INTO `procesory` (`id`, `producent`, `model`, `seria`, `architektura`, `socket`, `rdzenie`, `watki`, `taktowanie_boost_ghz`, `cache_l3_mb`, `tdp_w`, `limit_mocy_turbo_w`, `pamiec_ram`, `pcie`, `zintegrowana_grafika`, `cena_pln`) VALUES
(1, 'AMD', 'Ryzen 7 7700X3D', 'Ryzen 7000', 'Zen 4', 'AM5', 8, 16, 4.5, 96, 120, 162, 'DDR5', 'PCIe 5.0', 1, 1424.00),
(2, 'AMD', 'Ryzen 5 7500X3D', 'Ryzen 7000', 'Zen 4', 'AM5', 6, 12, 4.5, 96, 65, 88, 'DDR5', 'PCIe 5.0', 1, 939.00),
(3, 'AMD', 'Ryzen 9 9900X3D', 'Ryzen 9000', 'Zen 5', 'AM5', 12, 24, 5.5, 128, 120, 162, 'DDR5', 'PCIe 5.0', 1, 2099.00),
(4, 'AMD', 'Ryzen 9 9950X3D', 'Ryzen 9000', 'Zen 5', 'AM5', 16, 32, 5.7, 128, 170, 230, 'DDR5', 'PCIe 5.0', 1, 2699.00),
(5, 'AMD', 'Ryzen 5 9600', 'Ryzen 9000', 'Zen 5', 'AM5', 6, 12, 5.2, 32, 65, 88, 'DDR5', 'PCIe 5.0', 1, 739.00),
(6, 'AMD', 'Ryzen 7 9800X3D', 'Ryzen 9000', 'Zen 5', 'AM5', 8, 16, 5.2, 96, 120, 162, 'DDR5', 'PCIe 5.0', 1, 1729.00),
(7, 'AMD', 'Ryzen 5 5600T', 'Ryzen 5000', 'Zen 3', 'AM4', 6, 12, 4.5, 32, 65, 88, 'DDR4', 'PCIe 4.0', 0, 689.00),
(8, 'AMD', 'Ryzen 5 5600XT', 'Ryzen 5000', 'Zen 3', 'AM4', 6, 12, 4.7, 32, 65, 88, 'DDR4', 'PCIe 4.0', 0, 864.00),
(9, 'AMD', 'Ryzen 9 9900X', 'Ryzen 9000', 'Zen 5', 'AM5', 12, 24, 5.6, 64, 120, 162, 'DDR5', 'PCIe 5.0', 1, 1542.00),
(10, 'AMD', 'Ryzen 9 9950X', 'Ryzen 9000', 'Zen 5', 'AM5', 16, 32, 5.7, 64, 170, 230, 'DDR5', 'PCIe 5.0', 1, 2004.00),
(11, 'AMD', 'Ryzen 5 9600X', 'Ryzen 9000', 'Zen 5', 'AM5', 6, 12, 5.4, 32, 65, 88, 'DDR5', 'PCIe 5.0', 1, 779.00),
(12, 'AMD', 'Ryzen 7 9700X', 'Ryzen 9000', 'Zen 5', 'AM5', 8, 16, 5.5, 32, 65, 88, 'DDR5', 'PCIe 5.0', 1, 1040.00),
(13, 'AMD', 'Ryzen 7 5800XT', 'Ryzen 5000', 'Zen 3', 'AM4', 8, 16, 4.8, 32, 105, 142, 'DDR4', 'PCIe 4.0', 0, 1134.00),
(14, 'AMD', 'Ryzen 9 5900XT', 'Ryzen 5000', 'Zen 3', 'AM4', 16, 32, 4.8, 64, 105, 142, 'DDR4', 'PCIe 4.0', 0, 1600.00),
(15, 'AMD', 'Ryzen 5 8400F', 'Ryzen 8000', 'Zen 4', 'AM5', 6, 12, 4.7, 16, 65, 88, 'DDR5', 'PCIe 4.0', 0, 395.00),
(16, 'AMD', 'Ryzen 7 8700F', 'Ryzen 8000', 'Zen 4', 'AM5', 8, 16, 5.0, 16, 65, 88, 'DDR5', 'PCIe 5.0', 0, 612.00),
(17, 'AMD', 'Ryzen 5 7500F', 'Ryzen 7000', 'Zen 4', 'AM5', 6, 12, 5.0, 32, 65, 88, 'DDR5', 'PCIe 5.0', 0, 549.00),
(18, 'AMD', 'Ryzen 7 7800X3D', 'Ryzen 7000', 'Zen 4', 'AM5', 8, 16, 5.0, 96, 120, 162, 'DDR5', 'PCIe 5.0', 1, 1269.00),
(19, 'AMD', 'Ryzen 9 7900X3D', 'Ryzen 7000', 'Zen 4', 'AM5', 12, 24, 5.6, 128, 120, 162, 'DDR5', 'PCIe 5.0', 1, 2100.00),
(20, 'AMD', 'Ryzen 9 7950X3D', 'Ryzen 7000', 'Zen 4', 'AM5', 16, 32, 5.7, 128, 120, 162, 'DDR5', 'PCIe 5.0', 1, 2100.00),
(21, 'AMD', 'Ryzen 5 7600', 'Ryzen 7000', 'Zen 4', 'AM5', 6, 12, 5.1, 32, 65, 88, 'DDR5', 'PCIe 5.0', 1, 650.00),
(22, 'AMD', 'Ryzen 7 7700', 'Ryzen 7000', 'Zen 4', 'AM5', 8, 16, 5.3, 32, 65, 88, 'DDR5', 'PCIe 5.0', 1, 779.00),
(23, 'AMD', 'Ryzen 9 7900', 'Ryzen 7000', 'Zen 4', 'AM5', 12, 24, 5.4, 64, 65, 88, 'DDR5', 'PCIe 5.0', 1, 1600.00),
(24, 'AMD', 'Ryzen 5 7600X', 'Ryzen 7000', 'Zen 4', 'AM5', 6, 12, 5.3, 32, 105, 142, 'DDR5', 'PCIe 5.0', 1, 705.00),
(25, 'AMD', 'Ryzen 7 7700X', 'Ryzen 7000', 'Zen 4', 'AM5', 8, 16, 5.4, 32, 105, 142, 'DDR5', 'PCIe 5.0', 1, 950.00),
(26, 'AMD', 'Ryzen 9 7900X', 'Ryzen 7000', 'Zen 4', 'AM5', 12, 24, 5.6, 64, 170, 230, 'DDR5', 'PCIe 5.0', 1, 1600.00),
(27, 'AMD', 'Ryzen 9 7950X', 'Ryzen 7000', 'Zen 4', 'AM5', 16, 32, 5.7, 64, 170, 230, 'DDR5', 'PCIe 5.0', 1, 1600.00),
(28, 'Intel', 'Core i3-14100', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 4, 8, 4.7, 12, 60, 110, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 1, 589.00),
(29, 'Intel', 'Core i3-14100F', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 4, 8, 4.7, 12, 58, 110, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 0, 550.00),
(30, 'Intel', 'Core i3-14100T', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 4, 8, 4.4, 12, 35, 69, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 1, 550.00),
(31, 'Intel', 'Core i5-14400', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 10, 16, 4.7, 20, 65, 148, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 1, 749.00),
(32, 'Intel', 'Core i5-14400F', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 10, 16, 4.7, 20, 65, 148, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 0, 699.00),
(33, 'Intel', 'Core i5-14400T', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 10, 16, 4.5, 20, 35, 82, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 1, 850.00),
(36, 'Intel', 'Core i5-14500', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 14, 20, 5.0, 24, 65, 154, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 1, 850.00),
(37, 'Intel', 'Core i5-14500T', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 14, 20, 4.8, 24, 35, 92, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 1, 850.00),
(40, 'Intel', 'Core i5-14600', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 14, 20, 5.2, 24, 65, 154, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 1, 850.00),
(41, 'Intel', 'Core i5-14600K', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 14, 20, 5.3, 24, 125, 181, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 1, 850.00),
(42, 'Intel', 'Core i5-14600KF', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 14, 20, 5.3, 24, 125, 181, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 0, 850.00),
(43, 'Intel', 'Core i5-14600T', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 14, 20, 5.1, 24, 35, 92, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 1, 850.00),
(44, 'Intel', 'Core i7-14700', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 20, 28, 5.4, 33, 65, 219, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 1, 1450.00),
(45, 'Intel', 'Core i7-14700F', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 20, 28, 5.4, 33, 65, 219, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 0, 1529.00),
(46, 'Intel', 'Core i7-14700K', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 20, 28, 5.6, 33, 125, 253, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 1, 1719.00),
(47, 'Intel', 'Core i7-14700KF', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 20, 28, 5.6, 33, 125, 253, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 0, 1559.00),
(48, 'Intel', 'Core i7-14700T', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 20, 28, 5.2, 33, 35, 106, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 1, 1450.00),
(51, 'Intel', 'Core i9-14900', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 24, 32, 5.8, 36, 65, 219, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 1, 2400.00),
(52, 'Intel', 'Core i9-14900F', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 24, 32, 5.8, 36, 65, 219, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 0, 2400.00),
(53, 'Intel', 'Core i9-14900K', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 24, 32, 6.0, 36, 125, 253, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 1, 2614.00),
(54, 'Intel', 'Core i9-14900KF', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 24, 32, 6.0, 36, 125, 253, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 0, 2400.00),
(55, 'Intel', 'Core i9-14900KS', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 24, 32, 6.2, 36, 150, 253, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 1, 2400.00),
(56, 'Intel', 'Core i9-14900T', 'Core 14. generacji', 'Raptor Lake Refresh', 'LGA1700', 24, 32, 5.5, 36, 35, 106, 'DDR4/DDR5', 'PCIe 5.0 / 4.0', 1, 2400.00),
(59, 'Intel', 'Core Ultra 5 225', 'Core Ultra 200S', 'Arrow Lake', 'LGA1851', 10, 10, 4.9, 20, 65, 121, 'DDR5', 'PCIe 5.0 / 4.0', 1, 850.00),
(60, 'Intel', 'Core Ultra 5 225F', 'Core Ultra 200S', 'Arrow Lake', 'LGA1851', 10, 10, 4.9, 20, 65, 121, 'DDR5', 'PCIe 5.0 / 4.0', 0, 595.00),
(61, 'Intel', 'Core Ultra 5 225T', 'Core Ultra 200S', 'Arrow Lake', 'LGA1851', 10, 10, 4.9, 20, 35, 112, 'DDR5', 'PCIe 5.0 / 4.0', 1, 850.00),
(62, 'Intel', 'Core Ultra 5 235', 'Core Ultra 200S', 'Arrow Lake', 'LGA1851', 14, 14, 5.0, 24, 65, 121, 'DDR5', 'PCIe 5.0 / 4.0', 1, 850.00),
(64, 'Intel', 'Core Ultra 5 235T', 'Core Ultra 200S', 'Arrow Lake', 'LGA1851', 14, 14, 5.0, 24, 35, 112, 'DDR5', 'PCIe 5.0 / 4.0', 1, 850.00),
(66, 'Intel', 'Core Ultra 5 245', 'Core Ultra 200S', 'Arrow Lake', 'LGA1851', 14, 14, 5.1, 24, 65, 121, 'DDR5', 'PCIe 5.0 / 4.0', 1, 850.00),
(67, 'Intel', 'Core Ultra 5 245K', 'Core Ultra 200S', 'Arrow Lake', 'LGA1851', 14, 14, 5.2, 24, 125, 159, 'DDR5', 'PCIe 5.0 / 4.0', 1, 850.00),
(68, 'Intel', 'Core Ultra 5 245KF', 'Core Ultra 200S', 'Arrow Lake', 'LGA1851', 14, 14, 5.2, 24, 125, 159, 'DDR5', 'PCIe 5.0 / 4.0', 0, 749.00),
(69, 'Intel', 'Core Ultra 5 245T', 'Core Ultra 200S', 'Arrow Lake', 'LGA1851', 14, 14, 5.1, 24, 35, 112, 'DDR5', 'PCIe 5.0 / 4.0', 1, 850.00),
(70, 'Intel', 'Core Ultra 5 250KF Plus', 'Core Ultra 200S Plus', 'Arrow Lake Refresh', 'LGA1851', 18, 18, 5.3, 30, 125, 159, 'DDR5', 'PCIe 5.0 / 4.0', 0, 925.00),
(71, 'Intel', 'Core Ultra 5 250K Plus', 'Core Ultra 200S Plus', 'Arrow Lake Refresh', 'LGA1851', 18, 18, 5.3, 30, 125, 159, 'DDR5', 'PCIe 5.0 / 4.0', 1, 949.00),
(72, 'Intel', 'Core Ultra 7 265', 'Core Ultra 200S', 'Arrow Lake', 'LGA1851', 20, 20, 5.3, 30, 65, 182, 'DDR5', 'PCIe 5.0 / 4.0', 1, 1450.00),
(73, 'Intel', 'Core Ultra 7 265F', 'Core Ultra 200S', 'Arrow Lake', 'LGA1851', 20, 20, 5.3, 30, 65, 182, 'DDR5', 'PCIe 5.0 / 4.0', 0, 1450.00),
(74, 'Intel', 'Core Ultra 7 265K', 'Core Ultra 200S', 'Arrow Lake', 'LGA1851', 20, 20, 5.5, 30, 125, 250, 'DDR5', 'PCIe 5.0 / 4.0', 1, 1450.00),
(75, 'Intel', 'Core Ultra 7 265KF', 'Core Ultra 200S', 'Arrow Lake', 'LGA1851', 20, 20, 5.5, 30, 125, 250, 'DDR5', 'PCIe 5.0 / 4.0', 0, 1239.00),
(76, 'Intel', 'Core Ultra 7 265T', 'Core Ultra 200S', 'Arrow Lake', 'LGA1851', 20, 20, 5.3, 30, 35, 112, 'DDR5', 'PCIe 5.0 / 4.0', 1, 1450.00),
(77, 'Intel', 'Core Ultra 7 270K Plus', 'Core Ultra 200S Plus', 'Arrow Lake Refresh', 'LGA1851', 24, 24, 5.5, 36, 125, 250, 'DDR5', 'PCIe 5.0 / 4.0', 1, 1499.00),
(78, 'Intel', 'Core Ultra 9 285', 'Core Ultra 200S', 'Arrow Lake', 'LGA1851', 24, 24, 5.6, 36, 65, 182, 'DDR5', 'PCIe 5.0 / 4.0', 1, 2739.00),
(79, 'Intel', 'Core Ultra 9 285K', 'Core Ultra 200S', 'Arrow Lake', 'LGA1851', 24, 24, 5.7, 36, 125, 250, 'DDR5', 'PCIe 5.0 / 4.0', 1, 2385.00),
(80, 'Intel', 'Core Ultra 9 285T', 'Core Ultra 200S', 'Arrow Lake', 'LGA1851', 24, 24, 5.4, 36, 35, 112, 'DDR5', 'PCIe 5.0 / 4.0', 1, 2500.00),
(81, 'AMD', 'Ryzen 3 8300G', 'Ryzen 8000G', 'Zen 4', 'AM5', 4, 8, 4.9, 8, 65, 88, 'DDR5', 'PCIe 4.0', 1, 500.00),
(82, 'AMD', 'Ryzen 3 8300GE', 'Ryzen 8000G', 'Zen 4', 'AM5', 4, 8, 4.9, 8, 35, 47, 'DDR5', 'PCIe 4.0', 1, 950.00),
(85, 'AMD', 'Ryzen 3 PRO 5355G', 'Ryzen 5000 PRO', 'Zen 3', 'AM4', 4, 8, 4.2, 8, 65, 88, 'DDR4', 'PCIe 3.0', 1, 950.00),
(86, 'AMD', 'Ryzen 3 PRO 5355GE', 'Ryzen 5000 PRO', 'Zen 3', 'AM4', 4, 8, 4.2, 8, 35, 47, 'DDR4', 'PCIe 3.0', 1, 950.00),
(87, 'AMD', 'Ryzen 3 PRO 8300G', 'Ryzen 8000G PRO', 'Zen 4', 'AM5', 4, 8, 4.9, 8, 65, 88, 'DDR5', 'PCIe 4.0', 1, 950.00),
(88, 'AMD', 'Ryzen 3 PRO 8300GE', 'Ryzen 8000G PRO', 'Zen 4', 'AM5', 4, 8, 4.9, 8, 35, 47, 'DDR5', 'PCIe 4.0', 1, 950.00),
(91, 'AMD', 'Ryzen 5 5500F', 'Ryzen 5000', 'Zen 3', 'AM4', 6, 12, 4.4, 16, 65, 88, 'DDR4', 'PCIe 3.0', 0, 650.00),
(92, 'AMD', 'Ryzen 5 5500X3D', 'Ryzen 5000', 'Zen 3', 'AM4', 6, 12, 4.0, 96, 105, 142, 'DDR4', 'PCIe 3.0', 0, 1000.00),
(93, 'AMD', 'Ryzen 5 5600F', 'Ryzen 5000', 'Zen 3', 'AM4', 6, 12, 4.0, 32, 65, 88, 'DDR4', 'PCIe 3.0', 0, 650.00),
(94, 'AMD', 'Ryzen 5 5600X', 'Ryzen 5000', 'Zen 3', 'AM4', 6, 12, 4.6, 32, 65, 88, 'DDR4', 'PCIe 4.0', 0, 510.00),
(95, 'AMD', 'Ryzen 5 7400', 'Ryzen 7000', 'Zen 4', 'AM5', 6, 12, 4.3, 16, 65, 88, 'DDR5', 'PCIe 5.0', 1, 536.00),
(96, 'AMD', 'Ryzen 5 7400F', 'Ryzen 7000', 'Zen 4', 'AM5', 6, 12, 4.7, 32, 65, 88, 'DDR5', 'PCIe 4.0', 0, 650.00),
(97, 'AMD', 'Ryzen 5 7500', 'Ryzen 7000', 'Zen 4', 'AM5', 6, 12, 5.0, 32, 65, 88, 'DDR5', 'PCIe 5.0', 1, 650.00),
(98, 'AMD', 'Ryzen 5 7600X3D', 'Ryzen 7000', 'Zen 4', 'AM5', 6, 12, 4.7, 96, 65, 88, 'DDR5', 'PCIe 5.0', 1, 1000.00),
(99, 'AMD', 'Ryzen 5 8500G', 'Ryzen 8000G', 'Zen 4', 'AM5', 6, 12, 5.0, 16, 65, 88, 'DDR5', 'PCIe 4.0', 1, 499.00),
(100, 'AMD', 'Ryzen 5 8500GE', 'Ryzen 8000G', 'Zen 4', 'AM5', 6, 12, 5.0, 16, 35, 47, 'DDR5', 'PCIe 4.0', 1, 950.00),
(103, 'AMD', 'Ryzen 5 8600G', 'Ryzen 8000G', 'Zen 4', 'AM5', 6, 12, 5.0, 16, 65, 88, 'DDR5', 'PCIe 4.0', 1, 749.00),
(104, 'AMD', 'Ryzen 5 8605G', 'Ryzen 8000G', 'Zen 4', 'AM5', 6, 12, 5.0, 16, 65, 88, 'DDR5', 'PCIe 4.0', 1, 650.00),
(105, 'AMD', 'Ryzen 5 9500F', 'Ryzen 9000', 'Zen 5', 'AM5', 6, 12, 5.0, 32, 65, 88, 'DDR5', 'PCIe 5.0', 0, 719.00),
(106, 'AMD', 'Ryzen 5 PRO 5655G', 'Ryzen 5000 PRO', 'Zen 3', 'AM4', 6, 12, 4.4, 16, 65, 88, 'DDR4', 'PCIe 3.0', 1, 950.00),
(107, 'AMD', 'Ryzen 5 PRO 5655GE', 'Ryzen 5000 PRO', 'Zen 3', 'AM4', 6, 12, 4.4, 16, 35, 47, 'DDR4', 'PCIe 3.0', 1, 950.00),
(108, 'AMD', 'Ryzen 5 PRO 8500G', 'Ryzen 8000G PRO', 'Zen 4', 'AM5', 6, 12, 5.0, 16, 65, 88, 'DDR5', 'PCIe 4.0', 1, 950.00),
(109, 'AMD', 'Ryzen 5 PRO 8500GE', 'Ryzen 8000G PRO', 'Zen 4', 'AM5', 6, 12, 5.0, 16, 35, 47, 'DDR5', 'PCIe 4.0', 1, 950.00),
(112, 'AMD', 'Ryzen 5 PRO 8600G', 'Ryzen 8000G PRO', 'Zen 4', 'AM5', 6, 12, 5.0, 16, 65, 88, 'DDR5', 'PCIe 4.0', 1, 950.00),
(113, 'AMD', 'Ryzen 5 PRO 8600GE', 'Ryzen 8000G PRO', 'Zen 4', 'AM5', 6, 12, 5.0, 16, 35, 47, 'DDR5', 'PCIe 4.0', 1, 950.00),
(114, 'AMD', 'Ryzen 5 PRO 8605G', 'Ryzen 8000G PRO', 'Zen 4', 'AM5', 6, 12, 5.0, 16, 65, 88, 'DDR5', 'PCIe 4.0', 1, 950.00),
(115, 'AMD', 'Ryzen 5 PRO 8605GE', 'Ryzen 8000G PRO', 'Zen 4', 'AM5', 6, 12, 5.0, 16, 35, 47, 'DDR5', 'PCIe 4.0', 1, 950.00),
(116, 'AMD', 'Ryzen 5 PRO 9645', 'Ryzen 9000 PRO', 'Zen 5', 'AM5', 6, 12, 5.4, 32, 65, 88, 'DDR5', 'PCIe 5.0', 1, 950.00),
(117, 'AMD', 'Ryzen 5 PRO 9655', 'Ryzen 9000 PRO', 'Zen 5', 'AM5', 6, 12, 5.4, 32, 120, 162, 'DDR5', 'PCIe 5.0', 1, 950.00),
(118, 'AMD', 'Ryzen 7 4700LE', 'Ryzen 4000', 'Zen 2', 'AM4', 8, 16, 4.2, 8, 65, 88, 'DDR4', 'PCIe 4.0', 1, 1450.00),
(119, 'AMD', 'Ryzen 7 5800X', 'Ryzen 5000', 'Zen 3', 'AM4', 8, 16, 4.7, 32, 105, 142, 'DDR4', 'PCIe 4.0', 0, 700.00),
(120, 'AMD', 'Ryzen 7 5800X3D', 'Ryzen 5000', 'Zen 3', 'AM4', 8, 16, 4.5, 96, 105, 142, 'DDR4', 'PCIe 4.0', 0, 1500.00),
(121, 'AMD', 'Ryzen 7 8700G', 'Ryzen 8000G', 'Zen 4', 'AM5', 8, 16, 5.1, 16, 65, 88, 'DDR5', 'PCIe 4.0', 1, 950.00),
(123, 'AMD', 'Ryzen 7 9700F', 'Ryzen 9000', 'Zen 5', 'AM5', 8, 16, 5.5, 32, 65, 88, 'DDR5', 'PCIe 5.0', 0, 950.00),
(124, 'AMD', 'Ryzen 7 9850X3D', 'Ryzen 9000', 'Zen 5', 'AM5', 8, 16, 5.6, 96, 120, 162, 'DDR5', 'PCIe 5.0', 1, 1896.00),
(125, 'AMD', 'Ryzen 7 PRO 5755G', 'Ryzen 5000 PRO', 'Zen 3', 'AM4', 8, 16, 4.6, 16, 65, 88, 'DDR4', 'PCIe 3.0', 1, 1450.00),
(126, 'AMD', 'Ryzen 7 PRO 5755GE', 'Ryzen 5000 PRO', 'Zen 3', 'AM4', 8, 16, 4.6, 16, 35, 47, 'DDR4', 'PCIe 3.0', 1, 1450.00),
(127, 'AMD', 'Ryzen 7 PRO 8700G', 'Ryzen 8000G PRO', 'Zen 4', 'AM5', 8, 16, 5.1, 16, 65, 88, 'DDR5', 'PCIe 4.0', 1, 1450.00),
(128, 'AMD', 'Ryzen 7 PRO 8700GE', 'Ryzen 8000G PRO', 'Zen 4', 'AM5', 8, 16, 5.1, 16, 35, 47, 'DDR5', 'PCIe 4.0', 1, 1450.00),
(131, 'AMD', 'Ryzen 7 PRO 9745', 'Ryzen 9000 PRO', 'Zen 5', 'AM5', 8, 16, 5.4, 32, 65, 88, 'DDR5', 'PCIe 5.0', 1, 1450.00),
(132, 'AMD', 'Ryzen 7 PRO 9755', 'Ryzen 9000 PRO', 'Zen 5', 'AM5', 8, 16, 5.4, 32, 120, 162, 'DDR5', 'PCIe 5.0', 1, 1450.00),
(134, 'AMD', 'Ryzen 9 5900X', 'Ryzen 5000', 'Zen 3', 'AM4', 12, 24, 4.8, 64, 105, 142, 'DDR4', 'PCIe 4.0', 0, 900.00),
(135, 'AMD', 'Ryzen 9 5950X', 'Ryzen 5000', 'Zen 3', 'AM4', 16, 32, 4.9, 64, 105, 142, 'DDR4', 'PCIe 4.0', 0, 1200.00),
(136, 'AMD', 'Ryzen 9 9950X3D2 Dual Edition', 'Ryzen 9000', 'Zen 5', 'AM5', 16, 32, 5.6, 192, 200, 280, 'DDR5', 'PCIe 5.0', 1, 3799.00),
(137, 'AMD', 'Ryzen 9 PRO 9945', 'Ryzen 9000 PRO', 'Zen 5', 'AM5', 12, 24, 5.4, 64, 65, 88, 'DDR5', 'PCIe 5.0', 1, 1450.00),
(138, 'AMD', 'Ryzen 9 PRO 9955', 'Ryzen 9000 PRO', 'Zen 5', 'AM5', 12, 24, 5.4, 64, 120, 162, 'DDR5', 'PCIe 5.0', 1, 1450.00),
(139, 'AMD', 'Ryzen 9 PRO 9965', 'Ryzen 9000 PRO', 'Zen 5', 'AM5', 16, 32, 5.5, 64, 170, 230, 'DDR5', 'PCIe 5.0', 1, 1450.00),
(141, 'AMD', 'Ryzen AI 5 435G', 'Ryzen AI 400G', 'Zen 5', 'AM5', 6, 12, 4.5, 8, 65, 88, 'DDR5', 'PCIe 4.0', 1, 500.00),
(142, 'AMD', 'Ryzen AI 5 435GE', 'Ryzen AI 400G', 'Zen 5', 'AM5', 6, 12, 4.5, 8, 35, 47, 'DDR5', 'PCIe 4.0', 1, 950.00),
(143, 'AMD', 'Ryzen AI 5 440G', 'Ryzen AI 400G', 'Zen 5', 'AM5', 6, 12, 4.8, 16, 65, 88, 'DDR5', 'PCIe 4.0', 1, 500.00),
(144, 'AMD', 'Ryzen AI 5 440GE', 'Ryzen AI 400G', 'Zen 5', 'AM5', 6, 12, 4.8, 16, 35, 47, 'DDR5', 'PCIe 4.0', 1, 950.00),
(145, 'AMD', 'Ryzen AI 5 PRO 435G', 'Ryzen AI 400G PRO', 'Zen 5', 'AM5', 6, 12, 4.5, 8, 65, 88, 'DDR5', 'PCIe 4.0', 1, 950.00),
(146, 'AMD', 'Ryzen AI 5 PRO 435GE', 'Ryzen AI 400G PRO', 'Zen 5', 'AM5', 6, 12, 4.5, 8, 35, 47, 'DDR5', 'PCIe 4.0', 1, 950.00),
(147, 'AMD', 'Ryzen AI 5 PRO 440G', 'Ryzen AI 400G PRO', 'Zen 5', 'AM5', 6, 12, 4.8, 16, 65, 88, 'DDR5', 'PCIe 4.0', 1, 950.00),
(148, 'AMD', 'Ryzen AI 5 PRO 440GE', 'Ryzen AI 400G PRO', 'Zen 5', 'AM5', 6, 12, 4.8, 16, 35, 47, 'DDR5', 'PCIe 4.0', 1, 950.00),
(149, 'AMD', 'Ryzen AI 7 450G', 'Ryzen AI 400G', 'Zen 5', 'AM5', 8, 16, 5.1, 16, 65, 88, 'DDR5', 'PCIe 4.0', 1, 500.00),
(150, 'AMD', 'Ryzen AI 7 450GE', 'Ryzen AI 400G', 'Zen 5', 'AM5', 8, 16, 5.1, 16, 35, 47, 'DDR5', 'PCIe 4.0', 1, 1450.00);

--
-- 
--

--
--  `dyski`
--
ALTER TABLE `dyski`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_producent` (`producent`),
  ADD KEY `idx_typ` (`typ_dysku`),
  ADD KEY `idx_interfejs` (`interfejs`),
  ADD KEY `idx_format` (`format`);

--
--  `karty_graficzne`
--
ALTER TABLE `karty_graficzne`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_producent` (`producent`),
  ADD KEY `idx_vram` (`pamiec_vram_gb`),
  ADD KEY `idx_tdp` (`tdp_w`);

--
--  `pamiec_ram`
--
ALTER TABLE `pamiec_ram`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_producent` (`producent`),
  ADD KEY `idx_typ` (`typ_pamieci`),
  ADD KEY `idx_taktowanie` (`taktowanie_mhz`);

--
--  `pc_cases`
--
ALTER TABLE `pc_cases`
  ADD PRIMARY KEY (`id`);

--
--  `plyty_glowne`
--
ALTER TABLE `plyty_glowne`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_producent_model` (`producent`,`model`),
  ADD KEY `idx_socket` (`socket`),
  ADD KEY `idx_chipset` (`chipset`),
  ADD KEY `idx_ram` (`typ_pamieci`),
  ADD KEY `idx_format` (`format`),
  ADD KEY `idx_price` (`cena_pln`);

--
--  `power_supplies`
--
ALTER TABLE `power_supplies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_wattage` (`wattage_w`),
  ADD KEY `idx_class` (`wattage_class`),
  ADD KEY `idx_cert` (`efficiency_cert`),
  ADD KEY `idx_price` (`price_pln`);

--
--  `procesory`
--
ALTER TABLE `procesory`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cpu_model` (`producent`,`model`),
  ADD KEY `idx_socket` (`socket`),
  ADD KEY `idx_rdzenie` (`rdzenie`),
  ADD KEY `idx_tdp` (`tdp_w`),
  ADD KEY `idx_producent` (`producent`);

--
-- 
--

--
--  `pc_cases`
--
ALTER TABLE `pc_cases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
--  `power_supplies`
--
ALTER TABLE `power_supplies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
