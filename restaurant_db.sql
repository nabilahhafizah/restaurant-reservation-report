-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 20, 2026 at 02:42 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `restaurant_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `booking_id` int(11) NOT NULL,
  `booking_date` date DEFAULT NULL,
  `number_of_party` int(11) DEFAULT NULL,
  `table_no` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`booking_id`, `booking_date`, `number_of_party`, `table_no`) VALUES
(1, '2025-12-28', 4, 1),
(2, '2025-12-29', 2, 2),
(3, '2025-12-29', 6, 3);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `contact_no` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `other_details` varchar(200) DEFAULT NULL,
  `booking_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `first_name`, `last_name`, `contact_no`, `email`, `other_details`, `booking_id`) VALUES
(1, 'Jane', 'Smith', '01122334455', 'jane123@gmail.com', 'Require baby\'s high chair', 1),
(2, 'John', 'Doe', '02233445566', 'j_doe87@gmail.com', 'none', 2),
(3, 'Anne', 'Brown', '03344556677', 'anne_brown@yahoo.com', 'none', 3);

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `menu_id` int(11) NOT NULL,
  `menu_item` varchar(100) DEFAULT NULL,
  `menu_price` decimal(6,2) DEFAULT NULL,
  `menu_quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`menu_id`, `menu_item`, `menu_price`, `menu_quantity`) VALUES
(1, '1', 5.00, 3),
(2, '2', 10.00, 2),
(3, '3', 5.00, 6);

-- --------------------------------------------------------

--
-- Table structure for table `order_reserved`
--

CREATE TABLE `order_reserved` (
  `order_id` int(11) NOT NULL,
  `order_date` date DEFAULT NULL,
  `order_time` time DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `menu_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_reserved`
--

INSERT INTO `order_reserved` (`order_id`, `order_date`, `order_time`, `staff_id`, `menu_id`) VALUES
(1, '2026-01-01', '19:00:00', 2, 1),
(2, '2026-01-07', '16:30:00', 3, 2),
(3, '2026-01-07', '19:15:00', 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL,
  `staff_first_name` varchar(50) DEFAULT NULL,
  `staff_last_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `staff_first_name`, `staff_last_name`) VALUES
(1, 'Brian', 'Will'),
(2, 'Lisa', 'Jackson'),
(3, 'Sam', 'Jacob');

-- --------------------------------------------------------

--
-- Table structure for table `table_reserved`
--

CREATE TABLE `table_reserved` (
  `table_no` int(11) NOT NULL,
  `table_details` varchar(100) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `table_reserved`
--

INSERT INTO `table_reserved` (`table_no`, `table_details`, `order_id`) VALUES
(1, '2 to 4 persons table', 1),
(2, 'Outdoor table', 2),
(3, 'Family dining table', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `table_no` (`table_no`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`menu_id`);

--
-- Indexes for table `order_reserved`
--
ALTER TABLE `order_reserved`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `staff_id` (`staff_id`),
  ADD KEY `menu_id` (`menu_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`);

--
-- Indexes for table `table_reserved`
--
ALTER TABLE `table_reserved`
  ADD PRIMARY KEY (`table_no`),
  ADD KEY `order_id` (`order_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`table_no`) REFERENCES `table_reserved` (`table_no`);

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`);

--
-- Constraints for table `order_reserved`
--
ALTER TABLE `order_reserved`
  ADD CONSTRAINT `order_reserved_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`),
  ADD CONSTRAINT `order_reserved_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`menu_id`);

--
-- Constraints for table `table_reserved`
--
ALTER TABLE `table_reserved`
  ADD CONSTRAINT `table_reserved_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order_reserved` (`order_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
