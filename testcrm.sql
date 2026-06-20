-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 20, 2026 at 02:38 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `testcrm`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `contactId` int(11) NOT NULL,
  `customerId` int(11) NOT NULL,
  `contactName` varchar(150) NOT NULL,
  `contactDesignation` varchar(100) DEFAULT NULL,
  `contactDepartment` varchar(100) DEFAULT NULL,
  `contactEmail` varchar(150) DEFAULT NULL,
  `phoneOffice` varchar(20) DEFAULT NULL,
  `phoneDirect` varchar(20) DEFAULT NULL,
  `contactMobile` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`contactId`, `customerId`, `contactName`, `contactDesignation`, `contactDepartment`, `contactEmail`, `phoneOffice`, `phoneDirect`, `contactMobile`, `created_at`) VALUES
(1, 1, 'Mr. Anil Verma', 'Purchase Head', 'Department of Defence Production', 'anil.verma@hal.in', '+91-522-2450011', '+91-522-2450021', '+91-9415100001', '2026-06-04 10:35:14'),
(2, 1, 'Ms. Priya Sharma', 'Sr. Purchase Officer', 'Procurement', 'priya.sharma@hal.in', '+91-522-2450012', '+91-522-2450022', '+91-9415100002', '2026-06-04 10:35:14'),
(3, 2, 'Mr. Rajan Nair', 'DGM Purchase', 'Supply Chain', 'rajan.nair@bel-india.in', '+91-80-22195511', '+91-80-22195521', '+91-9480100003', '2026-06-04 10:35:14'),
(4, 2, 'Ms. Deepa Menon', 'Purchase Manager', 'Procurement', 'deepa.menon@bel-india.in', '+91-80-22195512', '+91-80-22195522', '+91-9480100004', '2026-06-04 10:35:14'),
(5, 3, 'Mr. Suresh Pandey', 'Director Stores', 'Stores & Purchase', 'suresh.pandey@drdo.in', '+91-11-23010111', '+91-11-23010121', '+91-9810100005', '2026-06-04 10:35:14'),
(6, 3, 'Ms. Kavita Singh', 'Purchase Officer', 'Procurement', 'kavita.singh@drdo.in', '+91-11-23010112', '+91-11-23010122', '+91-9810100006', '2026-06-04 10:35:14');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customerId` int(11) NOT NULL,
  `companyname` varchar(200) NOT NULL,
  `nickname` varchar(100) DEFAULT NULL,
  `industry` varchar(100) DEFAULT NULL,
  `gstin` varchar(20) DEFAULT NULL,
  `address1` text DEFAULT NULL,
  `address2` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `pincode` varchar(10) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `website` varchar(200) DEFAULT NULL,
  `paymentterms` varchar(100) DEFAULT NULL,
  `creditlimit` decimal(12,2) DEFAULT 0.00,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customerId`, `companyname`, `nickname`, `industry`, `gstin`, `address1`, `address2`, `city`, `pincode`, `state`, `country`, `email`, `phone`, `mobile`, `fax`, `website`, `paymentterms`, `creditlimit`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Hindustan Aeronautics Limited', 'HAL', 'Manufacturing', '29AAACH0997J1ZQ', 'PO Hal Korwa, Amethi', 'Sultanpur', 'Amethi', '227412', 'Uttar Pradesh', 'India', 'procurement@hal.in', '+91-522-2450001', '+91-9415000001', '+91-522-2450002', 'www.hal-india.co.in', 'Net 30', 5000000.00, 'active', '2026-06-04 10:34:38', '2026-06-04 10:34:38'),
(2, 'Bharat Electronics Limited', 'BEL', 'Technology', '29AAACB0589P1ZA', 'Outer Ring Road, Devanahalli', 'Bengaluru North', 'Bengaluru', '562110', 'Karnataka', 'India', 'vendor@bel-india.in', '+91-80-22195500', '+91-9480000002', '+91-80-22195501', 'www.bel-india.in', 'Net 45', 8000000.00, 'active', '2026-06-04 10:34:38', '2026-06-04 10:34:38'),
(3, 'Defence Research & Dev Org', 'DRDO', 'Technology', '07AAACD0517F1ZP', 'DRDO Bhawan, Rajaji Marg', 'New Delhi', 'New Delhi', '110011', 'Delhi', 'India', 'stores@drdo.gov.in', '+91-11-23010101', '+91-9810000003', '+91-11-23010102', 'www.drdo.gov.in', 'Net 60', 10000000.00, 'active', '2026-06-04 10:34:38', '2026-06-04 10:34:38'),
(4, 'test', 'tets', 'Healthcare', 'fadfaf', 'Dharampura, Najafgarh', 'Inida, New Delho - 110043', 'New Delhi', '110043', 'Delhi', 'India', 'admin@themesbrand.com', NULL, '92034568098', '4152635263', 'www.neuvin.com', 'Net 45', 0.01, 'active', '2026-06-05 09:44:47', '2026-06-05 09:44:47');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `productId` int(11) NOT NULL,
  `supplierId` int(11) DEFAULT NULL,
  `partNumber` varchar(255) DEFAULT NULL,
  `itemDescription` text DEFAULT NULL,
  `hsnCode` varchar(255) DEFAULT NULL,
  `articleNumber` varchar(255) DEFAULT NULL,
  `buyingCurrency` varchar(50) DEFAULT NULL,
  `costUnitPrice` decimal(18,2) DEFAULT NULL,
  `quantity` int(11) DEFAULT 1,
  `purchaseTax` varchar(50) DEFAULT NULL,
  `purchaseTaxRate` decimal(5,2) DEFAULT NULL,
  `purchaseTaxValue` decimal(18,2) DEFAULT NULL,
  `saleCurrency` varchar(50) DEFAULT 'INR',
  `unitSalePrice` decimal(18,2) DEFAULT NULL,
  `saleTax` enum('IGST','GST','SaleTax') DEFAULT 'IGST',
  `saleTaxRate` decimal(5,2) DEFAULT 18.00,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`productId`, `supplierId`, `partNumber`, `itemDescription`, `hsnCode`, `articleNumber`, `buyingCurrency`, `costUnitPrice`, `quantity`, `purchaseTax`, `purchaseTaxRate`, `purchaseTaxValue`, `saleCurrency`, `unitSalePrice`, `saleTax`, `saleTaxRate`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'M206A', 'Digital Multimeter - DC/AC Voltage: 1000V, Current: 10A, Frequency: 0.0001kHz-1000kHz, Display: 3 6/7, True RMS', '90303300', 'GSM-M206A', 'US$', 4500.00, 1, 'IGST', 18.00, 810.00, 'INR', 8500.00, 'IGST', 18.00, 'active', '2026-06-04 10:36:35', '2026-06-04 10:36:35'),
