-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Feb 26, 2021 at 08:20 AM
-- Server version: 5.7.31
-- PHP Version: 7.4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `orl`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `address_line1` text COLLATE utf8_unicode_ci NOT NULL,
  `address_line2` text COLLATE utf8_unicode_ci NOT NULL,
  `address_line3` text COLLATE utf8_unicode_ci NOT NULL,
  `area` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `pin_code` int(6) NOT NULL,
  `latitude` float(10,6) NOT NULL,
  `longitude` float(10,6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orphanage_addresses`
--

CREATE TABLE `orphanage_addresses` (
  `id` int(11) NOT NULL,
  `or_user_id` int(11) NOT NULL,
  `address_line1` text COLLATE utf8_unicode_ci NOT NULL,
  `address_line2` text COLLATE utf8_unicode_ci NOT NULL,
  `address_line3` text COLLATE utf8_unicode_ci NOT NULL,
  `area` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `pin_code` int(6) NOT NULL,
  `latitude` float(18,15) NOT NULL,
  `longitude` float(18,15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `orphanage_addresses`
--

INSERT INTO `orphanage_addresses` (`id`, `or_user_id`, `address_line1`, `address_line2`, `address_line3`, `area`, `city`, `pin_code`, `latitude`, `longitude`) VALUES
(1, 1, '187, Kuttiappan 2nd Street', 'Medavakkam Tank Road', '', 'Kilpauk', 'Chennai', 600010, 13.087409019470215, 80.241477966308600),
(2, 2, 'Newel Paradise', 'Dhanapal Street', '', 'West Mambalam', 'Chennai', 600033, 13.029458045959473, 80.220985412597660),
(9, 10, '844 South Hague Freeway', 'Voluptatibus laborum', 'Dolorem incididunt o', 'Architecto delectus', 'Optio elit adipisi', 47, 13.020871162414550, 80.217315673828120);

-- --------------------------------------------------------

--
-- Table structure for table `orphanage_files`
--

CREATE TABLE `orphanage_files` (
  `id` int(11) NOT NULL,
  `or_user_id` int(11) NOT NULL,
  `registration` text NOT NULL,
  `other` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orphanage_files`
--

INSERT INTO `orphanage_files` (`id`, `or_user_id`, `registration`, `other`) VALUES
(1, 10, 'orphanage_docs/Report_for_First_Review.pdf', 'orphanage_docs/Sarvesh_Resume_2_-_Page.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `orphanage_users`
--

CREATE TABLE `orphanage_users` (
  `or_user_id` int(11) NOT NULL,
  `orphanage_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `phone_number` bigint(10) NOT NULL,
  `email_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `caretaker_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `no_of_children` int(11) NOT NULL,
  `about` text COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `orphanage_users`
--

INSERT INTO `orphanage_users` (`or_user_id`, `orphanage_name`, `phone_number`, `email_id`, `caretaker_name`, `no_of_children`, `about`, `password`) VALUES
(1, 'Karunai Illam', 9791201860, 'sarvesh4232@gmail.com', 'Sarvesh', 10, 'Love to care. Care to love.', 'sarsterror'),
(2, 'Mini Vilas', 7358265069, 'madhumithaa1411@gmail.com', 'Madhumithaa', 20, 'Love ', 'mini'),
(10, 'Avram Hill', 501, 'hysagivex@mailinator.com', 'Imani Mills', 93, 'Voluptates dignissim', 'Pa$$w0rd!');

-- --------------------------------------------------------

--
-- Table structure for table `requirements`
--

CREATE TABLE `requirements` (
  `id` int(11) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `valid_till` date DEFAULT NULL,
  `or_user_id` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `requirements`
--

INSERT INTO `requirements` (`id`, `item_name`, `quantity`, `valid_till`, `or_user_id`, `timestamp`) VALUES
(3, 'Rice', 10, NULL, 2, '2021-02-03 17:08:28');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `or_user_id` int(11) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `user_id`, `or_user_id`, `item_name`, `quantity`, `timestamp`) VALUES
(1, 1, 1, 'Rice', 10, '2021-02-07 06:05:45');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `phone_number` bigint(10) NOT NULL,
  `email_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `phone_number`, `email_id`, `password`) VALUES
(1, 'sarvesh', 's', 9791201860, 'sarvesh4232@gmail.com', 'sarsterror');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_fk` (`user_id`);

--
-- Indexes for table `orphanage_addresses`
--
ALTER TABLE `orphanage_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `or_user_id_fk` (`or_user_id`);

--
-- Indexes for table `orphanage_files`
--
ALTER TABLE `orphanage_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `or_user_id` (`or_user_id`);

--
-- Indexes for table `orphanage_users`
--
ALTER TABLE `orphanage_users`
  ADD PRIMARY KEY (`or_user_id`);

--
-- Indexes for table `requirements`
--
ALTER TABLE `requirements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `or_user_id` (`or_user_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `or_used_id` (`or_user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orphanage_addresses`
--
ALTER TABLE `orphanage_addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `orphanage_files`
--
ALTER TABLE `orphanage_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orphanage_users`
--
ALTER TABLE `orphanage_users`
  MODIFY `or_user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `requirements`
--
ALTER TABLE `requirements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `orphanage_addresses`
--
ALTER TABLE `orphanage_addresses`
  ADD CONSTRAINT `or_user_id_fk` FOREIGN KEY (`or_user_id`) REFERENCES `orphanage_users` (`or_user_id`);

--
-- Constraints for table `orphanage_files`
--
ALTER TABLE `orphanage_files`
  ADD CONSTRAINT `orphanage_files_ibfk_1` FOREIGN KEY (`or_user_id`) REFERENCES `orphanage_users` (`or_user_id`);

--
-- Constraints for table `requirements`
--
ALTER TABLE `requirements`
  ADD CONSTRAINT `requirements_ibfk_1` FOREIGN KEY (`or_user_id`) REFERENCES `orphanage_users` (`or_user_id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`or_user_id`) REFERENCES `orphanage_users` (`or_user_id`),
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
