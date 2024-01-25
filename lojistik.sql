-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Anamakine: localhost:3306
-- Üretim Zamanı: 25 Oca 2024, 12:31:36
-- Sunucu sürümü: 8.0.35-0ubuntu0.22.04.1
-- PHP Sürümü: 8.1.2-1ubuntu2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `lojistik`
--
CREATE DATABASE IF NOT EXISTS `lojistik` DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;
USE `lojistik`;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `Araclar`
--

CREATE TABLE `Araclar` (
  `AracID` int NOT NULL,
  `AracCinsi` varchar(45) DEFAULT NULL,
  `Kapasitesi` varchar(45) DEFAULT NULL,
  `Soforu` varchar(45) DEFAULT NULL,
  `Plakasi` varchar(45) DEFAULT NULL,
  `SoforTelefonu` varchar(45) DEFAULT NULL,
  `FirmaID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `Bos_Araclar`
--

CREATE TABLE `Bos_Araclar` (
  `BosAracID` int NOT NULL,
  `BulunduguYer` varchar(45) DEFAULT NULL,
  `GidecegiYer` varchar(45) DEFAULT NULL,
  `AracCinsi` varchar(45) DEFAULT NULL,
  `KalkışTarihi` varchar(45) DEFAULT NULL,
  `DetayliBilgi` varchar(45) DEFAULT NULL,
  `FirmaID` int DEFAULT NULL,
  `AracID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `Firmalar`
--

CREATE TABLE `Firmalar` (
  `FirmaID` int NOT NULL,
  `İsmi` varchar(45) DEFAULT NULL,
  `Sorumlusu` varchar(45) DEFAULT NULL,
  `Telefonu` varchar(45) DEFAULT NULL,
  `Konumu` varchar(45) DEFAULT NULL,
  `Logosu` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `Musteriler`
--

CREATE TABLE `Musteriler` (
  `MusteriID` int NOT NULL,
  `AdiSoyadi` varchar(45) DEFAULT NULL,
  `Telefonu` varchar(45) DEFAULT NULL,
  `MailAdresi` varchar(45) DEFAULT NULL,
  `Konumu` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `Yapılacak_Nakliyeler`
--

CREATE TABLE `Yapılacak_Nakliyeler` (
  `NakliyeID` int NOT NULL,
  `AracID` int DEFAULT NULL,
  `MusteriID` int DEFAULT NULL,
  `Nakliyeİslemi` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `Yapılmıs_Nakliyeler`
--

CREATE TABLE `Yapılmıs_Nakliyeler` (
  `NakliyeID` int NOT NULL,
  `FirmaID` int DEFAULT NULL,
  `AracID` int DEFAULT NULL,
  `NakliyeKonumu` varchar(45) DEFAULT NULL,
  `NakliyeTarihi` varchar(45) DEFAULT NULL,
  `YukunTuru` varchar(45) DEFAULT NULL,
  `DetayliBilgi` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `İlanlar`
--

CREATE TABLE `İlanlar` (
  `İlanID` int NOT NULL,
  `YayınTarihi` varchar(45) DEFAULT NULL,
  `NakliyeBaslangic` varchar(45) DEFAULT NULL,
  `NakliyeBitis` varchar(45) DEFAULT NULL,
  `YukunTuru` varchar(45) DEFAULT NULL,
  `YuklemeTarihi` varchar(45) DEFAULT NULL,
  `İlanMetni` varchar(45) DEFAULT NULL,
  `MusteriID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `Araclar`
--
ALTER TABLE `Araclar`
  ADD PRIMARY KEY (`AracID`),
  ADD KEY `Araclar_Firmalar_idx` (`FirmaID`);

--
-- Tablo için indeksler `Bos_Araclar`
--
ALTER TABLE `Bos_Araclar`
  ADD PRIMARY KEY (`BosAracID`),
  ADD KEY `BosAraclar_Firmalar_idx` (`FirmaID`),
  ADD KEY `BosAraclar_Araclar_idx` (`AracID`);

--
-- Tablo için indeksler `Firmalar`
--
ALTER TABLE `Firmalar`
  ADD PRIMARY KEY (`FirmaID`);

--
-- Tablo için indeksler `Musteriler`
--
ALTER TABLE `Musteriler`
  ADD PRIMARY KEY (`MusteriID`);

--
-- Tablo için indeksler `Yapılacak_Nakliyeler`
--
ALTER TABLE `Yapılacak_Nakliyeler`
  ADD PRIMARY KEY (`NakliyeID`),
  ADD KEY `Nakliyeler_Araclar_idx` (`AracID`),
  ADD KEY `Nakliyeler_İlanlar_idx` (`MusteriID`);

--
-- Tablo için indeksler `Yapılmıs_Nakliyeler`
--
ALTER TABLE `Yapılmıs_Nakliyeler`
  ADD PRIMARY KEY (`NakliyeID`),
  ADD KEY `YapılanNakliyeler_Araclar_idx` (`AracID`),
  ADD KEY `YapılanNakliyeler_Firmalar_idx` (`FirmaID`);

--
-- Tablo için indeksler `İlanlar`
--
ALTER TABLE `İlanlar`
  ADD PRIMARY KEY (`İlanID`),
  ADD KEY `İlanlar_Musteriler_idx` (`MusteriID`);

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `Araclar`
--
ALTER TABLE `Araclar`
  ADD CONSTRAINT `Araclar_Firmalar` FOREIGN KEY (`FirmaID`) REFERENCES `Firmalar` (`FirmaID`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `Bos_Araclar`
--
ALTER TABLE `Bos_Araclar`
  ADD CONSTRAINT `BosAraclar_Araclar` FOREIGN KEY (`AracID`) REFERENCES `Araclar` (`AracID`) ON DELETE CASCADE,
  ADD CONSTRAINT `BosAraclar_Firmalar` FOREIGN KEY (`FirmaID`) REFERENCES `Firmalar` (`FirmaID`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `Yapılacak_Nakliyeler`
--
ALTER TABLE `Yapılacak_Nakliyeler`
  ADD CONSTRAINT `Nakliyeler_Araclar` FOREIGN KEY (`AracID`) REFERENCES `Araclar` (`AracID`),
  ADD CONSTRAINT `Nakliyeler_Musteriler` FOREIGN KEY (`MusteriID`) REFERENCES `Musteriler` (`MusteriID`);

--
-- Tablo kısıtlamaları `Yapılmıs_Nakliyeler`
--
ALTER TABLE `Yapılmıs_Nakliyeler`
  ADD CONSTRAINT `YapılanNakliyeler_Araclar` FOREIGN KEY (`AracID`) REFERENCES `Araclar` (`AracID`) ON DELETE CASCADE,
  ADD CONSTRAINT `YapılanNakliyeler_Firmalar` FOREIGN KEY (`FirmaID`) REFERENCES `Firmalar` (`FirmaID`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `İlanlar`
--
ALTER TABLE `İlanlar`
  ADD CONSTRAINT `İlanlar_Musteriler` FOREIGN KEY (`MusteriID`) REFERENCES `Musteriler` (`MusteriID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