(2, 2, 'FLUKE-87V', 'Fluke 87V Industrial Multimeter - True RMS, 1000V CAT III, Frequency, Temperature', '90303300', 'FLK-87V', 'US$', 6200.00, 1, 'IGST', 18.00, 1116.00, 'INR', 12000.00, 'IGST', 18.00, 'active', '2026-06-04 10:36:35', '2026-06-04 10:36:35'),
(3, 3, 'DSO-X3024T', 'Keysight 200MHz 4-Channel Oscilloscope, 5GSa/s, 2Mpts Memory, Touch Screen', '90308900', 'KST-3024T', 'US$', 28000.00, 1, 'IGST', 18.00, 5040.00, 'INR', 55000.00, 'IGST', 18.00, 'active', '2026-06-04 10:36:35', '2026-06-04 10:36:35'),
(4, 1, 'HM8150', 'Power Supply Unit 30V/5A, Triple Output, Digital Display', '85044090', 'GSM-HM8150', 'US$', 8500.00, 1, 'IGST', 18.00, 1530.00, 'INR', 16500.00, 'IGST', 18.00, 'active', '2026-06-04 10:36:35', '2026-06-04 10:36:35'),
(5, 3, 'E4433B', 'Signal Generator 1GHz, ESG-D Series, Digital Modulation, AM/FM/Phase', '85437090', 'KST-E4433B', 'US$', 45000.00, 1, 'IGST', 18.00, 8100.00, 'INR', 88000.00, 'IGST', 18.00, 'active', '2026-06-04 10:36:35', '2026-06-04 10:36:35'),
(6, 2, 'FLUKE-380', 'Fluke 380 Clamp Meter 1000A AC/DC, True RMS, iFlex, Frequency, Capacitance', '90303300', 'FLK-380', 'US$', 7800.00, 1, 'IGST', 18.00, 1404.00, 'INR', 15000.00, 'IGST', 18.00, 'active', '2026-06-04 10:36:35', '2026-06-04 10:36:35'),
(7, 1, 'HM8118', 'LCR Meter 20Hz-200kHz, 0.05% Accuracy, USB Interface', '90308900', 'GSM-HM8118', 'US$', 12000.00, 1, 'IGST', 18.00, 2160.00, 'INR', 23500.00, 'IGST', 18.00, 'active', '2026-06-04 10:36:35', '2026-06-04 10:36:35'),
(8, 3, 'N9010B', 'Spectrum Analyzer 3GHz, EXA Signal Analyzer, Phase Noise -98dBc/Hz', '90303390', 'KST-N9010B', 'US$', 95000.00, 1, 'IGST', 18.00, 17100.00, 'INR', 185000.00, 'IGST', 18.00, 'active', '2026-06-04 10:36:35', '2026-06-04 10:36:35'),
(9, 2, 'FLUKE-435', 'Power Quality & Energy Analyzer, 3-Phase, 400Hz, Flicker, Harmonics to 50th', '90303390', 'FLK-435', 'US$', 32000.00, 1, 'IGST', 18.00, 5760.00, 'INR', 62000.00, 'IGST', 18.00, 'active', '2026-06-04 10:36:35', '2026-06-04 10:36:35'),
(10, 1, 'TIC-320', 'Thermal Imaging Camera 320x240, -20 to 1200°C, Wi-Fi, IP54, 3.5\" LCD', '90251900', 'GSM-TIC320', 'US$', 55000.00, 1, 'IGST', 18.00, 9900.00, 'INR', 107000.00, 'IGST', 18.00, 'active', '2026-06-04 10:36:35', '2026-06-04 10:36:35');

-- --------------------------------------------------------

--
-- Table structure for table `quotationitems`
--

