-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Mar 07, 2021 at 12:15 PM
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
-- Table structure for table `admin_users`
--

CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone_number` bigint(10) NOT NULL,
  `email_id` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `approvals`
--

CREATE TABLE `approvals` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `or_user_id` int(11) NOT NULL,
  `account_status` varchar(10) NOT NULL DEFAULT 'pending',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `approvals`
--

INSERT INTO `approvals` (`id`, `admin_id`, `or_user_id`, `account_status`, `timestamp`) VALUES
(1, NULL, 11, 'approved', '2021-02-27 05:32:31'),
(2, NULL, 12, 'pending', '2021-02-27 06:15:03');

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
(10, 11, '36 North First Street', 'Explicabo Lorem per', 'Sint perspiciatis i', 'Minima voluptas exer', 'Ipsum sint facilis', 70, 13.020885467529297, 80.217323303222660),
(11, 12, '870 Hague Parkway', 'Impedit sed vero es', 'Quos aliqua Dolore ', 'Quis exercitationem ', 'Facere dolore earum ', 9, 13.020875930786133, 80.217315673828120);

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
(2, 11, 'Report_for_First_Review.pdf', 'orphanage_docs/Sarvesh_Resume_2_-_Page.pdf'),
(3, 12, 'orphanage_docs/Report_for_First_Review.pdf', 'orphanage_docs/Sarvesh_Resume_2_-_Page.pdf');

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
  `password` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `account_status` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `orphanage_users`
--

INSERT INTO `orphanage_users` (`or_user_id`, `orphanage_name`, `phone_number`, `email_id`, `caretaker_name`, `no_of_children`, `about`, `password`, `account_status`) VALUES
(1, 'Karunai Illam', 9791201860, 'sarvesh4232@gmail.com', 'Sarvesh', 10, 'Love to care. Care to love.', 'sarsterror', 1),
(2, 'Mini Vilas', 7358265069, 'madhumithaa1411@gmail.com', 'Madhumithaa', 20, 'Love ', 'mini', 1),
(11, 'Cedric Bean', 960, 'gydydu@mailinator.com', 'Rae Long', 36, 'Veritatis in alias p', 'Pa$$w0rd!', 0),
(12, 'Kareem Holt', 931, 'qevaciz@mailinator.com', 'Marny Dunlap', 81, 'Est accusantium cupi', 'Pa$$w0rd!', 0);

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
(1, 1, 1, 'Rice', 10, '2021-02-07 06:05:45'),
(13, 1, 1, 'Money', 200, '2021-03-06 11:29:47');

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
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `approvals`
--
ALTER TABLE `approvals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`),
  ADD KEY `or_user_id` (`or_user_id`);

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
-- AUTO_INCREMENT for table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `approvals`
--
ALTER TABLE `approvals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `orphanage_addresses`
--
ALTER TABLE `orphanage_addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `orphanage_files`
--
ALTER TABLE `orphanage_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `orphanage_users`
--
ALTER TABLE `orphanage_users`
  MODIFY `or_user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `requirements`
--
ALTER TABLE `requirements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

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
-- Constraints for table `approvals`
--
ALTER TABLE `approvals`
  ADD CONSTRAINT `approvals_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin_users` (`id`),
  ADD CONSTRAINT `approvals_ibfk_2` FOREIGN KEY (`or_user_id`) REFERENCES `orphanage_users` (`or_user_id`);

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
