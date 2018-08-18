-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 04, 2018 at 08:55 AM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `librasun_cafe`
--

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `invoice_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `discount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`invoice_id`, `shift_id`, `created_at`, `discount`) VALUES
(1, 1, '2018-08-03 23:27:04', 10),
(2, 1, '2018-08-03 23:29:19', 0),
(3, 2, '2018-08-03 23:33:31', 15),
(4, 1, '2018-08-04 00:13:57', 10),
(6, 2, '2018-08-04 10:16:43', 0),
(7, 2, '2018-08-04 12:06:30', 0),
(8, 2, '2018-08-04 12:07:19', 0),
(9, 2, '2018-08-04 12:08:30', 0),
(10, 2, '2018-08-04 12:14:54', 0),
(11, 2, '2018-08-04 12:15:36', 0),
(12, 2, '2018-08-04 12:18:54', 0),
(13, 2, '2018-08-04 12:22:14', 0),
(14, 2, '2018-08-04 12:23:33', 0),
(15, 2, '2018-08-04 12:27:43', 0);

-- --------------------------------------------------------

--
-- Table structure for table `invoice_details`
--

CREATE TABLE `invoice_details` (
  `id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `set_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `item_modifier_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `invoice_details`
--

INSERT INTO `invoice_details` (`id`, `invoice_id`, `set_id`, `item_id`, `item_modifier_id`, `quantity`) VALUES
(1, 1, 1, NULL, NULL, 1),
(2, 1, NULL, 1, NULL, 1),
(3, 1, NULL, 2, 4, 1),
(4, 1, NULL, 4, 5, 1),
(5, 2, NULL, 2, NULL, 1),
(6, 2, NULL, 4, NULL, 1),
(7, 3, 2, NULL, NULL, 1),
(8, 3, NULL, 3, 9, 1),
(9, 3, NULL, 6, NULL, 1),
(10, 11, 1, NULL, NULL, 1),
(11, 13, NULL, 3, NULL, 1),
(12, 13, 1, NULL, NULL, 1),
(13, 14, NULL, 3, NULL, 1),
(14, 14, 1, NULL, NULL, 1),
(15, 15, NULL, 1, 2, 1),
(16, 15, NULL, 3, NULL, 1),
(17, 15, 1, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `item_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`item_id`, `name`, `price`) VALUES
(1, 'Cafe Latte', 4),
(2, 'Hazelnut Latte', 4),
(3, 'Espresso', 4),
(4, 'Cappuccino', 4),
(5, 'Blueberry Muffin', 2),
(6, 'Rainbow Cake', 4);

-- --------------------------------------------------------

--
-- Table structure for table `modifiers`
--

CREATE TABLE `modifiers` (
  `id` int(11) NOT NULL,
  `modified_item_id` int(11) NOT NULL,
  `modifier_description` varchar(255) NOT NULL,
  `price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `modifiers`
--

INSERT INTO `modifiers` (`id`, `modified_item_id`, `modifier_description`, `price`) VALUES
(1, 1, 'Iced', 0.5),
(2, 1, 'Extra Hot', 0),
(3, 1, 'Frapped', 1.5),
(4, 2, 'Upsize', 0.5),
(5, 2, 'Extra Hot', 0),
(6, 4, 'Sugar Free', 0),
(7, 4, 'Extra Hot', 0),
(8, 4, 'Extra Creammy', 0.5),
(9, 3, 'Double', 2);

-- --------------------------------------------------------

--
-- Table structure for table `sets`
--

CREATE TABLE `sets` (
  `set_id` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sets`
--

INSERT INTO `sets` (`set_id`, `description`, `price`) VALUES
(1, 'SET 1', 5),
(2, 'SET 2', 7),
(3, 'SET 3', 12);

-- --------------------------------------------------------

--
-- Table structure for table `set_items`
--

CREATE TABLE `set_items` (
  `id` int(11) NOT NULL,
  `set_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `set_items`
--

INSERT INTO `set_items` (`id`, `set_id`, `item_id`) VALUES
(1, 1, 3),
(2, 1, 5),
(3, 2, 4),
(4, 2, 6),
(17, 3, 1),
(18, 3, 4),
(20, 3, 5),
(19, 3, 6);

-- --------------------------------------------------------

--
-- Table structure for table `shifts`
--

CREATE TABLE `shifts` (
  `shift_id` int(11) NOT NULL,
  `shifts` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shifts`
--

INSERT INTO `shifts` (`shift_id`, `shifts`) VALUES
(1, 'Shift 1'),
(2, 'Shift 2'),
(3, 'Shift 3'),
(4, 'Shift 4');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`invoice_id`),
  ADD KEY `invoices_shift_id` (`shift_id`) USING BTREE;

--
-- Indexes for table `invoice_details`
--
ALTER TABLE `invoice_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_id` (`invoice_id`),
  ADD KEY `invoice_detail_item_id` (`item_id`),
  ADD KEY `invoice_detail_set_id` (`set_id`),
  ADD KEY `invoice_details_modifier_id` (`item_modifier_id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `modifiers`
--
ALTER TABLE `modifiers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `modifiers_item_id` (`modified_item_id`);

--
-- Indexes for table `sets`
--
ALTER TABLE `sets`
  ADD PRIMARY KEY (`set_id`);

--
-- Indexes for table `set_items`
--
ALTER TABLE `set_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `set_item` (`set_id`,`item_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `shifts`
--
ALTER TABLE `shifts`
  ADD PRIMARY KEY (`shift_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `invoice_details`
--
ALTER TABLE `invoice_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `modifiers`
--
ALTER TABLE `modifiers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `sets`
--
ALTER TABLE `sets`
  MODIFY `set_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `set_items`
--
ALTER TABLE `set_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `shifts`
--
ALTER TABLE `shifts`
  MODIFY `shift_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`shift_id`) REFERENCES `shifts` (`shift_id`);

--
-- Constraints for table `invoice_details`
--
ALTER TABLE `invoice_details`
  ADD CONSTRAINT `invoice_details_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`),
  ADD CONSTRAINT `invoice_details_ibfk_2` FOREIGN KEY (`set_id`) REFERENCES `sets` (`set_id`),
  ADD CONSTRAINT `invoice_details_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`),
  ADD CONSTRAINT `invoice_details_ibfk_4` FOREIGN KEY (`item_modifier_id`) REFERENCES `modifiers` (`id`);

--
-- Constraints for table `modifiers`
--
ALTER TABLE `modifiers`
  ADD CONSTRAINT `modifiers_ibfk_1` FOREIGN KEY (`modified_item_id`) REFERENCES `items` (`item_id`);

--
-- Constraints for table `set_items`
--
ALTER TABLE `set_items`
  ADD CONSTRAINT `set_items_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`),
  ADD CONSTRAINT `set_items_ibfk_2` FOREIGN KEY (`set_id`) REFERENCES `sets` (`set_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