CREATE TABLE `quotationitems` (
  `itemId` int(11) NOT NULL,
  `quoteId` int(11) NOT NULL,
  `productId` int(11) DEFAULT NULL,
  `partNumber` varchar(255) DEFAULT NULL,
  `itemDescription` text DEFAULT NULL,
  `hsnCode` varchar(255) DEFAULT NULL,
  `quantity` int(11) DEFAULT 1,
  `unitPrice` decimal(18,2) DEFAULT 0.00,
  `taxRate` decimal(5,2) DEFAULT 18.00,
  `taxAmount` decimal(18,2) DEFAULT 0.00,
  `totalPrice` decimal(18,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quotationitems`
--

INSERT INTO `quotationitems` (`itemId`, `quoteId`, `productId`, `partNumber`, `itemDescription`, `hsnCode`, `quantity`, `unitPrice`, `taxRate`, `taxAmount`, `totalPrice`, `created_at`) VALUES
(67, 39, NULL, 'M206A', 'Digital Multimeter - DC/AC Voltage: 1000V, Current: 10A, Frequency: 0.0001kHz-1000kHz, Display: 3 6/7, True RMS', '90303300', 1, 8500.00, 18.00, 1530.00, 10030.00, '2026-06-13 11:16:30'),
(68, 39, NULL, 'FLUKE-380', 'Fluke 380 Clamp Meter 1000A AC/DC, True RMS, iFlex, Frequency, Capacitance', '90303300', 1, 15000.00, 18.00, 2700.00, 17700.00, '2026-06-13 11:16:30'),
(69, 39, NULL, 'N9010B', 'Spectrum Analyzer 3GHz, EXA Signal Analyzer, Phase Noise -98dBc/Hz', '90303390', 1, 185000.00, 18.00, 33300.00, 218300.00, '2026-06-13 11:16:30'),
(92, 40, NULL, 'M206A', 'Digital Multimeter - DC/AC Voltage: 1000V, Current: 10A, Frequency: 0.0001kHz-1000kHz, Display: 3 6/7, True RMS', '90303300', 1, 8500.00, 18.00, 1530.00, 10030.00, '2026-06-19 05:56:23'),
(93, 40, NULL, 'HM8118', 'LCR Meter 20Hz-200kHz, 0.05% Accuracy, USB Interface', '90308900', 1, 23500.00, 18.00, 4230.00, 27730.00, '2026-06-19 05:56:23'),
(125, 41, NULL, 'M206A', 'Digital Multimeter - DC/AC Voltage: 1000V, Current: 10A, Frequency: 0.0001kHz-1000kHz, Display: 3 6/7, True RMS', '90303300', 1, 8500.00, 18.00, 1530.00, 10030.00, '2026-06-20 05:42:21'),
(126, 41, NULL, 'HM8150', 'Power Supply Unit 30V/5A, Triple Output, Digital Display', '85044090', 1, 16500.00, 18.00, 2970.00, 19470.00, '2026-06-20 05:42:21'),
(127, 43, NULL, 'FLUKE-87V', 'Fluke 87V Industrial Multimeter - True RMS, 1000V CAT III, Frequency, Temperature', '90303300', 1, 12000.00, 18.00, 2160.00, 14160.00, '2026-06-20 05:42:34'),
(128, 43, NULL, 'M206A', 'Digital Multimeter - DC/AC Voltage: 1000V, Current: 10A, Frequency: 0.0001kHz-1000kHz, Display: 3 6/7, True RMS', '90303300', 1, 8500.00, 18.00, 1530.00, 10030.00, '2026-06-20 05:42:34'),
(133, 47, NULL, 'M206A', 'Digital Multimeter - DC/AC Voltage: 1000V, Current: 10A, Frequency: 0.0001kHz-1000kHz, Display: 3 6/7, True RMS', '90303300', 1, 8500.00, 18.00, 1530.00, 10030.00, '2026-06-20 09:23:38'),
(134, 47, NULL, 'FLUKE-87V', 'Fluke 87V Industrial Multimeter - True RMS, 1000V CAT III, Frequency, Temperature', '90303300', 1, 12000.00, 18.00, 2160.00, 14160.00, '2026-06-20 09:23:38'),
(135, 47, NULL, 'DSO-X3024T', 'Keysight 200MHz 4-Channel Oscilloscope, 5GSa/s, 2Mpts Memory, Touch Screen', '90308900', 1, 55000.00, 18.00, 9900.00, 64900.00, '2026-06-20 09:23:38'),
(136, 47, NULL, 'HM8150', 'Power Supply Unit 30V/5A, Triple Output, Digital Display', '85044090', 1, 16500.00, 18.00, 2970.00, 19470.00, '2026-06-20 09:23:38');

-- --------------------------------------------------------

--
-- Table structure for table `quotations`
--

CREATE TABLE `quotations` (
  `quoteId` int(11) NOT NULL,
  `quoteNo` varchar(255) DEFAULT NULL,
  `quoteFor` varchar(255) DEFAULT NULL,
  `tenderNo` varchar(255) DEFAULT NULL,
  `quoteDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `quoteDueDate` timestamp NULL DEFAULT NULL,
  `customerId` int(11) NOT NULL,
  `contactId` int(11) DEFAULT NULL,
  `supplierId` int(11) DEFAULT NULL,
  `tncId` int(11) DEFAULT NULL,
  `currency` varchar(50) DEFAULT 'INR',
  `exchangeRate` decimal(18,4) DEFAULT 1.0000,
  `quoteStatus` enum('Draft','Submitted','Approved','Rejected','Expired','ConvertedToSO','Cancelled') DEFAULT 'Draft',
  `subTotal` decimal(18,2) DEFAULT 0.00,
  `totalTax` decimal(18,2) DEFAULT 0.00,
  `freightAmount` decimal(18,2) DEFAULT 0.00,
  `packingAmount` decimal(18,2) DEFAULT 0.00,
  `grandTotal` decimal(18,2) DEFAULT 0.00,
  `remarks` text DEFAULT NULL,
  `internalNotes` text DEFAULT NULL,
  `preparedBy` varchar(255) DEFAULT NULL,
  `approvedBy` varchar(255) DEFAULT NULL,
  `revisionNo` int(11) DEFAULT 0,
  `isPOReceived` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quotations`
--

INSERT INTO `quotations` (`quoteId`, `quoteNo`, `quoteFor`, `tenderNo`, `quoteDate`, `quoteDueDate`, `customerId`, `contactId`, `supplierId`, `tncId`, `currency`, `exchangeRate`, `quoteStatus`, `subTotal`, `totalTax`, `freightAmount`, `packingAmount`, `grandTotal`, `remarks`, `internalNotes`, `preparedBy`, `approvedBy`, `revisionNo`, `isPOReceived`, `created_at`, `updated_at`) VALUES
(39, 'QT-2026-0027', NULL, 'GEM/2026/B/64524785', '2026-06-12 18:30:00', '2026-07-13 18:30:00', 3, 4, 2, 32, 'INR', 1.0000, 'Approved', 208500.00, 37530.00, 0.00, 0.00, 246030.00, NULL, NULL, 'Vinod Sharma', 'Vinod Sharma', 0, 0, '2026-06-13 11:16:30', '2026-06-13 11:16:30'),
(40, 'QT-2026-0028', '', 'GEM/2027/M/645879080', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 2, 2, 1, 33, 'INR', 1.0000, 'Submitted', 32000.00, 5760.00, 0.00, 0.00, 37760.00, '', '', 'Vinod Sharma', 'Vinod Sharma', 0, 0, '2026-06-13 12:59:40', '2026-06-19 05:56:23'),
(41, 'QT-2026-0029', '', 'GEM/2030/JTK/64580989', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 5, 1, 34, 'INR', 1.0000, 'Draft', 25000.00, 4500.00, 0.00, 0.00, 29500.00, '', '', 'Vinod Sharma', 'Vinod Sharma', 0, 0, '2026-06-15 04:44:43', '2026-06-20 05:42:21'),
(43, 'QT-2026-0006', 'Fluke 87V Industrial Multimeter and Digital Multimeter', 'GEM/2024/XYZ/0987', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 3, 5, 3, 36, 'INR', 1.0000, 'Approved', 20500.00, 3690.00, 0.00, 0.00, 24190.00, '', '', 'Vinod Sharma', 'Vinod Sharma', 0, 0, '2026-06-15 05:55:49', '2026-06-20 05:42:34'),
(47, 'QT-2026-0005', 'Keysight 200MHz 4-Channel Oscilloscope', 'GEM/2026/BKM/6452480', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 2, 5, 3, 40, 'INR', 1.0000, 'Submitted', 92000.00, 16560.00, 0.00, 0.00, 108560.00, '', '', 'Vinod Sharma', 'Vinod Sharma', 0, 0, '2026-06-18 07:27:40', '2026-06-20 05:42:42');

-- --------------------------------------------------------

--
-- Table structure for table `quotationtnc`
--

CREATE TABLE `quotationtnc` (
  `tncId` int(11) NOT NULL,
  `incoTerms` varchar(255) DEFAULT 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI – 110045.',
  `paymentTerms` varchar(255) DEFAULT '100% Payment in Advance against Proforma Invoice.',
  `handlingCharges` varchar(255) DEFAULT 'INR 1500/- Per Shipment.',
  `potoPlace` text DEFAULT NULL,
  `bankersDetails` text DEFAULT NULL,
  `bankAddress` text DEFAULT NULL,
  `gstin_pan_tin` varchar(255) DEFAULT '07AADCN9370Q1ZO / AADCN9370Q / 7070443384',
  `msmeId` varchar(255) DEFAULT 'DL10D0008905',
  `gst_igst` varchar(255) DEFAULT 'Extra 18% on Electrical/Electronics/Quoted Products.',
  `delivery` varchar(255) DEFAULT '4 - 6 weeks will be effective from date of receipt of confirmed PO/Payment/LC.',
  `pnfCharges` varchar(255) DEFAULT 'Applicable @2.00% of the Order Value.',
  `freightCharges` varchar(255) DEFAULT 'To be collected by the buyer / @2.00% of the order value.',
  `warranty` varchar(255) DEFAULT 'As per OEM policy, 12 months warranty against any manufacturing defect.',
  `validityOfQuote` varchar(255) DEFAULT 'Prices are valid for 30 days from the date of quote submission.',
  `poConditions` varchar(255) DEFAULT 'NC/NR (Non-Cancellable / Non-Returnable)',
  `specialConditions` varchar(255) DEFAULT 'End Use Statement Required with Purchase Order.',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quotationtnc`
--

INSERT INTO `quotationtnc` (`tncId`, `incoTerms`, `paymentTerms`, `handlingCharges`, `potoPlace`, `bankersDetails`, `bankAddress`, `gstin_pan_tin`, `msmeId`, `gst_igst`, `delivery`, `pnfCharges`, `freightCharges`, `warranty`, `validityOfQuote`, `poConditions`, `specialConditions`, `created_at`, `updated_at`) VALUES
(1, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI – 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', 'NEUVIN ELECTRONICS PRIVATE LIMITED\nWZ-1258, Third Floor, Nand Gyan Bhawan\nAshram Lane, Palam Village\nNew Delhi – 110045\nPhone/Fax: +91 11-25081947\nMobile: +91 9910 584 666\nE-mail: info@neuvin.com\nURL: www.neuvin.com', 'BANK OF MAHARASHTRA\nAccount No: 60098352768\nIFS Code: MAHB0001308\nMICR Code: 110014034', 'SCO 11, Sector-23 A,\nPalam Vihar,\nGurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-04 10:37:25', '2026-06-04 10:37:25'),
(2, 'FOR DESTINATION', '100% Payment within NET30 days from the date of delivery.', 'INR 1500/- Per Shipment.', 'NEUVIN ELECTRONICS PRIVATE LIMITED\nWZ-1258, Third Floor, Nand Gyan Bhawan\nAshram Lane, Palam Village\nNew Delhi – 110045\nPhone/Fax: +91 11-25081947\nMobile: +91 9910 584 666\nE-mail: info@neuvin.com\nURL: www.neuvin.com', 'BANK OF MAHARASHTRA\nAccount No: 60098352768\nIFS Code: MAHB0001308\nMICR Code: 110014034', 'SCO 11, Sector-23 A,\nPalam Vihar,\nGurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '6 - 8 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 24 months warranty against any manufacturing defect.', 'Prices are valid for 60 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-04 10:37:25', '2026-06-04 10:37:25'),
(3, 'FOR STORES', '100% Payment in Advance against Proforma Invoice.', 'NA', 'NEUVIN ELECTRONICS PRIVATE LIMITED\nWZ-1258, Third Floor, Nand Gyan Bhawan\nAshram Lane, Palam Village\nNew Delhi – 110045\nPhone/Fax: +91 11-25081947\nMobile: +91 9910 584 666\nE-mail: info@neuvin.com\nURL: www.neuvin.com', 'BANK OF MAHARASHTRA\nAccount No: 60098352768\nIFS Code: MAHB0001308\nMICR Code: 110014034', 'SCO 11, Sector-23 A,\nPalam Vihar,\nGurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '8 - 10 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'NA', 'NA', 'As per OEM policy, 36 months warranty against any manufacturing defect.', 'Prices are valid for 90 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'NA', '2026-06-04 10:37:25', '2026-06-04 10:37:25'),
(4, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI – 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', NULL, NULL, NULL, '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '14 - 18 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 24 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-05 06:23:37', '2026-06-05 06:23:37'),
(5, 'FOR DESTINATION', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', NULL, NULL, NULL, '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-06 08:41:08', '2026-06-06 08:41:08'),
(6, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI – 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', NULL, NULL, NULL, '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-06 08:53:49', '2026-06-06 08:53:49'),
(7, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI – 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', NULL, NULL, NULL, '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-06 09:03:47', '2026-06-06 09:03:47'),
(8, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI – 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', NULL, NULL, NULL, '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-06 09:04:13', '2026-06-06 09:04:13'),
(9, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI – 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', NULL, NULL, NULL, '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-10 13:04:17', '2026-06-10 13:04:17'),
(10, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI – 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', NULL, NULL, NULL, '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-10 13:05:04', '2026-06-10 13:05:04'),
(11, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI – 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', NULL, NULL, NULL, '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '14 - 18 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-11 08:58:00', '2026-06-11 08:58:00'),
(12, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI – 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', NULL, NULL, NULL, '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-12 05:33:47', '2026-06-12 05:33:47'),
(13, 'FOR DESTINATION', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', NULL, NULL, NULL, '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-12 05:35:36', '2026-06-12 05:35:36'),
(14, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI – 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', NULL, NULL, NULL, '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-12 05:38:54', '2026-06-12 05:38:54'),
(15, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI – 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', NULL, NULL, NULL, '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-12 05:41:32', '2026-06-12 05:41:32'),
(16, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI – 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', NULL, NULL, NULL, '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-12 05:46:50', '2026-06-12 05:46:50'),
(17, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI – 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', NULL, NULL, NULL, '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-12 06:09:58', '2026-06-12 06:09:58'),
(18, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI – 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', NULL, NULL, NULL, '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-12 06:57:20', '2026-06-12 06:57:20'),
(19, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI – 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', NULL, NULL, NULL, '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-12 06:59:29', '2026-06-12 06:59:29'),
(20, 'FOR DESTINATION', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', NULL, NULL, NULL, '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-12 07:06:45', '2026-06-12 07:06:45'),
(21, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI – 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', NULL, NULL, NULL, '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks will be effective from date of receipt of confirmed PO/Payment/LC.', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-12 07:47:29', '2026-06-12 07:47:29'),
(22, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI - 110045.', '100% Payment within NET30 days from the date of delivery.', 'INR 1500/- Per Shipment.', NULL, NULL, NULL, '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 36 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-12 09:42:16', '2026-06-12 09:42:16'),
(23, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI - 110045.', '100% Payment within NET30 days from the date of delivery.', 'INR 1500/- Per Shipment.', 'NEUVIN ADVANCED TECHNOLOGIES\r\nWZ-1258, Third Floor, Nand Gyan Bhawan\r\nAshram Lane, Palam Village\r\nNew Delhi - 110045\r\nPhone/Fax: +91 11-25081947\r\nMobile: +91 9910 584 666\r\nE-mail: info@neuvin.com\r\nURL: www.neuvin.com', 'BANK OF MAHARASHTRA\r\nAccount No: 60098352768\r\nIFS Code: MAHB0001308\r\nMICR Code: 110014034', 'SCO 11, Sector-23 A,\r\nPalam Vihar,\r\nGurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '6 - 8 weeks', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-12 09:50:01', '2026-06-12 09:50:01'),
(24, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI - 110045.', '100% Payment within NET30 days from the date of delivery.', 'INR 1500/- Per Shipment.', 'NEUVIN ADVANCED TECHNOLOGIES\r\nWZ-1258, Third Floor, Nand Gyan Bhawan\r\nAshram Lane, Palam Village\r\nNew Delhi - 110045\r\nPhone/Fax: +91 11-25081947\r\nMobile: +91 9910584666\r\nE-mail: info@neuvin.com\r\nURL: www.neuvin.com', 'BANK OF MAHARASHTRA\r\nAccount No: 60098352768\r\nIFS Code: MAHB0001308\r\nMICR Code: 110014034', 'SCO 11, Sector-23 A,\r\nPalam Vihar,\r\nGurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '8 - 10 weeks', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-12 10:39:00', '2026-06-12 10:39:00'),
(25, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI - 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', 'NEUVIN ADVANCED TECHNOLOGIES\r\nWZ-1258, Third Floor, Nand Gyan Bhawan\r\nAshram Lane, Palam Village\r\nNew Delhi - 110045\r\nPhone/Fax: +91 11-25081947\r\nMobile: +91 9910584666\r\nE-mail: info@neuvin.com\r\nURL: www.neuvin.com', 'BANK OF MAHARASHTRA\r\nAccount No: 60098352768\r\nIFS Code: MAHB0001308\r\nMICR Code: 110014034', 'SCO 11, Sector-23 A,\r\nPalam Vihar,\r\nGurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-13 04:55:18', '2026-06-13 04:55:18'),
(26, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI - 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', 'NEUVIN ADVANCED TECHNOLOGIES\r\nWZ-1258, Third Floor, Nand Gyan Bhawan\r\nAshram Lane, Palam Village\r\nNew Delhi - 110045\r\nPhone/Fax: +91 11-25081947\r\nMobile: +91 9910584666\r\nE-mail: info@neuvin.com\r\nURL: www.neuvin.com', 'BANK OF MAHARASHTRA\r\nAccount No: 60098352768\r\nIFS Code: MAHB0001308\r\nMICR Code: 110014034', 'SCO 11, Sector-23 A,\r\nPalam Vihar,\r\nGurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-13 05:50:57', '2026-06-13 05:50:57'),
(27, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI - 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', 'NEUVIN ADVANCED TECHNOLOGIES\r\nWZ-1258, Third Floor, Nand Gyan Bhawan\r\nAshram Lane, Palam Village\r\nNew Delhi - 110045\r\nPhone/Fax: +91 11-25081947\r\nMobile: +91 9910584666\r\nE-mail: info@neuvin.com\r\nURL: www.neuvin.com', 'BANK OF MAHARASHTRA\r\nAccount No: 60098352768\r\nIFS Code: MAHB0001308\r\nMICR Code: 110014034', 'SCO 11, Sector-23 A,\r\nPalam Vihar,\r\nGurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-13 06:39:33', '2026-06-13 06:39:33'),
(28, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI - 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', 'NEUVIN ADVANCED TECHNOLOGIES\r\nWZ-1258, Third Floor, Nand Gyan Bhawan\r\nAshram Lane, Palam Village\r\nNew Delhi - 110045\r\nPhone/Fax: +91 11-25081947\r\nMobile: +91 9910584666\r\nE-mail: info@neuvin.com\r\nURL: www.neuvin.com', 'BANK OF MAHARASHTRA\r\nAccount No: 60098352768\r\nIFS Code: MAHB0001308\r\nMICR Code: 110014034', 'SCO 11, Sector-23 A,\r\nPalam Vihar,\r\nGurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-13 07:00:39', '2026-06-13 07:00:39'),
(29, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI - 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', 'NEUVIN ADVANCED TECHNOLOGIES\r\nWZ-1258, Third Floor, Nand Gyan Bhawan\r\nAshram Lane, Palam Village\r\nNew Delhi - 110045\r\nPhone/Fax: +91 11-25081947\r\nMobile: +91 9910584666\r\nE-mail: info@neuvin.com\r\nURL: www.neuvin.com', 'BANK OF MAHARASHTRA\r\nAccount No: 60098352768\r\nIFS Code: MAHB0001308\r\nMICR Code: 110014034', 'SCO 11, Sector-23 A,\r\nPalam Vihar,\r\nGurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-13 07:19:33', '2026-06-13 07:19:33'),
(30, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI - 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', 'NEUVIN ADVANCED TECHNOLOGIES\r\nWZ-1258, Third Floor, Nand Gyan Bhawan\r\nAshram Lane, Palam Village\r\nNew Delhi - 110045\r\nPhone/Fax: +91 11-25081947\r\nMobile: +91 9910584666\r\nE-mail: info@neuvin.com\r\nURL: www.neuvin.com', 'BANK OF MAHARASHTRA\r\nAccount No: 60098352768\r\nIFS Code: MAHB0001308\r\nMICR Code: 110014034', 'SCO 11, Sector-23 A,\r\nPalam Vihar,\r\nGurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-13 09:32:46', '2026-06-13 09:32:46'),
(31, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI - 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', 'NEUVIN ADVANCED TECHNOLOGIES\r\nWZ-1258, Third Floor, Nand Gyan Bhawan\r\nAshram Lane, Palam Village\r\nNew Delhi - 110045\r\nPhone/Fax: +91 11-25081947\r\nMobile: +91 9910584666\r\nE-mail: info@neuvin.com\r\nURL: www.neuvin.com', 'BANK OF MAHARASHTRA\r\nAccount No: 60098352768\r\nIFS Code: MAHB0001308\r\nMICR Code: 110014034', 'SCO 11, Sector-23 A,\r\nPalam Vihar,\r\nGurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-13 09:56:43', '2026-06-13 09:56:43'),
(32, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI - 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', 'NEUVIN ADVANCED TECHNOLOGIES\r\nWZ-1258, Third Floor, Nand Gyan Bhawan\r\nAshram Lane, Palam Village\r\nNew Delhi - 110045\r\nPhone/Fax: +91 11-25081947\r\nMobile: +91 9910584666\r\nE-mail: info@neuvin.com\r\nURL: www.neuvin.com', 'BANK OF MAHARASHTRA\r\nAccount No: 60098352768\r\nIFS Code: MAHB0001308\r\nMICR Code: 110014034', 'SCO 11, Sector-23 A,\r\nPalam Vihar,\r\nGurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-13 11:16:30', '2026-06-13 11:16:30'),
(33, 'FOR DESTINATION', '100% Payment within NET30 days from the date of delivery.', 'INR 1500/- Per Shipment.', 'NEUVIN ADVANCED TECHNOLOGIES\r\n        WZ-1258, Third Floor, Nand Gyan Bhawan\r\n        Ashram Lane, Palam Village\r\n        New Delhi - 110045\r\n        Phone/Fax: +91 11-25081947\r\n        Mobile: +91 9910584666\r\n        E-mail: info@neuvin.com\r\n        URL: www.neuvin.com', 'BANK OF MAHARASHTRA\r\n        Account No: 60098352768\r\n        IFS Code: MAHB0001308\r\n        MICR Code: 110014034', 'SCO 11, Sector-23 A,\r\n        Palam Vihar,\r\n        Gurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '8 - 10 weeks', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-13 12:59:40', '2026-06-19 05:56:23'),
(34, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI - 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', 'NEUVIN ADVANCED TECHNOLOGIES\r\n        WZ-1258, Third Floor, Nand Gyan Bhawan\r\n        Ashram Lane, Palam Village\r\n        New Delhi - 110045\r\n        Phone/Fax: +91 11-25081947\r\n        Mobile: +91 9910584666\r\n        E-mail: info@neuvin.com\r\n        URL: www.neuvin.com', 'BANK OF MAHARASHTRA\r\n        Account No: 60098352768\r\n        IFS Code: MAHB0001308\r\n        MICR Code: 110014034', 'SCO 11, Sector-23 A,\r\n        Palam Vihar,\r\n        Gurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-15 04:44:43', '2026-06-20 05:42:21'),
(35, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI - 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', 'NEUVIN ADVANCED TECHNOLOGIES\r\nWZ-1258, Third Floor, Nand Gyan Bhawan\r\nAshram Lane, Palam Village\r\nNew Delhi - 110045\r\nPhone/Fax: +91 11-25081947\r\nMobile: +91 9910584666\r\nE-mail: info@neuvin.com\r\nURL: www.neuvin.com', 'BANK OF MAHARASHTRA\r\nAccount No: 60098352768\r\nIFS Code: MAHB0001308\r\nMICR Code: 110014034', 'SCO 11, Sector-23 A,\r\nPalam Vihar,\r\nGurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-15 05:23:26', '2026-06-15 05:23:26'),
(36, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI - 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', 'NEUVIN ADVANCED TECHNOLOGIES\r\n        WZ-1258, Third Floor, Nand Gyan Bhawan\r\n        Ashram Lane, Palam Village\r\n        New Delhi - 110045\r\n        Phone/Fax: +91 11-25081947\r\n        Mobile: +91 9910584666\r\n        E-mail: info@neuvin.com\r\n        URL: www.neuvin.com', 'BANK OF MAHARASHTRA\r\n        Account No: 60098352768\r\n        IFS Code: MAHB0001308\r\n        MICR Code: 110014034', 'SCO 11, Sector-23 A,\r\n        Palam Vihar,\r\n        Gurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-15 05:55:49', '2026-06-18 06:32:09'),
(37, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI - 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', 'NEUVIN ADVANCED TECHNOLOGIES\r\nWZ-1258, Third Floor, Nand Gyan Bhawan\r\nAshram Lane, Palam Village\r\nNew Delhi - 110045\r\nPhone/Fax: +91 11-25081947\r\nMobile: +91 9910584666\r\nE-mail: info@neuvin.com\r\nURL: www.neuvin.com', 'BANK OF MAHARASHTRA\r\nAccount No: 60098352768\r\nIFS Code: MAHB0001308\r\nMICR Code: 110014034', 'SCO 11, Sector-23 A,\r\nPalam Vihar,\r\nGurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-16 09:37:44', '2026-06-16 09:37:44'),
(38, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI - 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', 'NEUVIN ADVANCED TECHNOLOGIES\r\nWZ-1258, Third Floor, Nand Gyan Bhawan\r\nAshram Lane, Palam Village\r\nNew Delhi - 110045\r\nPhone/Fax: +91 11-25081947\r\nMobile: +91 9910584666\r\nE-mail: info@neuvin.com\r\nURL: www.neuvin.com', 'BANK OF MAHARASHTRA\r\nAccount No: 60098352768\r\nIFS Code: MAHB0001308\r\nMICR Code: 110014034', 'SCO 11, Sector-23 A,\r\nPalam Vihar,\r\nGurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-17 12:32:36', '2026-06-17 12:32:36'),
(39, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI - 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', 'NEUVIN ADVANCED TECHNOLOGIES\r\nWZ-1258, Third Floor, Nand Gyan Bhawan\r\nAshram Lane, Palam Village\r\nNew Delhi - 110045\r\nPhone/Fax: +91 11-25081947\r\nMobile: +91 9910584666\r\nE-mail: info@neuvin.com\r\nURL: www.neuvin.com', 'BANK OF MAHARASHTRA\r\nAccount No: 60098352768\r\nIFS Code: MAHB0001308\r\nMICR Code: 110014034', 'SCO 11, Sector-23 A,\r\nPalam Vihar,\r\nGurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-18 07:18:33', '2026-06-18 07:18:33'),
(40, 'EX-WORKS NEUVIN ELECTRONICS PVT. LTD. NEW DELHI - 110045.', '100% Payment in Advance against Proforma Invoice.', 'INR 1500/- Per Shipment.', 'NEUVIN ADVANCED TECHNOLOGIES\r\n        WZ-1258, Third Floor, Nand Gyan Bhawan\r\n        Ashram Lane, Palam Village\r\n        New Delhi - 110045\r\n        Phone/Fax: +91 11-25081947\r\n        Mobile: +91 9910584666\r\n        E-mail: info@neuvin.com\r\n        URL: www.neuvin.com', 'BANK OF MAHARASHTRA\r\n        Account No: 60098352768\r\n        IFS Code: MAHB0001308\r\n        MICR Code: 110014034', 'SCO 11, Sector-23 A,\r\n        Palam Vihar,\r\n        Gurgaon - 122017.', '07AADCN9370Q1ZO / AADCN9370Q / 7070443384', 'DL10D0008905', 'Extra 18% on Electrical/Electronics/Quoted Products.', '4 - 6 weeks', 'Applicable @2.00% of the Order Value.', 'To be collected by the buyer / @2.00% of the order value.', 'As per OEM policy, 12 months warranty against any manufacturing defect.', 'Prices are valid for 30 days from the date of quote submission.', 'NC/NR (Non-Cancellable / Non-Returnable)', 'End Use Statement Required with Purchase Order.', '2026-06-18 07:27:40', '2026-06-18 07:29:38');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplierId` int(11) NOT NULL,
  `supplierName` varchar(255) NOT NULL,
  `nickname` varchar(50) DEFAULT NULL,
  `industry` varchar(100) DEFAULT NULL,
  `gstin` varchar(20) DEFAULT NULL,
  `pan` varchar(50) DEFAULT NULL,
  `address1` text DEFAULT NULL,
  `address2` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `pincode` varchar(10) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `fax` varchar(50) DEFAULT NULL,
  `website` text DEFAULT NULL,
  `paymentterms` varchar(100) DEFAULT NULL,
  `creditlimit` decimal(12,2) DEFAULT 0.00,
  `currency` varchar(50) DEFAULT 'INR',
  `status` enum('active','inactive','hold','banned') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplierId`, `supplierName`, `nickname`, `industry`, `gstin`, `pan`, `address1`, `address2`, `city`, `pincode`, `state`, `country`, `email`, `phone`, `mobile`, `fax`, `website`, `paymentterms`, `creditlimit`, `currency`, `status`, `created_at`, `updated_at`) VALUES
(1, 'GSM Germany GmbH', 'GSM', 'Technology', '07AABCG1234A1Z5', 'AABCG1234A', 'Industriestrasse 45', 'Munich', 'Munich', '80331', 'Bavaria', 'Germany', 'sales@gsm-germany.com', '+49-89-12345678', '+49-172-1234567', '+49-89-12345679', 'www.gsm-germany.com', 'Net 30', 2000000.00, 'US$', 'active', '2026-06-04 10:35:47', '2026-06-04 10:35:47'),
(2, 'Fluke Corporation', 'Fluke', 'Technology', '07AABCF5678B1Z3', 'AABCF5678B', '6920 Seaway Blvd', 'Everett WA', 'Everett', '98203', 'Washington', 'USA', 'india@fluke.com', '+1-425-446-5500', '+1-425-446-5501', '+1-425-446-5502', 'www.fluke.com', 'Net 45', 3000000.00, 'US$', 'active', '2026-06-04 10:35:47', '2026-06-04 10:35:47'),
(3, 'Keysight Technologies', 'KST', 'Technology', '07AABCK9012C1Z1', 'AABCK9012C', '1400 Fountaingrove Pkwy', 'Santa Rosa CA', 'Santa Rosa', '95403', 'California', 'USA', 'india.sales@keysight.com', '+1-800-829-4444', '+1-707-577-2663', '+1-707-577-2664', 'www.keysight.com', 'Net 60', 5000000.00, 'US$', 'active', '2026-06-04 10:35:47', '2026-06-04 10:35:47');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`contactId`),
  ADD KEY `customerId` (`customerId`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customerId`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`productId`),
  ADD KEY `supplierId` (`supplierId`);

--
-- Indexes for table `quotationitems`
--
ALTER TABLE `quotationitems`
  ADD PRIMARY KEY (`itemId`),
  ADD KEY `quoteId` (`quoteId`),
  ADD KEY `productId` (`productId`);

--
-- Indexes for table `quotations`
--
ALTER TABLE `quotations`
  ADD PRIMARY KEY (`quoteId`),
  ADD UNIQUE KEY `quoteNo` (`quoteNo`),
  ADD KEY `customerId` (`customerId`),
  ADD KEY `contactId` (`contactId`),
  ADD KEY `supplierId` (`supplierId`),
  ADD KEY `tncId` (`tncId`);

--
-- Indexes for table `quotationtnc`
--
ALTER TABLE `quotationtnc`
  ADD PRIMARY KEY (`tncId`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplierId`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `contactId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customerId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `productId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `quotationitems`
--
ALTER TABLE `quotationitems`
  MODIFY `itemId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;

--
-- AUTO_INCREMENT for table `quotations`
--
ALTER TABLE `quotations`
  MODIFY `quoteId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `quotationtnc`
--
ALTER TABLE `quotationtnc`
  MODIFY `tncId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplierId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contacts`
--
ALTER TABLE `contacts`
  ADD CONSTRAINT `contacts_ibfk_1` FOREIGN KEY (`customerId`) REFERENCES `customers` (`customerId`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`supplierId`) REFERENCES `suppliers` (`supplierId`) ON DELETE SET NULL;

--
-- Constraints for table `quotationitems`
--
ALTER TABLE `quotationitems`
  ADD CONSTRAINT `quotationitems_ibfk_1` FOREIGN KEY (`quoteId`) REFERENCES `quotations` (`quoteId`) ON DELETE CASCADE,
  ADD CONSTRAINT `quotationitems_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE SET NULL;

--
-- Constraints for table `quotations`
--
ALTER TABLE `quotations`
  ADD CONSTRAINT `quotations_ibfk_1` FOREIGN KEY (`customerId`) REFERENCES `customers` (`customerId`),
  ADD CONSTRAINT `quotations_ibfk_2` FOREIGN KEY (`contactId`) REFERENCES `contacts` (`contactId`) ON DELETE SET NULL,
  ADD CONSTRAINT `quotations_ibfk_3` FOREIGN KEY (`supplierId`) REFERENCES `suppliers` (`supplierId`) ON DELETE SET NULL,
  ADD CONSTRAINT `quotations_ibfk_4` FOREIGN KEY (`tncId`) REFERENCES `quotationtnc` (`tncId`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
