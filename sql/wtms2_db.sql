-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 30, 2025 at 12:02 AM
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
-- Database: `wtms2_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_submissions`
--

CREATE TABLE `tbl_submissions` (
  `id` int(11) NOT NULL,
  `work_id` int(11) NOT NULL,
  `worker_id` int(11) NOT NULL,
  `submission_text` text NOT NULL,
  `submitted_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_submissions`
--

INSERT INTO `tbl_submissions` (`id`, `work_id`, `worker_id`, `submission_text`, `submitted_at`) VALUES
(1, 2, 1, 'done everything', '2025-05-30 05:48:18'),
(8, 2, 1, 'already done the module', '2025-05-30 05:59:18');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_works`
--

CREATE TABLE `tbl_works` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `assigned_to` int(11) NOT NULL,
  `date_assigned` date NOT NULL,
  `due_date` date NOT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `worker_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_works`
--

INSERT INTO `tbl_works` (`id`, `title`, `description`, `assigned_to`, `date_assigned`, `due_date`, `status`, `worker_id`) VALUES
(2, 'Test Task', 'Complete the module', 1, '0000-00-00', '2025-06-10', 'Pending', 0),
(4, 'Task 1 for hadif', 'Complete report 1', 1, '0000-00-00', '2025-06-10', 'Pending', 0),
(5, 'Task 2 for hadif', 'Prepare presentation', 1, '0000-00-00', '2025-06-12', 'Pending', 0),
(6, 'Task 3 for hadif', 'Update client info', 1, '0000-00-00', '2025-06-15', 'Pending', 0),
(7, 'Task 1 for umair', 'Review documents', 2, '0000-00-00', '2025-06-10', 'Pending', 0),
(8, 'Task 2 for umair', 'Call client', 2, '0000-00-00', '2025-06-13', 'Pending', 0),
(9, 'Task 3 for umair', 'Submit invoice', 2, '0000-00-00', '2025-06-17', 'Pending', 0),
(10, 'Task 1 for aiman', 'Analyze data', 3, '0000-00-00', '2025-06-11', 'Pending', 0),
(11, 'Task 2 for aiman', 'Write summary', 3, '0000-00-00', '2025-06-14', 'Pending', 0),
(12, 'Task 3 for aiman', 'Team meeting', 3, '0000-00-00', '2025-06-18', 'Pending', 0);

-- --------------------------------------------------------

--
-- Table structure for table `workers`
--

CREATE TABLE `workers` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `workers`
--

INSERT INTO `workers` (`id`, `name`, `email`, `password`, `phone`, `address`) VALUES
(1, 'hadif', 'hadif@gmail.com', '$2y$10$yzgRqmht1nDJ7v6H1c0igONHIkw65IhrDOCY7R.uvg38GV89pLLgi', '0123456789', 'TNB 2A135'),
(2, 'umair', 'mair@gmail.com', '$2y$10$yBwwe1EuizBuIp0g2QgfdOgrvwgJLM0SeRitdGGzNzKh.FCxkjQSi', '0123456789', 'TNB 2A318'),
(3, 'aiman', 'aiman@gmail.com', '$2y$10$ASkvR/IWiv/HeFf5mICmZu7mgPpvoeJzSVkAh2gaqiaoVudRgJV4K', '0123456789', 'TNB 2A112');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_submissions`
--
ALTER TABLE `tbl_submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `work_id` (`work_id`),
  ADD KEY `worker_id` (`worker_id`);

--
-- Indexes for table `tbl_works`
--
ALTER TABLE `tbl_works`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assigned_to` (`assigned_to`);

--
-- Indexes for table `workers`
--
ALTER TABLE `workers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_submissions`
--
ALTER TABLE `tbl_submissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_works`
--
ALTER TABLE `tbl_works`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `workers`
--
ALTER TABLE `workers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_submissions`
--
ALTER TABLE `tbl_submissions`
  ADD CONSTRAINT `tbl_submissions_ibfk_1` FOREIGN KEY (`work_id`) REFERENCES `tbl_works` (`id`),
  ADD CONSTRAINT `tbl_submissions_ibfk_2` FOREIGN KEY (`worker_id`) REFERENCES `workers` (`id`);

--
-- Constraints for table `tbl_works`
--
ALTER TABLE `tbl_works`
  ADD CONSTRAINT `tbl_works_ibfk_1` FOREIGN KEY (`assigned_to`) REFERENCES `workers` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
