-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 30, 2025 at 07:00 PM
-- Server version: 8.0.41-0ubuntu0.20.04.1
-- PHP Version: 7.4.3-4ubuntu2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ai_quiz`
--

-- --------------------------------------------------------

--
-- Table structure for table `error_log`
--

DROP TABLE IF EXISTS `error_log`;
CREATE TABLE `error_log` (
  `logid` int NOT NULL,
  `clientid` int NOT NULL,
  `uploadtype` enum('topic','question','user') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `filename` varchar(500) NOT NULL,
  `deleted` tinyint NOT NULL DEFAULT '0',
  `createdat` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `error_log`
--

INSERT INTO `error_log` (`logid`, `clientid`, `uploadtype`, `filename`, `deleted`, `createdat`) VALUES
(1, 1, 'user', 'user_upload_errors_20250530151737.xlsx', 0, '2025-05-30 09:47:37'),
(2, 1, 'question', 'question_upload_errors_20250530161651.xlsx', 0, '2025-05-30 10:46:51'),
(3, 1, 'question', 'question_upload_errors_20250530162018.xlsx', 0, '2025-05-30 10:50:18');

-- --------------------------------------------------------

--
-- Table structure for table `mst_categories`
--

DROP TABLE IF EXISTS `mst_categories`;
CREATE TABLE `mst_categories` (
  `categoryid` int NOT NULL,
  `clientid` int DEFAULT NULL,
  `topicid` int NOT NULL,
  `categoryname` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `mst_categories`
--

INSERT INTO `mst_categories` (`categoryid`, `clientid`, `topicid`, `categoryname`) VALUES
(1, 1, 1, 'General History'),
(2, 1, 2, 'General Geography'),
(3, 1, 3, 'General Science'),
(4, 1, 4, 'Algebra'),
(5, 1, 4, 'Arithmetic'),
(6, 1, 4, 'Geometry'),
(7, 1, 5, 'Grammar'),
(8, 1, 5, 'Vocabulary'),
(9, 1, 5, 'Comprehension'),
(10, 1, 6, 'Ecosystems'),
(11, 1, 6, 'Climate Change'),
(12, 1, 6, 'Pollution'),
(15, 1, 11, 'Algebra'),
(16, 1, 11, 'Geometry'),
(17, 1, 12, 'World History'),
(18, 1, 12, 'Indian History'),
(19, 1, 13, 'Algebra'),
(20, 1, 13, 'Geometry'),
(21, 1, 14, 'World History'),
(22, 1, 14, 'Indian History'),
(23, 1, 15, 'Algebra'),
(24, 1, 15, 'Geometry'),
(25, 1, 16, 'World History'),
(26, 1, 16, 'Indian History');

-- --------------------------------------------------------

--
-- Table structure for table `mst_clients`
--

DROP TABLE IF EXISTS `mst_clients`;
CREATE TABLE `mst_clients` (
  `clientid` int NOT NULL,
  `integrationkey` varchar(100) DEFAULT NULL,
  `clientname` varchar(100) NOT NULL,
  `licenceno` varchar(100) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `agenticaiaccess` tinyint(1) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `createdat` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `mst_clients`
--

INSERT INTO `mst_clients` (`clientid`, `integrationkey`, `clientname`, `licenceno`, `active`, `phone`, `email`, `logo`, `agenticaiaccess`, `deleted`, `createdat`) VALUES
(1, NULL, 'WOWL', '1234', 1, '7786756545', 'wowl@yoopmail.com', 'quiz-logo.png', 0, 0, '2025-05-23 11:00:30');

-- --------------------------------------------------------

--
-- Table structure for table `mst_goals`
--

DROP TABLE IF EXISTS `mst_goals`;
CREATE TABLE `mst_goals` (
  `goal_id` int NOT NULL,
  `clientid` int NOT NULL,
  `topic_id` int NOT NULL,
  `goal_title` varchar(255) NOT NULL,
  `goal_description` text,
  `duration_days` int NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `mst_goals`
--

INSERT INTO `mst_goals` (`goal_id`, `clientid`, `topic_id`, `goal_title`, `goal_description`, `duration_days`, `is_active`, `created_at`) VALUES
(1, 1, 1, 'Master World History', 'Study key global events, civilizations, and revolutions across history.', 30, 1, '2025-05-30 17:43:53'),
(2, 1, 1, 'Learn Indian History', 'Understand the ancient to modern transformation of Indian civilization.', 20, 1, '2025-05-30 17:43:53'),
(3, 1, 2, 'Conquer Geography Fundamentals', 'Learn about continents, landforms, climate, and capitals.', 25, 1, '2025-05-30 17:43:53'),
(4, 1, 3, 'Explore Science & Tech Essentials', 'Understand basic physics, chemistry, biology, and tech innovations.', 30, 1, '2025-05-30 17:43:53'),
(5, 1, 4, 'Master Core Math Skills', 'Focus on algebra, arithmetic, and problem-solving.', 30, 1, '2025-05-30 17:43:53'),
(6, 1, 4, 'Basic Math Refresher', 'Practice simple calculations, percentages, and ratios.', 20, 1, '2025-05-30 17:43:53'),
(7, 1, 4, 'Math Improvement Plan', 'Develop confidence in fundamental math skills.', 25, 1, '2025-05-30 17:43:53'),
(8, 1, 5, 'Boost Your English', 'Improve vocabulary, grammar, and comprehension.', 30, 1, '2025-05-30 17:43:53'),
(9, 1, 6, 'Understand Environment & Climate', 'Learn about ecosystems, sustainability, and climate change.', 30, 1, '2025-05-30 17:43:53');

-- --------------------------------------------------------

--
-- Table structure for table `mst_levels`
--

DROP TABLE IF EXISTS `mst_levels`;
CREATE TABLE `mst_levels` (
  `level_id` int NOT NULL,
  `clientid` int DEFAULT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `mst_levels`
--

INSERT INTO `mst_levels` (`level_id`, `clientid`, `name`) VALUES
(1, 1, 'Simple'),
(2, 1, 'Intermediate'),
(3, 1, 'Advanced');

-- --------------------------------------------------------

--
-- Table structure for table `mst_options`
--

DROP TABLE IF EXISTS `mst_options`;
CREATE TABLE `mst_options` (
  `option_id` int NOT NULL,
  `clientid` int DEFAULT NULL,
  `question_id` int DEFAULT NULL,
  `option_label` char(1) DEFAULT NULL,
  `option_text` text NOT NULL,
  `is_correct` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `mst_options`
--

INSERT INTO `mst_options` (`option_id`, `clientid`, `question_id`, `option_label`, `option_text`, `is_correct`) VALUES
(1, 1, 1, 'a', 'Subhash Chandra Bose', 0),
(2, 1, 1, 'b', 'Mahatma Gandhi', 1),
(3, 1, 1, 'c', 'Bhagat Singh', 0),
(4, 1, 2, 'a', 'Ashoka', 0),
(5, 1, 2, 'b', 'Chandragupta Maurya', 1),
(6, 1, 2, 'c', 'Bindusara', 0),
(7, 1, 3, 'a', 'Jawaharlal Nehru', 1),
(8, 1, 3, 'b', 'Mahatma Gandhi', 0),
(9, 1, 3, 'c', 'Sardar Patel', 0),
(10, 1, 4, 'a', '1945', 0),
(11, 1, 4, 'b', '1947', 1),
(12, 1, 4, 'c', '1950', 0),
(13, 1, 5, 'a', 'Pataliputra', 1),
(14, 1, 5, 'b', 'Delhi', 0),
(15, 1, 5, 'c', 'Ujjain', 0),
(16, 1, 6, 'a', 'Delhi', 0),
(17, 1, 6, 'b', 'Amritsar', 1),
(18, 1, 6, 'c', 'Kolkata', 0),
(19, 1, 7, 'a', 'Nehru', 0),
(20, 1, 7, 'b', 'Shastri', 1),
(21, 1, 7, 'c', 'Indira Gandhi', 0),
(22, 1, 8, 'a', 'Bankim Chandra Chatterjee', 0),
(23, 1, 8, 'b', 'Rabindranath Tagore', 1),
(24, 1, 8, 'c', 'Sarojini Naidu', 0),
(25, 1, 9, 'a', 'Rajendra Prasad', 0),
(26, 1, 9, 'b', 'Jawaharlal Nehru', 0),
(27, 1, 9, 'c', 'Sardar Patel', 1),
(28, 1, 10, 'a', 'Mughal', 1),
(29, 1, 10, 'b', 'Maurya', 0),
(30, 1, 10, 'c', 'Gupta', 0),
(31, 1, 11, 'a', '1930', 0),
(32, 1, 11, 'b', '1942', 1),
(33, 1, 11, 'c', '1947', 0),
(34, 1, 12, 'a', 'Charter Act 1833', 0),
(35, 1, 12, 'b', 'Government of India Act 1858', 1),
(36, 1, 12, 'c', 'Indian Councils Act 1861', 0),
(37, 1, 13, 'a', 'Akbar', 1),
(38, 1, 13, 'b', 'Babur', 0),
(39, 1, 13, 'c', 'Aurangzeb', 0),
(40, 1, 14, 'a', 'Delhi', 0),
(41, 1, 14, 'b', 'Meerut', 1),
(42, 1, 14, 'c', 'Kanpur', 0),
(43, 1, 15, 'a', 'Mumbai', 0),
(44, 1, 15, 'b', 'Calcutta', 1),
(45, 1, 15, 'c', 'Madras', 0),
(46, 1, 16, 'a', 'Guru Nanak', 0),
(47, 1, 16, 'b', 'Ranjit Singh', 1),
(48, 1, 16, 'c', 'Gobind Singh', 0),
(49, 1, 17, 'a', 'Shivaji', 0),
(50, 1, 17, 'b', 'Ahmad Shah Abdali', 1),
(51, 1, 17, 'c', 'Tipu Sultan', 0),
(52, 1, 18, 'a', 'Lord Curzon', 1),
(53, 1, 18, 'b', 'Lord Mountbatten', 0),
(54, 1, 18, 'c', 'Lord Canning', 0),
(55, 1, 19, 'a', 'Mahatma Gandhi', 0),
(56, 1, 19, 'b', 'Subhash Chandra Bose', 1),
(57, 1, 19, 'c', 'Lala Lajpat Rai', 0),
(58, 1, 20, 'a', 'Cornwallis', 1),
(59, 1, 20, 'b', 'Warren Hastings', 0),
(60, 1, 20, 'c', 'Dalhousie', 0),
(61, 1, 21, 'a', 'Akbar', 0),
(62, 1, 21, 'b', 'Dara Shikoh', 1),
(63, 1, 21, 'c', 'Aurangzeb', 0),
(64, 1, 22, 'a', 'Nehru', 0),
(65, 1, 22, 'b', 'Mountbatten', 0),
(66, 1, 22, 'c', 'Rajagopalachari', 1),
(67, 1, 23, 'a', 'Ashoka', 0),
(68, 1, 23, 'b', 'Chandragupta Maurya', 1),
(69, 1, 23, 'c', 'Harsha', 0),
(70, 1, 24, 'a', 'Maurya', 0),
(71, 1, 24, 'b', 'Chalukya', 0),
(72, 1, 24, 'c', 'Satavahana', 1),
(73, 1, 25, 'a', 'Reform education', 0),
(74, 1, 25, 'b', 'Review Constitution', 1),
(75, 1, 25, 'c', 'Divide Bengal', 0),
(76, 1, 26, 'a', 'Partition of Bengal', 0),
(77, 1, 26, 'b', 'Jallianwala Bagh Massacre', 1),
(78, 1, 26, 'c', 'Dandi March', 0),
(79, 1, 27, 'a', 'Tilak', 0),
(80, 1, 27, 'b', 'Bhagat Singh', 0),
(81, 1, 27, 'c', 'Subhash Chandra Bose', 1),
(82, 1, 28, 'a', '1930 Lahore', 1),
(83, 1, 28, 'b', '1929 Karachi', 0),
(84, 1, 28, 'c', '1927 Madras', 0),
(85, 1, 29, 'a', 'Act of 1861', 0),
(86, 1, 29, 'b', 'Act of 1892', 0),
(87, 1, 29, 'c', 'Act of 1909', 1),
(88, 1, 30, 'a', 'Chanakya', 1),
(89, 1, 30, 'b', 'Patanjali', 0),
(90, 1, 30, 'c', 'Panini', 0),
(91, 1, 31, 'a', 'Chotanagpur', 0),
(92, 1, 31, 'b', 'Malwa', 0),
(93, 1, 31, 'c', 'Peninsular', 1),
(94, 1, 32, 'a', 'Odisha', 0),
(95, 1, 32, 'b', 'Assam', 0),
(96, 1, 32, 'c', 'West Bengal', 1),
(97, 1, 33, 'a', 'Chilika', 0),
(98, 1, 33, 'b', 'Wular', 1),
(99, 1, 33, 'c', 'Loktak', 0),
(100, 1, 34, 'a', 'Kanyakumari', 0),
(101, 1, 34, 'b', 'Indira Point', 1),
(102, 1, 34, 'c', 'Rameshwaram', 0),
(103, 1, 35, 'a', 'Kerala', 0),
(104, 1, 35, 'b', 'Gujarat', 1),
(105, 1, 35, 'c', 'Tamil Nadu', 0),
(106, 1, 36, 'a', 'Jaipur', 1),
(107, 1, 36, 'b', 'Jodhpur', 0),
(108, 1, 36, 'c', 'Udaipur', 0),
(109, 1, 37, 'a', 'Yamuna', 0),
(110, 1, 37, 'b', 'Ganga', 1),
(111, 1, 37, 'c', 'Godavari', 0),
(112, 1, 38, 'a', 'Punjab', 0),
(113, 1, 38, 'b', 'Gujarat', 0),
(114, 1, 38, 'c', 'Rajasthan', 1),
(115, 1, 39, 'a', 'Kanchenjunga', 1),
(116, 1, 39, 'b', 'Everest', 0),
(117, 1, 39, 'c', 'Nanda Devi', 0),
(118, 1, 40, 'a', 'Yamuna', 0),
(119, 1, 40, 'b', 'Brahmaputra', 0),
(120, 1, 40, 'c', 'Ganga', 1),
(121, 1, 41, 'a', 'Godavari', 1),
(122, 1, 41, 'b', 'Krishna', 0),
(123, 1, 41, 'c', 'Cauvery', 0),
(124, 1, 42, 'a', 'Yamuna', 0),
(125, 1, 42, 'b', 'Narmada', 1),
(126, 1, 42, 'c', 'Godavari', 0),
(127, 1, 43, 'a', 'Pune', 1),
(128, 1, 43, 'b', 'Nagpur', 0),
(129, 1, 43, 'c', 'Nashik', 0),
(130, 1, 44, 'a', 'Ladakh', 1),
(131, 1, 44, 'b', 'Himachal Pradesh', 0),
(132, 1, 44, 'c', 'Uttarakhand', 0),
(133, 1, 45, 'a', 'Hyderabad', 0),
(134, 1, 45, 'b', 'Bengaluru', 1),
(135, 1, 45, 'c', 'Chennai', 0),
(136, 1, 46, 'a', 'Maharashtra', 0),
(137, 1, 46, 'b', 'Madhya Pradesh', 0),
(138, 1, 46, 'c', 'Rajasthan', 1),
(139, 1, 47, 'a', 'Mumbai', 0),
(140, 1, 47, 'b', 'Kochi', 1),
(141, 1, 47, 'c', 'Chennai', 0),
(142, 1, 48, 'a', 'Madhya Pradesh', 1),
(143, 1, 48, 'b', 'Arunachal Pradesh', 0),
(144, 1, 48, 'c', 'Chhattisgarh', 0),
(145, 1, 49, 'a', 'Sikkim', 1),
(146, 1, 49, 'b', 'Nagaland', 0),
(147, 1, 49, 'c', 'Manipur', 0),
(148, 1, 50, 'a', 'Assam', 0),
(149, 1, 50, 'b', 'Madhya Pradesh', 1),
(150, 1, 50, 'c', 'Uttarakhand', 0),
(151, 1, 51, 'a', 'Ganga-Brahmaputra', 1),
(152, 1, 51, 'b', 'Indus', 0),
(153, 1, 51, 'c', 'Krishna', 0),
(154, 1, 52, 'a', 'Sabarmati', 1),
(155, 1, 52, 'b', 'Tapi', 0),
(156, 1, 52, 'c', 'Mahi', 0),
(157, 1, 53, 'a', 'Nathu La', 1),
(158, 1, 53, 'b', 'Zojila', 0),
(159, 1, 53, 'c', 'Khardung La', 0),
(160, 1, 54, 'a', 'Chotanagpur', 1),
(161, 1, 54, 'b', 'Malwa', 0),
(162, 1, 54, 'c', 'Deccan', 0),
(163, 1, 55, 'a', 'Punjab', 1),
(164, 1, 55, 'b', 'Haryana', 0),
(165, 1, 55, 'c', 'UP', 0),
(166, 1, 56, 'a', 'Barren Island', 1),
(167, 1, 56, 'b', 'Lakshadweep', 0),
(168, 1, 56, 'c', 'Port Blair', 0),
(169, 1, 57, 'a', 'Jaipur', 0),
(170, 1, 57, 'b', 'Udaipur', 1),
(171, 1, 57, 'c', 'Bhopal', 0),
(172, 1, 58, 'a', 'Kerala', 1),
(173, 1, 58, 'b', 'Tamil Nadu', 0),
(174, 1, 58, 'c', 'Karnataka', 0),
(175, 1, 59, 'a', 'Cherrapunji', 0),
(176, 1, 59, 'b', 'Mawsynram', 1),
(177, 1, 59, 'c', 'Kochi', 0),
(178, 1, 60, 'a', 'Andaman', 0),
(179, 1, 60, 'b', 'Lakshadweep', 1),
(180, 1, 60, 'c', 'Minicoy', 0),
(181, 1, 61, 'a', 'Mars', 1),
(182, 1, 61, 'b', 'Venus', 0),
(183, 1, 61, 'c', 'Jupiter', 0),
(184, 1, 62, 'a', '90', 0),
(185, 1, 62, 'b', '100', 1),
(186, 1, 62, 'c', '110', 0),
(187, 1, 63, 'a', 'Oxygen', 0),
(188, 1, 63, 'b', 'Carbon Dioxide', 1),
(189, 1, 63, 'c', 'Nitrogen', 0),
(190, 1, 64, 'a', 'Thermometer', 1),
(191, 1, 64, 'b', 'Barometer', 0),
(192, 1, 64, 'c', 'Hygrometer', 0),
(193, 1, 65, 'a', 'Sight', 0),
(194, 1, 65, 'b', 'Taste', 1),
(195, 1, 65, 'c', 'Smell', 0),
(196, 1, 66, 'a', '6', 1),
(197, 1, 66, 'b', '8', 0),
(198, 1, 66, 'c', '4', 0),
(199, 1, 67, 'a', 'Salt', 0),
(200, 1, 67, 'b', 'Oxygen', 0),
(201, 1, 67, 'c', 'Water', 1),
(202, 1, 68, 'a', 'Root', 0),
(203, 1, 68, 'b', 'Leaf', 1),
(204, 1, 68, 'c', 'Stem', 0),
(205, 1, 69, 'a', 'Brain', 0),
(206, 1, 69, 'b', 'Lungs', 0),
(207, 1, 69, 'c', 'Heart', 1),
(208, 1, 70, 'a', 'Carbon Dioxide', 0),
(209, 1, 70, 'b', 'Oxygen', 1),
(210, 1, 70, 'c', 'Hydrogen', 0),
(211, 1, 71, 'a', 'Isaac Newton', 0),
(212, 1, 71, 'b', 'Albert Einstein', 1),
(213, 1, 71, 'c', 'Stephen Hawking', 0),
(214, 1, 72, 'a', 'Cytoplasm', 0),
(215, 1, 72, 'b', 'Nucleus', 1),
(216, 1, 72, 'c', 'Mitochondria', 0),
(217, 1, 73, 'a', 'Joule', 0),
(218, 1, 73, 'b', 'Watt', 0),
(219, 1, 73, 'c', 'Newton', 1),
(220, 1, 74, 'a', 'O-', 1),
(221, 1, 74, 'b', 'AB+', 0),
(222, 1, 74, 'c', 'A+', 0),
(223, 1, 75, 'a', 'Vitamin A', 0),
(224, 1, 75, 'b', 'Vitamin C', 0),
(225, 1, 75, 'c', 'Vitamin D', 1),
(226, 1, 76, 'a', 'Iron', 0),
(227, 1, 76, 'b', 'Mercury', 1),
(228, 1, 76, 'c', 'Gold', 0),
(229, 1, 77, 'a', 'NaCl', 1),
(230, 1, 77, 'b', 'KCl', 0),
(231, 1, 77, 'c', 'CaCl2', 0),
(232, 1, 78, 'a', 'Cerebrum', 0),
(233, 1, 78, 'b', 'Cerebellum', 1),
(234, 1, 78, 'c', 'Medulla', 0),
(235, 1, 79, 'a', 'Central Processing Unit', 1),
(236, 1, 79, 'b', 'Computer Program Utility', 0),
(237, 1, 79, 'c', 'Central Power Unit', 0),
(238, 1, 80, 'a', 'Alexander Fleming', 1),
(239, 1, 80, 'b', 'Marie Curie', 0),
(240, 1, 80, 'c', 'Isaac Newton', 0),
(241, 1, 81, 'a', 'Java', 0),
(242, 1, 81, 'b', 'Python', 1),
(243, 1, 81, 'c', 'C++', 0),
(244, 1, 82, 'a', 'Proton', 0),
(245, 1, 82, 'b', 'Electron', 1),
(246, 1, 82, 'c', 'Neutron', 0),
(247, 1, 83, 'a', 'Reflection', 0),
(248, 1, 83, 'b', 'Diffraction', 0),
(249, 1, 83, 'c', 'Refraction', 1),
(250, 1, 84, 'a', 'Nucleus', 0),
(251, 1, 84, 'b', 'Mitochondria', 1),
(252, 1, 84, 'c', 'Ribosome', 0),
(253, 1, 85, 'a', 'Newton\'s First Law', 0),
(254, 1, 85, 'b', 'Newton\'s Second Law', 1),
(255, 1, 85, 'c', 'Newton\'s Third Law', 0),
(256, 1, 86, 'a', 'Respiration', 0),
(257, 1, 86, 'b', 'Photosynthesis', 1),
(258, 1, 86, 'c', 'Fermentation', 0),
(259, 1, 87, 'a', 'Uranium', 1),
(260, 1, 87, 'b', 'Iron', 0),
(261, 1, 87, 'c', 'Copper', 0),
(262, 1, 88, 'a', 'Jupiter', 1),
(263, 1, 88, 'b', 'Earth', 0),
(264, 1, 88, 'c', 'Mars', 0),
(265, 1, 89, 'a', '300,000 km/s', 1),
(266, 1, 89, 'b', '150,000 km/s', 0),
(267, 1, 89, 'c', '450,000 km/s', 0),
(268, 1, 90, 'a', 'Edward Jenner', 0),
(269, 1, 90, 'b', 'Jonas Salk', 1),
(270, 1, 90, 'c', 'Louis Pasteur', 0),
(271, 1, 91, 'a', '3', 0),
(272, 1, 91, 'b', '4', 1),
(273, 1, 91, 'c', '5', 0),
(274, 1, 92, 'a', '3', 0),
(275, 1, 92, 'b', '5', 0),
(276, 1, 92, 'c', '6', 1),
(277, 1, 93, 'a', '2', 0),
(278, 1, 93, 'b', '3', 1),
(279, 1, 93, 'c', '4', 0),
(280, 1, 94, 'a', 'Square', 0),
(281, 1, 94, 'b', 'Triangle', 1),
(282, 1, 94, 'c', 'Circle', 0),
(283, 1, 95, 'a', '5', 1),
(284, 1, 95, 'b', '10', 0),
(285, 1, 95, 'c', '0', 0),
(286, 1, 96, 'a', '2', 0),
(287, 1, 96, 'b', '5', 1),
(288, 1, 96, 'c', '10', 0),
(289, 1, 97, 'a', '1', 1),
(290, 1, 97, 'b', '2', 0),
(291, 1, 97, 'c', '3', 0),
(292, 1, 98, 'a', '6', 0),
(293, 1, 98, 'b', '9', 1),
(294, 1, 98, 'c', '12', 0),
(295, 1, 99, 'a', '8', 1),
(296, 1, 99, 'b', '9', 0),
(297, 1, 99, 'c', '10', 0),
(298, 1, 100, 'a', '2', 0),
(299, 1, 100, 'b', '3', 1),
(300, 1, 100, 'c', '4', 0),
(301, 1, 101, 'a', '2', 0),
(302, 1, 101, 'b', '5', 1),
(303, 1, 101, 'c', '10', 0),
(304, 1, 102, 'a', '15', 1),
(305, 1, 102, 'b', '20', 0),
(306, 1, 102, 'c', '25', 0),
(307, 1, 103, 'a', '5', 0),
(308, 1, 103, 'b', '6', 1),
(309, 1, 103, 'c', '8', 0),
(310, 1, 104, 'a', '64', 1),
(311, 1, 104, 'b', '16', 0),
(312, 1, 104, 'c', '32', 0),
(313, 1, 105, 'a', 'x=2', 0),
(314, 1, 105, 'b', 'x=3', 0),
(315, 1, 105, 'c', 'x=4', 1),
(316, 1, 106, 'a', '5', 1),
(317, 1, 106, 'b', '6', 0),
(318, 1, 106, 'c', '4', 0),
(319, 1, 107, 'a', '9', 0),
(320, 1, 107, 'b', '11', 1),
(321, 1, 107, 'c', '13', 0),
(322, 1, 108, 'a', '16', 0),
(323, 1, 108, 'b', '27', 1),
(324, 1, 108, 'c', '18', 0),
(325, 1, 109, 'a', '8', 0),
(326, 1, 109, 'b', '16', 1),
(327, 1, 109, 'c', '12', 0),
(328, 1, 110, 'a', '9', 0),
(329, 1, 110, 'b', '18', 0),
(330, 1, 110, 'c', '12', 1),
(331, 1, 111, 'a', 'x=7', 0),
(332, 1, 111, 'b', 'x=±7', 1),
(333, 1, 111, 'c', 'x=−7', 0),
(334, 1, 112, 'a', 'x', 0),
(335, 1, 112, 'b', '2x', 1),
(336, 1, 112, 'c', 'x^2', 0),
(337, 1, 113, 'a', 'x^2', 1),
(338, 1, 113, 'b', '2x^2', 0),
(339, 1, 113, 'c', 'x^3', 0),
(340, 1, 114, 'a', '0', 1),
(341, 1, 114, 'b', '∞', 0),
(342, 1, 114, 'c', '1', 0),
(343, 1, 115, 'a', 'x=10', 0),
(344, 1, 115, 'b', 'x=100', 1),
(345, 1, 115, 'c', 'x=1000', 0),
(346, 1, 116, 'a', '180°', 0),
(347, 1, 116, 'b', '90°', 1),
(348, 1, 116, 'c', '60°', 0),
(349, 1, 117, 'a', 'cos(x)', 1),
(350, 1, 117, 'b', '−cos(x)', 0),
(351, 1, 117, 'c', '−sin(x)', 0),
(352, 1, 118, 'a', '0', 0),
(353, 1, 118, 'b', '1', 1),
(354, 1, 118, 'c', '0.5', 0),
(355, 1, 119, 'a', '3x^2', 1),
(356, 1, 119, 'b', 'x^2', 0),
(357, 1, 119, 'c', '3x', 0),
(358, 1, 120, 'a', '16', 0),
(359, 1, 120, 'b', '32', 1),
(360, 1, 120, 'c', '64', 0),
(361, 1, 121, 'a', 'Run', 0),
(362, 1, 121, 'b', 'Happiness', 1),
(363, 1, 121, 'c', 'Quickly', 0),
(364, 1, 122, 'a', 'She go to school.', 0),
(365, 1, 122, 'b', 'She goes to school.', 1),
(366, 1, 122, 'c', 'She going school.', 0),
(367, 1, 123, 'a', 'Tiny', 0),
(368, 1, 123, 'b', 'Huge', 1),
(369, 1, 123, 'c', 'Small', 0),
(370, 1, 124, 'a', 'He', 0),
(371, 1, 124, 'b', 'runs', 1),
(372, 1, 124, 'c', 'fast', 0),
(373, 1, 125, 'a', 'Hot', 1),
(374, 1, 125, 'b', 'Cool', 0),
(375, 1, 125, 'c', 'Chill', 0),
(376, 1, 126, 'a', 'A', 0),
(377, 1, 126, 'b', 'An', 1),
(378, 1, 126, 'c', 'The', 0),
(379, 1, 127, 'a', 'A place', 0),
(380, 1, 127, 'b', 'A name', 0),
(381, 1, 127, 'c', 'A word that replaces a noun', 1),
(382, 1, 128, 'a', 'Tree skin', 0),
(383, 1, 128, 'b', 'Sound made by a dog', 1),
(384, 1, 128, 'c', 'A person', 0),
(385, 1, 129, 'a', 'Childs', 0),
(386, 1, 129, 'b', 'Children', 1),
(387, 1, 129, 'c', 'Childes', 0),
(388, 1, 130, 'a', 'eated', 0),
(389, 1, 130, 'b', 'ate', 1),
(390, 1, 130, 'c', 'eats', 0),
(391, 1, 131, 'a', 'car', 0),
(392, 1, 131, 'b', 'red', 1),
(393, 1, 131, 'c', 'fast', 0),
(394, 1, 132, 'a', 'Under', 1),
(395, 1, 132, 'b', 'Running', 0),
(396, 1, 132, 'c', 'She', 0),
(397, 1, 133, 'a', 'Slow', 0),
(398, 1, 133, 'b', 'Slowly', 1),
(399, 1, 133, 'c', 'Slowness', 0),
(400, 1, 134, 'a', 'A verb', 0),
(401, 1, 134, 'b', 'A joining word', 1),
(402, 1, 134, 'c', 'An emotion', 0),
(403, 1, 135, 'a', 'Same meaning', 1),
(404, 1, 135, 'b', 'Opposite meaning', 0),
(405, 1, 135, 'c', 'Spelling', 0),
(406, 1, 136, 'a', 'Sad', 0),
(407, 1, 136, 'b', 'Joyful', 1),
(408, 1, 136, 'c', 'Tired', 0),
(409, 1, 137, 'a', 'She is high up', 0),
(410, 1, 137, 'b', 'She is very happy', 1),
(411, 1, 137, 'c', 'She is dreaming', 0),
(412, 1, 138, 'a', 'read', 0),
(413, 1, 138, 'b', 'reads', 1),
(414, 1, 138, 'c', 'reading', 0),
(415, 1, 139, 'a', 'The cake was eaten by John.', 1),
(416, 1, 139, 'b', 'John eats the cake.', 0),
(417, 1, 139, 'c', 'He is eating cake.', 0),
(418, 1, 140, 'a', 'He', 0),
(419, 1, 140, 'b', 'don\'t', 1),
(420, 1, 140, 'c', 'like', 0),
(421, 1, 141, 'a', 'Noun', 0),
(422, 1, 141, 'b', 'Adjective', 0),
(423, 1, 141, 'c', 'Adverb', 1),
(424, 1, 142, 'a', 'Had gone', 1),
(425, 1, 142, 'b', 'Went', 0),
(426, 1, 142, 'c', 'Goes', 0),
(427, 1, 143, 'a', 'He slept because he was tired.', 0),
(428, 1, 143, 'b', 'He slept and she read.', 1),
(429, 1, 143, 'c', 'Sleeping is nice.', 0),
(430, 1, 144, 'a', 'She said that she is ill.', 0),
(431, 1, 144, 'b', 'She said that she was ill.', 1),
(432, 1, 144, 'c', 'She said she ill.', 0),
(433, 1, 145, 'a', 'A noun', 0),
(434, 1, 145, 'b', 'A sudden expression', 1),
(435, 1, 145, 'c', 'An adjective', 0),
(436, 1, 146, 'a', 'Read/reed', 1),
(437, 1, 146, 'b', 'Light/dark', 0),
(438, 1, 146, 'c', 'Walk/run', 0),
(439, 1, 147, 'a', 'An error', 0),
(440, 1, 147, 'b', 'Three dots to show omission', 1),
(441, 1, 147, 'c', 'A style', 0),
(442, 1, 148, 'a', 'Positive', 0),
(443, 1, 148, 'b', 'Hopeful', 0),
(444, 1, 148, 'c', 'Pessimistic', 1),
(445, 1, 149, 'a', 'A type of metaphor', 0),
(446, 1, 149, 'b', 'Contradictory words together', 1),
(447, 1, 149, 'c', 'A funny statement', 0),
(448, 1, 150, 'a', 'Simile', 0),
(449, 1, 150, 'b', 'Metaphor', 0),
(450, 1, 150, 'c', 'Personification', 1),
(451, 1, 151, 'a', 'Oxygen', 0),
(452, 1, 151, 'b', 'Sunlight', 1),
(453, 1, 151, 'c', 'Carbon monoxide', 0),
(454, 1, 152, 'a', 'Oxygen', 1),
(455, 1, 152, 'b', 'Carbon dioxide', 0),
(456, 1, 152, 'c', 'Nitrogen', 0),
(457, 1, 153, 'a', 'A plant', 0),
(458, 1, 153, 'b', 'An animal', 0),
(459, 1, 153, 'c', 'A living place', 1),
(460, 1, 154, 'a', 'Coal', 0),
(461, 1, 154, 'b', 'Oil', 0),
(462, 1, 154, 'c', 'Sunlight', 1),
(463, 1, 155, 'a', 'Clean water', 0),
(464, 1, 155, 'b', 'Industrial waste', 1),
(465, 1, 155, 'c', 'Rain', 0),
(466, 1, 156, 'a', 'Car crash', 0),
(467, 1, 156, 'b', 'Earthquake', 1),
(468, 1, 156, 'c', 'Pollution', 0),
(469, 1, 157, 'a', 'Provide shelter', 0),
(470, 1, 157, 'b', 'Produce oxygen', 0),
(471, 1, 157, 'c', 'Both', 1),
(472, 1, 158, 'a', 'Burning trash', 0),
(473, 1, 158, 'b', 'Reusing materials', 1),
(474, 1, 158, 'c', 'Throwing waste', 0),
(475, 1, 159, 'a', 'Cooling earth', 0),
(476, 1, 159, 'b', 'Earth heating up', 1),
(477, 1, 159, 'c', 'Rainfall increase', 0),
(478, 1, 160, 'a', 'Plastic', 0),
(479, 1, 160, 'b', 'Banana peel', 1),
(480, 1, 160, 'c', 'Metal can', 0),
(481, 1, 161, 'a', 'Troposphere', 0),
(482, 1, 161, 'b', 'Stratosphere', 0),
(483, 1, 161, 'c', 'Ozone layer', 1),
(484, 1, 162, 'a', 'Earth cooling', 0),
(485, 1, 162, 'b', 'Earth heating due to gases', 1),
(486, 1, 162, 'c', 'Snowfall increase', 0),
(487, 1, 163, 'a', 'CO2', 0),
(488, 1, 163, 'b', 'SO2 and NOx', 1),
(489, 1, 163, 'c', 'O2', 0),
(490, 1, 164, 'a', 'Planting trees', 0),
(491, 1, 164, 'b', 'Cutting down forests', 1),
(492, 1, 164, 'c', 'Water saving', 0),
(493, 1, 165, 'a', 'Renewable energy', 0),
(494, 1, 165, 'b', 'Non-renewable energy', 1),
(495, 1, 165, 'c', 'Freshwater', 0),
(496, 1, 166, 'a', 'Save trees', 1),
(497, 1, 166, 'b', 'Make more waste', 0),
(498, 1, 166, 'c', 'Pollute water', 0),
(499, 1, 167, 'a', 'Only animals', 0),
(500, 1, 167, 'b', 'Only plants', 0),
(501, 1, 167, 'c', 'Interaction of living & non-living things', 1),
(502, 1, 168, 'a', 'Fog', 0),
(503, 1, 168, 'b', 'Smoke and pollutants', 1),
(504, 1, 168, 'c', 'Mist', 0),
(505, 1, 169, 'a', 'Using resources wisely', 1),
(506, 1, 169, 'b', 'Using all resources', 0),
(507, 1, 169, 'c', 'Ignoring nature', 0),
(508, 1, 170, 'a', 'Coal', 0),
(509, 1, 170, 'b', 'Wind', 1),
(510, 1, 170, 'c', 'Petrol', 0),
(511, 1, 171, 'a', 'Oxygen', 0),
(512, 1, 171, 'b', 'Methane', 0),
(513, 1, 171, 'c', 'Carbon dioxide', 1),
(514, 1, 172, 'a', 'Algae overgrowth from nutrients', 1),
(515, 1, 172, 'b', 'Oxygen increase', 0),
(516, 1, 172, 'c', 'Clear water', 0),
(517, 1, 173, 'a', 'Life on other planets', 0),
(518, 1, 173, 'b', 'Variety of life forms', 1),
(519, 1, 173, 'c', 'Deforestation', 0),
(520, 1, 174, 'a', 'WHO', 0),
(521, 1, 174, 'b', 'UNESCO', 0),
(522, 1, 174, 'c', 'IPCC', 1),
(523, 1, 175, 'a', 'Increases CO2', 0),
(524, 1, 175, 'b', 'Reduces oxygen', 0),
(525, 1, 175, 'c', 'Reduces global warming', 1),
(526, 1, 176, 'a', 'Clean rivers', 0),
(527, 1, 176, 'b', 'Harm to wildlife', 1),
(528, 1, 176, 'c', 'Fertilizes soil', 0),
(529, 1, 177, 'a', 'Agriculture', 0),
(530, 1, 177, 'b', 'Transport', 0),
(531, 1, 177, 'c', 'Energy', 1),
(532, 1, 178, 'a', 'Foot size', 0),
(533, 1, 178, 'b', 'Carbon released per person', 1),
(534, 1, 178, 'c', 'Shoes worn', 0),
(535, 1, 179, 'a', 'Throwing garbage', 0),
(536, 1, 179, 'b', 'Creating waste', 0),
(537, 1, 179, 'c', 'Making fertilizer from waste', 1),
(538, 1, 180, 'a', 'Afforestation', 0),
(539, 1, 180, 'b', 'Urbanization', 1),
(540, 1, 180, 'c', 'Organic farming', 0),
(548, 1, 245, 'a', 'Paris', 1),
(549, 1, 245, 'b', 'London', 0),
(550, 1, 245, 'c', 'Berlin', 0);

-- --------------------------------------------------------

--
-- Table structure for table `mst_questions`
--

DROP TABLE IF EXISTS `mst_questions`;
CREATE TABLE `mst_questions` (
  `question_id` int NOT NULL,
  `clientid` int NOT NULL,
  `topic_id` int DEFAULT NULL,
  `categoryid` int DEFAULT NULL,
  `level_id` int DEFAULT NULL,
  `question_text` text NOT NULL,
  `questiontype` tinyint NOT NULL COMMENT '1: MCQ 2: Descriptive',
  `descriptiveanswer` text COMMENT 'Reference answer for descriptive questions.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `mst_questions`
--

INSERT INTO `mst_questions` (`question_id`, `clientid`, `topic_id`, `categoryid`, `level_id`, `question_text`, `questiontype`, `descriptiveanswer`) VALUES
(1, 1, 1, 1, 1, 'Who led the Dandi March?', 1, NULL),
(2, 1, 1, 1, 1, 'Who founded the Maurya Empire?', 1, NULL),
(3, 1, 1, 1, 1, 'Who was the first Prime Minister of India?', 1, NULL),
(4, 1, 1, 1, 1, 'In which year did India gain independence?', 1, NULL),
(5, 1, 1, 1, 1, 'What was the capital of the Gupta Empire?', 1, NULL),
(6, 1, 1, 1, 1, 'Where was the Jallianwala Bagh massacre?', 1, NULL),
(7, 1, 1, 1, 1, 'Which leader gave the slogan \'Jai Jawan Jai Kisan\'?', 1, NULL),
(8, 1, 1, 1, 1, 'Who wrote the Indian national anthem?', 1, NULL),
(9, 1, 1, 1, 1, 'Who was known as \'Iron Man of India\'?', 1, NULL),
(10, 1, 1, 1, 1, 'Which empire built the Taj Mahal?', 1, NULL),
(11, 1, 1, 1, 2, 'In which year was the Quit India Movement launched?', 1, NULL),
(12, 1, 1, 1, 2, 'Which act transferred power from East India Company to the British Crown?', 1, NULL),
(13, 1, 1, 1, 2, 'Which Mughal emperor implemented Din-i Ilahi?', 1, NULL),
(14, 1, 1, 1, 2, 'Where did the 1857 revolt start?', 1, NULL),
(15, 1, 1, 1, 2, 'What was the capital of British India before Delhi?', 1, NULL),
(16, 1, 1, 1, 2, 'Who was the founder of the Sikh Empire?', 1, NULL),
(17, 1, 1, 1, 2, 'Which king was associated with the Third Battle of Panipat?', 1, NULL),
(18, 1, 1, 1, 2, 'Who was the Viceroy during the partition of Bengal?', 1, NULL),
(19, 1, 1, 1, 2, 'Who founded the Indian National Army?', 1, NULL),
(20, 1, 1, 1, 2, 'Who introduced the Permanent Settlement in Bengal?', 1, NULL),
(21, 1, 1, 1, 3, 'Who translated the Upanishads into Persian?', 1, NULL),
(22, 1, 1, 1, 3, 'Who was the last Governor-General of independent India?', 1, NULL),
(23, 1, 1, 1, 3, 'Which Indian king defeated Alexander’s general Seleucus?', 1, NULL),
(24, 1, 1, 1, 3, 'Which dynasty is known for cave architecture in Ajanta and Ellora?', 1, NULL),
(25, 1, 1, 1, 3, 'What was the main objective of the Simon Commission?', 1, NULL),
(26, 1, 1, 1, 3, 'What is the significance of the year 1919 in Indian history?', 1, NULL),
(27, 1, 1, 1, 3, 'Which Indian freedom fighter founded \'Azad Hind Fauj\'?', 1, NULL),
(28, 1, 1, 1, 3, 'Which Congress session demanded \'Purna Swaraj\'?', 1, NULL),
(29, 1, 1, 1, 3, 'Which act allowed Indians to participate in legislative councils?', 1, NULL),
(30, 1, 1, 1, 3, 'Who composed the \'Arthashastra\'?', 1, NULL),
(31, 1, 2, 2, 1, 'Which plateau is known as the \'Deccan Plateau\'?', 1, NULL),
(32, 1, 2, 2, 1, 'Where is the Sunderbans delta located?', 1, NULL),
(33, 1, 2, 2, 1, 'Which lake is the largest freshwater lake in India?', 1, NULL),
(34, 1, 2, 2, 1, 'Which is the southernmost point of India?', 1, NULL),
(35, 1, 2, 2, 1, 'Which Indian state has the longest coastline?', 1, NULL),
(36, 1, 2, 2, 1, 'What is the capital of Rajasthan?', 1, NULL),
(37, 1, 2, 2, 1, 'Which river flows through Kolkata?', 1, NULL),
(38, 1, 2, 2, 1, 'Where is the Thar Desert located?', 1, NULL),
(39, 1, 2, 2, 1, 'Which is the highest mountain peak in India?', 1, NULL),
(40, 1, 2, 2, 1, 'Which is the longest river in India?', 1, NULL),
(41, 1, 2, 2, 2, 'Which Indian river is known as the \'Dakshina Ganga\'?', 1, NULL),
(42, 1, 2, 2, 2, 'Which river originates from Amarkantak?', 1, NULL),
(43, 1, 2, 2, 2, 'Which Indian city is located on the banks of the Mula-Mutha river?', 1, NULL),
(44, 1, 2, 2, 2, 'Which state has the Siachen Glacier?', 1, NULL),
(45, 1, 2, 2, 2, 'Which city is known as the \'Silicon Valley of India\'?', 1, NULL),
(46, 1, 2, 2, 2, 'Which is the largest state in India by area?', 1, NULL),
(47, 1, 2, 2, 2, 'Which coastal city is known for backwaters?', 1, NULL),
(48, 1, 2, 2, 2, 'Which Indian state has the highest forest cover?', 1, NULL),
(49, 1, 2, 2, 2, 'Which Indian state shares a border with Bhutan?', 1, NULL),
(50, 1, 2, 2, 2, 'Which state has the highest number of national parks?', 1, NULL),
(51, 1, 2, 2, 3, 'Which river creates the largest delta in the world?', 1, NULL),
(52, 1, 2, 2, 3, 'Which river is called the lifeline of Gujarat?', 1, NULL),
(53, 1, 2, 2, 3, 'Which pass connects India and China in Sikkim?', 1, NULL),
(54, 1, 2, 2, 3, 'Which plateau is rich in minerals in India?', 1, NULL),
(55, 1, 2, 2, 3, 'Which Indian state is known as the \'Land of Five Rivers\'?', 1, NULL),
(56, 1, 2, 2, 3, 'Where is India\'s only active volcano?', 1, NULL),
(57, 1, 2, 2, 3, 'Which city is known as the \'City of Lakes\'?', 1, NULL),
(58, 1, 2, 2, 3, 'Where is Silent Valley National Park?', 1, NULL),
(59, 1, 2, 2, 3, 'Which city receives the highest rainfall?', 1, NULL),
(60, 1, 2, 2, 3, 'Which island group lies to the west of Kerala?', 1, NULL),
(61, 1, 3, 3, 1, 'What planet is known as the Red Planet?', 1, NULL),
(62, 1, 3, 3, 1, 'Water boils at what temperature (Celsius)?', 1, NULL),
(63, 1, 3, 3, 1, 'What gas do plants absorb from the atmosphere?', 1, NULL),
(64, 1, 3, 3, 1, 'Which device is used to measure temperature?', 1, NULL),
(65, 1, 3, 3, 1, 'Which sense is associated with the tongue?', 1, NULL),
(66, 1, 3, 3, 1, 'How many legs does an insect have?', 1, NULL),
(67, 1, 3, 3, 1, 'What is H2O commonly known as?', 1, NULL),
(68, 1, 3, 3, 1, 'What part of the plant conducts photosynthesis?', 1, NULL),
(69, 1, 3, 3, 1, 'Which organ pumps blood in the human body?', 1, NULL),
(70, 1, 3, 3, 1, 'What gas do humans breathe in for survival?', 1, NULL),
(71, 1, 3, 3, 2, 'Who proposed the theory of relativity?', 1, NULL),
(72, 1, 3, 3, 2, 'Which part of the cell contains DNA?', 1, NULL),
(73, 1, 3, 3, 2, 'What is the SI unit of force?', 1, NULL),
(74, 1, 3, 3, 2, 'Which blood group is called the universal donor?', 1, NULL),
(75, 1, 3, 3, 2, 'Which vitamin is produced when exposed to sunlight?', 1, NULL),
(76, 1, 3, 3, 2, 'Which metal is liquid at room temperature?', 1, NULL),
(77, 1, 3, 3, 2, 'What is the chemical formula for common salt?', 1, NULL),
(78, 1, 3, 3, 2, 'Which part of the brain controls balance?', 1, NULL),
(79, 1, 3, 3, 2, 'What does CPU stand for?', 1, NULL),
(80, 1, 3, 3, 2, 'Who discovered penicillin?', 1, NULL),
(81, 1, 3, 3, 3, 'Which programming language is primarily used for AI research?', 1, NULL),
(82, 1, 3, 3, 3, 'What particle has a negative charge?', 1, NULL),
(83, 1, 3, 3, 3, 'What phenomenon explains the bending of light?', 1, NULL),
(84, 1, 3, 3, 3, 'What is the powerhouse of the cell?', 1, NULL),
(85, 1, 3, 3, 3, 'Which law relates to force and acceleration?', 1, NULL),
(86, 1, 3, 3, 3, 'Which process converts light energy into chemical energy?', 1, NULL),
(87, 1, 3, 3, 3, 'Which element is used in nuclear reactors?', 1, NULL),
(88, 1, 3, 3, 3, 'Which planet has the strongest gravity?', 1, NULL),
(89, 1, 3, 3, 3, 'What is the speed of light?', 1, NULL),
(90, 1, 3, 3, 3, 'Which scientist developed the polio vaccine?', 1, NULL),
(91, 1, 4, 4, 1, 'What is 2 + 2?', 1, NULL),
(92, 1, 4, 5, 1, 'Which number is even?', 1, NULL),
(93, 1, 4, 6, 1, 'What is 10 - 7?', 1, NULL),
(94, 1, 4, 4, 1, 'Which shape has 3 sides?', 1, NULL),
(95, 1, 4, 5, 1, 'What is 5 x 1?', 1, NULL),
(96, 1, 4, 6, 1, 'What is half of 10?', 1, NULL),
(97, 1, 4, 4, 1, 'Which is the smallest?', 1, NULL),
(98, 1, 4, 5, 1, 'What is the square of 3?', 1, NULL),
(99, 1, 4, 6, 1, 'What comes after 7?', 1, NULL),
(100, 1, 4, 4, 1, 'What is 12 divided by 4?', 1, NULL),
(101, 1, 4, 4, 2, 'What is the value of x in 2x = 10?', 1, NULL),
(102, 1, 4, 5, 2, 'What is 15% of 100?', 1, NULL),
(103, 1, 4, 6, 2, 'How many sides does a hexagon have?', 1, NULL),
(104, 1, 4, 4, 2, 'What is 8 squared?', 1, NULL),
(105, 1, 4, 5, 2, 'Solve: 3x + 2 = 11', 1, NULL),
(106, 1, 4, 6, 2, 'Find the median of [2, 5, 7]', 1, NULL),
(107, 1, 4, 4, 2, 'What is the next prime after 7?', 1, NULL),
(108, 1, 4, 5, 2, 'Which is a multiple of 9?', 1, NULL),
(109, 1, 4, 6, 2, 'Area of square with side 4?', 1, NULL),
(110, 1, 4, 4, 2, 'Simplify: 3(2+4)', 1, NULL),
(111, 1, 4, 4, 3, 'Solve: x^2 = 49', 1, NULL),
(112, 1, 4, 5, 3, 'Find the derivative of x^2', 1, NULL),
(113, 1, 4, 6, 3, 'What is the integral of 2x dx?', 1, NULL),
(114, 1, 4, 4, 3, 'What is the limit of 1/x as x→∞?', 1, NULL),
(115, 1, 4, 5, 3, 'Solve: log(x) = 2', 1, NULL),
(116, 1, 4, 6, 3, 'Find the angle in a semicircle', 1, NULL),
(117, 1, 4, 4, 3, 'What is the derivative of sin(x)?', 1, NULL),
(118, 1, 4, 5, 3, 'What is sin(90°)?', 1, NULL),
(119, 1, 4, 6, 3, 'If f(x) = x^3, f’(x) = ?', 1, NULL),
(120, 1, 4, 4, 3, 'What is 2^5?', 1, NULL),
(121, 1, 5, 7, 1, 'Which word is a noun?', 1, NULL),
(122, 1, 5, 8, 1, 'Which sentence is correct?', 1, NULL),
(123, 1, 5, 9, 1, 'Choose the synonym of \'Big\'', 1, NULL),
(124, 1, 5, 7, 1, 'Identify the verb in the sentence: \'He runs fast.\'', 1, NULL),
(125, 1, 5, 8, 1, 'What is the opposite of \'Cold\'?', 1, NULL),
(126, 1, 5, 9, 1, 'Choose the correct article: ___ apple', 1, NULL),
(127, 1, 5, 7, 1, 'What is a pronoun?', 1, NULL),
(128, 1, 5, 8, 1, 'What does \'bark\' mean in \'The dog will bark\'?', 1, NULL),
(129, 1, 5, 9, 1, 'Choose the correct plural: \'Child\'', 1, NULL),
(130, 1, 5, 7, 1, 'Select the correct past tense: \'eat\'', 1, NULL),
(131, 1, 5, 7, 2, 'Identify the adjective: \'The red car is fast.\'', 1, NULL),
(132, 1, 5, 8, 2, 'Which is a preposition?', 1, NULL),
(133, 1, 5, 9, 2, 'Which word is an adverb?', 1, NULL),
(134, 1, 5, 7, 2, 'What is a conjunction?', 1, NULL),
(135, 1, 5, 8, 2, 'What does \'synonym\' mean?', 1, NULL),
(136, 1, 5, 9, 2, 'Which word means the same as \'happy\'?', 1, NULL),
(137, 1, 5, 7, 2, 'What does \'she is on cloud nine\' mean?', 1, NULL),
(138, 1, 5, 8, 2, 'Choose the correct form: \'He ___ a book.\'', 1, NULL),
(139, 1, 5, 9, 2, 'Which sentence is in passive voice?', 1, NULL),
(140, 1, 5, 7, 2, 'Find the error: \'He don\'t like tea.\'', 1, NULL),
(141, 1, 5, 7, 3, 'Identify the clause type: \'Although he was tired, he worked.\'', 1, NULL),
(142, 1, 5, 8, 3, 'What is the past perfect of \'go\'?', 1, NULL),
(143, 1, 5, 9, 3, 'Which is a compound sentence?', 1, NULL),
(144, 1, 5, 7, 3, 'Choose the correct reported speech: \'She said, “I am ill.”\'', 1, NULL),
(145, 1, 5, 8, 3, 'What is an interjection?', 1, NULL),
(146, 1, 5, 9, 3, 'Which is a homophone?', 1, NULL),
(147, 1, 5, 7, 3, 'What does \'ellipsis\' mean in writing?', 1, NULL),
(148, 1, 5, 8, 3, 'What’s the antonym of \'optimistic\'?', 1, NULL),
(149, 1, 5, 9, 3, 'What is an oxymoron?', 1, NULL),
(150, 1, 5, 7, 3, 'Identify the figure of speech: \'The wind whispered.\'', 1, NULL),
(151, 1, 6, 10, 1, 'What do plants need for photosynthesis?', 1, NULL),
(152, 1, 6, 11, 1, 'Which gas do humans breathe in?', 1, NULL),
(153, 1, 6, 12, 1, 'What is a habitat?', 1, NULL),
(154, 1, 6, 10, 1, 'Which of these is a renewable resource?', 1, NULL),
(155, 1, 6, 11, 1, 'What causes water pollution?', 1, NULL),
(156, 1, 6, 12, 1, 'Which is a natural disaster?', 1, NULL),
(157, 1, 6, 10, 1, 'Why are trees important?', 1, NULL),
(158, 1, 6, 11, 1, 'What is recycling?', 1, NULL),
(159, 1, 6, 12, 1, 'What is global warming?', 1, NULL),
(160, 1, 6, 10, 1, 'Which is a biodegradable item?', 1, NULL),
(161, 1, 6, 10, 2, 'Which layer protects Earth from UV rays?', 1, NULL),
(162, 1, 6, 11, 2, 'What is the greenhouse effect?', 1, NULL),
(163, 1, 6, 12, 2, 'Which causes acid rain?', 1, NULL),
(164, 1, 6, 10, 2, 'What is deforestation?', 1, NULL),
(165, 1, 6, 11, 2, 'What are fossil fuels?', 1, NULL),
(166, 1, 6, 12, 2, 'Why recycle paper?', 1, NULL),
(167, 1, 6, 10, 2, 'What is an ecosystem?', 1, NULL),
(168, 1, 6, 11, 2, 'What causes smog?', 1, NULL),
(169, 1, 6, 12, 2, 'What is sustainable development?', 1, NULL),
(170, 1, 6, 10, 2, 'Which is a clean energy source?', 1, NULL),
(171, 1, 6, 10, 3, 'Which gas is the main cause of global warming?', 1, NULL),
(172, 1, 6, 11, 3, 'What is eutrophication?', 1, NULL),
(173, 1, 6, 12, 3, 'What is biodiversity?', 1, NULL),
(174, 1, 6, 10, 3, 'Which organization monitors climate change?', 1, NULL),
(175, 1, 6, 11, 3, 'How does afforestation help?', 1, NULL),
(176, 1, 6, 12, 3, 'What is the effect of plastic pollution?', 1, NULL),
(177, 1, 6, 10, 3, 'Which sector emits most greenhouse gases?', 1, NULL),
(178, 1, 6, 11, 3, 'What does carbon footprint mean?', 1, NULL),
(179, 1, 6, 12, 3, 'What is composting?', 1, NULL),
(180, 1, 6, 10, 3, 'Which human activity destroys forests?', 1, NULL),
(181, 1, 1, 1, 1, 'Who was the first Prime Minister of independent India?', 2, 'Jawaharlal Nehru was the first Prime Minister of independent India, serving from 1947.'),
(182, 1, 1, 1, 1, 'What was the main objective of the Quit India Movement?', 2, 'The Quit India Movement demanded an end to British rule in India during World War II.'),
(183, 1, 1, 1, 2, 'What was the significance of the Battle of Plassey?', 2, 'The Battle of Plassey in 1757 marked the beginning of British political dominance in India.'),
(184, 1, 1, 1, 2, 'What was the role of Subhash Chandra Bose in India\'s freedom struggle?', 2, 'Subhash Chandra Bose led the Indian National Army and inspired many to fight the British.'),
(185, 1, 1, 1, 3, 'How did the British economic policies affect Indian agriculture?', 2, 'British policies forced farmers to grow cash crops, leading to poverty and famines.'),
(186, 1, 1, 1, 1, 'What is the importance of 26th January in Indian history?', 2, '26th January is celebrated as Republic Day when the Indian Constitution came into effect.'),
(187, 1, 1, 1, 2, 'What caused the Revolt of 1857?', 2, 'The revolt was triggered by political, economic, and military grievances against the British.'),
(188, 1, 1, 1, 3, 'Describe the role of Mahatma Gandhi in India’s independence movement.', 2, 'Gandhi led mass movements like Non-Cooperation and Civil Disobedience based on nonviolence.'),
(189, 1, 1, 1, 2, 'What was the Partition of Bengal and why was it controversial?', 2, 'The 1905 Partition aimed to divide Bengal on religious lines, leading to mass protests.'),
(190, 1, 1, 1, 3, 'How did British education policies influence Indian society?', 2, 'British education created a class of English-educated Indians, fostering nationalism but also alienating traditional systems.'),
(191, 1, 2, 2, 1, 'What is the equator?', 2, 'The equator is an imaginary line around the middle of the Earth that divides it into Northern and Southern Hemispheres. It is located at 0° latitude.'),
(192, 1, 2, 2, 1, 'What is a continent?', 2, 'A continent is a large continuous landmass on Earth. There are seven continents including Asia, Africa, and Europe.'),
(193, 1, 2, 2, 2, 'Why are some regions hotter than others?', 2, 'Regions near the equator receive direct sunlight year-round, making them hotter than areas closer to the poles.'),
(194, 1, 2, 2, 2, 'What are the main types of climates found on Earth?', 2, 'Earth has several climates like tropical, temperate, polar, arid, and Mediterranean, based on temperature and rainfall.'),
(195, 1, 2, 2, 3, 'Explain the water cycle.', 2, 'The water cycle includes evaporation, condensation, precipitation, and collection. It circulates water through the environment.'),
(196, 1, 2, 2, 1, 'What is a desert?', 2, 'A desert is a dry area that receives very little rainfall. It often has hot days, cold nights, and scarce vegetation.'),
(197, 1, 2, 2, 2, 'What are tectonic plates?', 2, 'Tectonic plates are large pieces of Earth\'s crust that float on the mantle. Their movements cause earthquakes and volcanic activity.'),
(198, 1, 2, 2, 3, 'How do mountains affect climate?', 2, 'Mountains affect climate by blocking wind and causing rainfall on one side (windward) and dry conditions on the other (leeward).'),
(199, 1, 2, 2, 2, 'Why are rivers important to human settlements?', 2, 'Rivers provide water, support agriculture, transportation, and have historically attracted early human civilizations.'),
(200, 1, 2, 2, 3, 'What is deforestation and its impact on the environment?', 2, 'Deforestation is the clearing of forests for human use. It causes loss of biodiversity, soil erosion, and contributes to climate change.'),
(201, 1, 3, 3, 1, 'What is the Internet?', 2, 'The Internet is a global network that connects millions of computers to share information and resources.'),
(202, 1, 3, 3, 1, 'What is a computer?', 2, 'A computer is an electronic device used to store, process, and retrieve data efficiently.'),
(203, 1, 3, 3, 2, 'How does a mobile phone work?', 2, 'A mobile phone works by connecting to a network of towers and satellites to send and receive data and calls.'),
(204, 1, 3, 3, 2, 'What is artificial intelligence (AI)?', 2, 'AI refers to the simulation of human intelligence in machines that can perform tasks like learning and decision-making.'),
(205, 1, 3, 3, 3, 'Explain the importance of cybersecurity.', 2, 'Cybersecurity protects computer systems and data from digital attacks, theft, and damage, ensuring privacy and safety online.'),
(206, 1, 3, 3, 1, 'What is electricity?', 2, 'Electricity is a form of energy resulting from the movement of electrons. It powers many devices we use daily.'),
(207, 1, 3, 3, 2, 'How does a satellite help in communication?', 2, 'Satellites transmit signals for television, GPS, and the Internet, enabling long-distance communication.'),
(208, 1, 3, 3, 3, 'Describe the impact of social media on society.', 2, 'Social media influences communication, information sharing, and public opinion, but also raises issues like privacy and misinformation.'),
(209, 1, 3, 3, 2, 'What is renewable energy?', 2, 'Renewable energy comes from natural sources like sunlight, wind, and water, and is sustainable over time.'),
(210, 1, 3, 3, 3, 'How has technology improved education?', 2, 'Technology has made education more accessible and interactive through online classes, digital tools, and learning platforms.'),
(211, 1, 4, 5, 1, 'What is the difference between even and odd numbers?', 2, 'Even numbers are divisible by 2, while odd numbers leave a remainder of 1 when divided by 2.'),
(212, 1, 4, 5, 2, 'Explain the concept of percentages.', 2, 'Percentages represent a fraction of 100 and are used to compare proportions or changes.'),
(213, 1, 4, 5, 3, 'How do you calculate compound interest?', 2, 'Compound interest is calculated on the principal and also on the interest accumulated over time. The formula is A = P(1 + r/n)^nt.'),
(214, 1, 4, 6, 1, 'What is a right angle?', 2, 'A right angle measures exactly 90 degrees and is commonly seen in squares and rectangles.'),
(215, 1, 4, 6, 2, 'How do you calculate the area of a triangle?', 2, 'The area of a triangle is ½ × base × height.'),
(216, 1, 4, 6, 3, 'Explain the Pythagorean theorem.', 2, 'The Pythagorean theorem states that in a right triangle, a² + b² = c², where c is the hypotenuse.'),
(217, 1, 4, 4, 1, 'What is a variable in algebra?', 2, 'A variable is a symbol, often a letter, used to represent an unknown number in expressions and equations.'),
(218, 1, 4, 4, 2, 'What is the difference between an equation and an expression?', 2, 'An expression is a mathematical phrase without an equals sign, while an equation includes equality.'),
(219, 1, 4, 6, 3, 'How do you solve a system of linear equations?', 2, 'A system of linear equations is solved using substitution, elimination, or matrix methods to find common solutions.'),
(220, 1, 4, 4, 2, 'What is the significance of the order of operations in math?', 2, 'The order of operations ensures consistent results in calculations: Parentheses, Exponents, Multiplication/Division, Addition/Subtraction (PEMDAS).'),
(221, 1, 5, 7, 1, 'What is the difference between a noun and a pronoun?', 2, 'A noun names a person, place, or thing, while a pronoun replaces a noun to avoid repetition.'),
(222, 1, 5, 7, 2, 'Explain the use of the past perfect tense.', 2, 'The past perfect tense is used to describe an action that was completed before another past action.'),
(223, 1, 5, 7, 3, 'How do subject-verb agreement rules work in complex sentences?', 2, 'In complex sentences, the verb must agree with the subject of the main clause, not a noun in a subordinate clause.'),
(224, 1, 5, 8, 1, 'What is a synonym? Give an example.', 2, 'A synonym is a word that has a similar meaning to another word. Example: Happy and Joyful.'),
(225, 1, 5, 8, 2, 'Explain the difference between denotation and connotation.', 2, 'Denotation is the literal meaning of a word, while connotation refers to its emotional or cultural associations.'),
(226, 1, 5, 8, 3, 'How can context help you determine the meaning of an unfamiliar word?', 2, 'By analyzing surrounding words and sentences, context provides clues to infer the meaning of an unknown word.'),
(227, 1, 5, 9, 1, 'What is the main idea of a paragraph?', 2, 'The main idea is the central thought or message the author wants to convey in a paragraph.'),
(228, 1, 5, 9, 2, 'Why is it important to identify the author’s purpose in a passage?', 2, 'Understanding the author’s purpose helps in interpreting the tone and intention of the passage.'),
(229, 1, 5, 9, 2, 'How can you identify bias in a written text?', 2, 'Bias can be identified through word choice, tone, and the omission or emphasis of certain facts.'),
(230, 1, 5, 9, 3, 'What strategies can help improve reading comprehension for complex texts?', 2, 'Strategies like skimming, summarizing, and asking questions while reading can enhance comprehension of difficult texts.'),
(231, 1, 6, 10, 1, 'What is an ecosystem?', 2, 'An ecosystem is a community of living organisms interacting with each other and their physical environment.'),
(232, 1, 6, 10, 2, 'Explain the importance of biodiversity in an ecosystem.', 2, 'Biodiversity ensures the stability and resilience of ecosystems by supporting food chains and ecological balance.'),
(233, 1, 6, 10, 3, 'How do human activities impact ecosystems?', 2, 'Human activities like deforestation, pollution, and urbanization disrupt natural habitats and reduce biodiversity.'),
(234, 1, 6, 11, 1, 'What is climate change?', 2, 'Climate change refers to long-term shifts in temperatures and weather patterns, often caused by human activities.'),
(235, 1, 6, 11, 2, 'How does global warming affect sea levels?', 2, 'Global warming causes glaciers and ice caps to melt, leading to rising sea levels and coastal flooding.'),
(236, 1, 6, 11, 3, 'What are greenhouse gases and their role in climate change?', 2, 'Greenhouse gases trap heat in the atmosphere, causing the Earth’s temperature to rise and contributing to climate change.'),
(237, 1, 6, 12, 1, 'What is air pollution?', 2, 'Air pollution is the presence of harmful substances in the air, such as smoke, chemicals, and particulate matter.'),
(238, 1, 6, 12, 2, 'Describe the effects of water pollution on aquatic life.', 2, 'Water pollution reduces oxygen levels, spreads disease, and harms or kills aquatic organisms.'),
(239, 1, 6, 12, 2, 'What are the major causes of soil pollution?', 2, 'Soil pollution is caused by chemical waste, pesticides, and industrial discharge contaminating the soil.'),
(240, 1, 6, 12, 3, 'How can pollution be reduced through sustainable practices?', 2, 'Sustainable practices like recycling, using clean energy, and reducing plastic use can significantly reduce pollution.'),
(245, 1, 1, 1, 1, 'What is the capital of France?', 1, ''),
(246, 1, 6, 10, 1, 'Explain the process of photosynthesis.', 2, 'Photosynthesis is the process...');

-- --------------------------------------------------------

--
-- Table structure for table `mst_topics`
--

DROP TABLE IF EXISTS `mst_topics`;
CREATE TABLE `mst_topics` (
  `topic_id` int NOT NULL,
  `clientid` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `mst_topics`
--

INSERT INTO `mst_topics` (`topic_id`, `clientid`, `name`, `description`, `image`) VALUES
(1, 1, 'History', 'Test your knowledge of history and discover fascinating facts from the past!', '20250529160523.png'),
(2, 1, 'Geography', 'Explore the world and test your knowledge of geography with our fun and challenging quiz!', 'geography.jpg'),
(3, 1, 'Science & Technology', 'Discover amazing facts and test your knowledge of science and technology with our interactive quiz!', 'science_technology.jpg'),
(4, 1, 'Mathematics', 'Covers fundamental math skills like algebra and arithmetic.', 'math.jpg'),
(5, 1, 'English', 'Focuses on grammar, vocabulary, comprehension, and writing.', 'english.jpg'),
(6, 1, 'Environmental Science', 'Learn about ecosystems, climate, pollution, and sustainability.', 'env.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `trn_answers`
--

DROP TABLE IF EXISTS `trn_answers`;
CREATE TABLE `trn_answers` (
  `answerid` int NOT NULL,
  `userid` int NOT NULL,
  `attemptid` int NOT NULL,
  `topicid` int NOT NULL,
  `questiontype` tinyint NOT NULL COMMENT '1: MCQ 2: Descriptive',
  `questionid` int NOT NULL,
  `optionid` int DEFAULT NULL,
  `iscorrect` tinyint(1) DEFAULT NULL,
  `descriptiveanswer` text,
  `score` float DEFAULT NULL COMMENT 'Scale 10',
  `createdat` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `trn_answers`
--

INSERT INTO `trn_answers` (`answerid`, `userid`, `attemptid`, `topicid`, `questiontype`, `questionid`, `optionid`, `iscorrect`, `descriptiveanswer`, `score`, `createdat`) VALUES
(1, 1, 1, 1, 1, 20, 58, 1, NULL, 10, '2025-05-20 11:31:11'),
(2, 1, 1, 1, 1, 15, 44, 1, NULL, 10, '2025-05-20 11:31:14'),
(3, 1, 1, 1, 1, 17, 50, 1, NULL, 10, '2025-05-20 11:31:19'),
(4, 1, 1, 1, 1, 30, 88, 1, NULL, 10, '2025-05-20 11:31:28'),
(5, 1, 1, 1, 1, 26, 77, 1, NULL, 10, '2025-05-20 11:31:38'),
(6, 1, 1, 1, 1, 24, 72, 1, NULL, 10, '2025-05-20 11:31:49'),
(7, 1, 1, 1, 1, 21, 62, 1, NULL, 10, '2025-05-20 11:31:58'),
(8, 1, 1, 1, 1, 28, 83, 0, NULL, NULL, '2025-05-20 11:32:05'),
(9, 1, 1, 1, 1, 22, 65, 0, NULL, NULL, '2025-05-20 11:32:12'),
(10, 1, 1, 1, 1, 11, 32, 1, NULL, 10, '2025-05-20 11:32:16'),
(11, 1, 2, 1, 1, 14, 40, 0, NULL, NULL, '2025-05-20 11:41:47'),
(12, 1, 2, 1, 1, 11, 31, 0, NULL, NULL, '2025-05-20 11:41:49'),
(13, 1, 2, 1, 1, 18, 53, 0, NULL, NULL, '2025-05-20 11:41:51'),
(14, 1, 2, 1, 1, 4, 10, 0, NULL, NULL, '2025-05-20 11:41:53'),
(15, 1, 2, 1, 1, 6, 17, 1, NULL, 10, '2025-05-20 11:41:55'),
(16, 1, 2, 1, 1, 8, 23, 1, NULL, 10, '2025-05-20 11:41:58'),
(17, 1, 2, 1, 1, 15, 45, 0, NULL, NULL, '2025-05-20 11:42:00'),
(18, 1, 2, 1, 1, 12, 35, 1, NULL, 10, '2025-05-20 11:42:03'),
(19, 1, 2, 1, 1, 20, 59, 0, NULL, NULL, '2025-05-20 11:42:08'),
(20, 1, 2, 1, 1, 1, 2, 1, NULL, 10, '2025-05-20 11:42:22'),
(21, 1, 3, 1, 1, 12, 34, 0, NULL, NULL, '2025-05-20 11:43:02'),
(22, 1, 3, 1, 1, 16, 47, 1, NULL, 10, '2025-05-20 11:43:05'),
(23, 1, 3, 1, 1, 14, 41, 1, NULL, 10, '2025-05-20 11:43:10'),
(24, 1, 3, 1, 1, 30, 89, 0, NULL, NULL, '2025-05-20 11:43:13'),
(25, 1, 3, 1, 1, 24, 72, 1, NULL, 10, '2025-05-20 11:43:16'),
(26, 1, 3, 1, 1, 28, 83, 0, NULL, NULL, '2025-05-20 11:43:18'),
(27, 1, 3, 1, 1, 20, 60, 0, NULL, NULL, '2025-05-20 11:43:21'),
(28, 1, 3, 1, 1, 19, 56, 1, NULL, 10, '2025-05-20 11:43:23'),
(29, 1, 3, 1, 1, 18, 54, 0, NULL, NULL, '2025-05-20 11:43:28'),
(30, 1, 3, 1, 1, 7, 20, 1, NULL, 10, '2025-05-20 11:43:33'),
(31, 1, 4, 2, 1, 49, 146, 0, NULL, NULL, '2025-05-20 11:44:17'),
(32, 1, 4, 2, 1, 44, 130, 1, NULL, 10, '2025-05-20 11:44:20'),
(33, 1, 4, 2, 1, 46, 137, 0, NULL, NULL, '2025-05-20 11:44:23'),
(34, 1, 4, 2, 1, 36, 137, 0, NULL, NULL, '2025-05-20 11:44:25'),
(35, 1, 4, 2, 1, 32, 137, 0, NULL, NULL, '2025-05-20 11:44:34'),
(36, 1, 4, 2, 1, 34, 137, 0, NULL, NULL, '2025-05-20 11:44:51'),
(37, 1, 4, 2, 1, 33, 137, 0, NULL, NULL, '2025-05-20 11:45:06'),
(38, 1, 4, 2, 1, 37, 111, 0, NULL, NULL, '2025-05-20 11:45:18'),
(39, 1, 4, 2, 1, 39, 117, 0, NULL, NULL, '2025-05-20 11:45:22'),
(40, 1, 4, 2, 1, 31, 92, 0, NULL, NULL, '2025-05-20 11:45:25'),
(41, 1, 5, 2, 1, 38, 112, 0, NULL, NULL, '2025-05-20 11:48:21'),
(42, 1, 5, 2, 1, 35, 104, 1, NULL, 10, '2025-05-20 11:48:26'),
(43, 1, 5, 2, 1, 39, 115, 1, NULL, 10, '2025-05-20 11:48:28'),
(44, 1, 5, 2, 1, 46, 137, 0, NULL, NULL, '2025-05-20 11:48:30'),
(45, 1, 5, 2, 1, 47, 139, 0, NULL, NULL, '2025-05-20 11:48:32'),
(46, 1, 5, 2, 1, 45, 134, 1, NULL, 10, '2025-05-20 11:48:34'),
(47, 1, 5, 2, 1, 36, 108, 0, NULL, NULL, '2025-05-20 11:48:36'),
(48, 1, 5, 2, 1, 37, 110, 1, NULL, 10, '2025-05-20 11:48:39'),
(49, 1, 5, 2, 1, 34, 100, 0, NULL, NULL, '2025-05-20 11:48:41'),
(50, 1, 5, 2, 1, 40, 119, 0, NULL, NULL, '2025-05-20 11:48:43'),
(51, 1, 6, 2, 1, 39, 115, 1, NULL, 10, '2025-05-20 11:53:16'),
(52, 1, 6, 2, 1, 34, 100, 0, NULL, NULL, '2025-05-20 11:53:19'),
(53, 1, 6, 2, 1, 33, 97, 0, NULL, NULL, '2025-05-20 11:53:21'),
(54, 1, 6, 2, 1, 35, 103, 0, NULL, NULL, '2025-05-20 11:53:23'),
(55, 1, 6, 2, 1, 40, 118, 0, NULL, NULL, '2025-05-20 11:53:25'),
(56, 1, 6, 2, 1, 32, 94, 0, NULL, NULL, '2025-05-20 11:53:27'),
(57, 1, 6, 2, 1, 37, 109, 0, NULL, NULL, '2025-05-20 11:53:30'),
(58, 1, 6, 2, 1, 38, 112, 0, NULL, NULL, '2025-05-20 11:53:32'),
(59, 1, 6, 2, 1, 36, 106, 1, NULL, 10, '2025-05-20 11:53:34'),
(60, 1, 6, 2, 1, 31, 91, 0, NULL, NULL, '2025-05-20 11:53:37'),
(61, 1, 7, 3, 1, 75, 225, 1, NULL, 10, '2025-05-20 11:56:18'),
(62, 1, 7, 3, 1, 74, 220, 1, NULL, 10, '2025-05-20 11:56:22'),
(63, 1, 7, 3, 1, 72, 215, 1, NULL, 10, '2025-05-20 11:56:29'),
(64, 1, 7, 3, 1, 89, 265, 1, NULL, 10, '2025-05-20 11:56:32'),
(65, 1, 7, 3, 1, 86, 257, 1, NULL, 10, '2025-05-20 11:56:36'),
(66, 1, 7, 3, 1, 87, 259, 1, NULL, 10, '2025-05-20 11:56:43'),
(67, 1, 7, 3, 1, 84, 251, 1, NULL, 10, '2025-05-20 11:56:47'),
(68, 1, 7, 3, 1, 90, 268, 0, NULL, NULL, '2025-05-20 11:56:52'),
(69, 1, 7, 3, 1, 82, 245, 1, NULL, 10, '2025-05-20 11:56:56'),
(70, 1, 7, 3, 1, 85, 253, 0, NULL, NULL, '2025-05-20 11:57:06'),
(71, 1, 8, 3, 1, 83, 248, 0, NULL, NULL, '2025-05-20 12:41:16'),
(72, 1, 8, 3, 1, 90, 269, 1, NULL, 10, '2025-05-20 12:41:18'),
(73, 1, 8, 3, 1, 82, 245, 1, NULL, 10, '2025-05-20 12:41:20'),
(74, 1, 8, 3, 1, 81, 242, 1, NULL, 10, '2025-05-20 12:41:23'),
(75, 1, 8, 3, 1, 84, 251, 1, NULL, 10, '2025-05-20 12:41:24'),
(76, 1, 8, 3, 1, 89, 266, 0, NULL, NULL, '2025-05-20 12:41:26'),
(77, 1, 8, 3, 1, 85, 254, 1, NULL, 10, '2025-05-20 12:41:29'),
(78, 1, 8, 3, 1, 88, 263, 0, NULL, NULL, '2025-05-20 12:41:31'),
(79, 1, 8, 3, 1, 86, 257, 1, NULL, 10, '2025-05-20 12:41:33'),
(80, 1, 8, 3, 1, 87, 260, 0, NULL, NULL, '2025-05-20 12:41:35'),
(81, 1, 9, 3, 1, 87, 261, 0, NULL, NULL, '2025-05-20 12:41:51'),
(82, 1, 9, 3, 1, 84, 252, 0, NULL, NULL, '2025-05-20 12:41:55'),
(83, 1, 9, 3, 1, 89, 267, 0, NULL, NULL, '2025-05-20 12:41:58'),
(84, 1, 9, 3, 1, 76, 226, 0, NULL, NULL, '2025-05-20 12:42:03'),
(85, 1, 9, 3, 1, 80, 238, 1, NULL, 10, '2025-05-20 12:42:06'),
(86, 1, 9, 3, 1, 73, 218, 0, NULL, NULL, '2025-05-20 12:42:11'),
(87, 1, 9, 3, 1, 67, 199, 0, NULL, NULL, '2025-05-20 12:42:16'),
(88, 1, 9, 3, 1, 68, 202, 0, NULL, NULL, '2025-05-20 12:42:19'),
(89, 1, 9, 3, 1, 62, 184, 0, NULL, NULL, '2025-05-20 12:42:21'),
(90, 1, 9, 3, 1, 63, 187, 0, NULL, NULL, '2025-05-20 12:42:28'),
(91, 1, 10, 1, 1, 19, 56, 1, NULL, 10, '2025-05-20 12:57:11'),
(92, 1, 10, 1, 1, 18, 52, 1, NULL, 10, '2025-05-20 12:57:14'),
(93, 1, 10, 1, 1, 20, 58, 1, NULL, 10, '2025-05-20 12:57:18'),
(94, 1, 10, 1, 1, 30, 89, 0, NULL, NULL, '2025-05-20 12:57:21'),
(95, 1, 10, 1, 1, 26, 76, 0, NULL, NULL, '2025-05-20 12:57:23'),
(96, 1, 10, 1, 1, 24, 71, 0, NULL, NULL, '2025-05-20 12:57:26'),
(97, 1, 10, 1, 1, 14, 40, 0, NULL, NULL, '2025-05-20 12:57:28'),
(98, 1, 10, 1, 1, 13, 37, 1, NULL, 10, '2025-05-20 12:57:30'),
(99, 1, 10, 1, 1, 17, 49, 0, NULL, NULL, '2025-05-20 12:57:33'),
(100, 1, 10, 1, 1, 10, 29, 0, NULL, NULL, '2025-05-20 12:57:36'),
(101, 1, 13, 1, 1, 18, 52, 1, NULL, 10, '2025-05-20 13:46:04'),
(102, 1, 13, 1, 1, 16, 46, 0, NULL, NULL, '2025-05-20 13:46:05'),
(103, 1, 13, 1, 1, 19, 55, 0, NULL, NULL, '2025-05-20 13:46:07'),
(104, 1, 13, 1, 1, 8, 22, 0, NULL, NULL, '2025-05-20 13:46:09'),
(105, 1, 13, 1, 1, 4, 10, 0, NULL, NULL, '2025-05-20 13:46:12'),
(106, 1, 13, 1, 1, 10, 28, 1, NULL, 10, '2025-05-20 13:46:14'),
(107, 1, 13, 1, 1, 5, 13, 1, NULL, 10, '2025-05-20 13:46:16'),
(108, 1, 13, 1, 1, 3, 7, 1, NULL, 10, '2025-05-20 13:46:18'),
(109, 1, 13, 1, 1, 9, 25, 0, NULL, NULL, '2025-05-20 13:46:20'),
(110, 1, 13, 1, 1, 11, 31, 0, NULL, NULL, '2025-05-20 13:46:22'),
(111, 1, 15, 1, 1, 12, 34, 0, NULL, NULL, '2025-05-20 14:01:26'),
(112, 1, 15, 1, 1, 20, 58, 1, NULL, 10, '2025-05-20 14:01:29'),
(113, 1, 15, 1, 1, 18, 52, 1, NULL, 10, '2025-05-20 14:01:32'),
(114, 1, 15, 1, 1, 26, 76, 0, NULL, NULL, '2025-05-20 14:01:34'),
(115, 1, 15, 1, 1, 30, 88, 1, NULL, 10, '2025-05-20 14:01:37'),
(116, 1, 15, 1, 1, 27, 79, 0, NULL, NULL, '2025-05-20 14:01:39'),
(117, 1, 15, 1, 1, 19, 55, 0, NULL, NULL, '2025-05-20 14:01:42'),
(118, 1, 15, 1, 1, 16, 46, 0, NULL, NULL, '2025-05-20 14:01:44'),
(119, 1, 15, 1, 1, 14, 40, 0, NULL, NULL, '2025-05-20 14:01:47'),
(120, 1, 15, 1, 1, 1, 1, 0, NULL, NULL, '2025-05-20 14:01:54'),
(121, 1, 16, 1, 1, 17, 49, 0, NULL, NULL, '2025-05-20 14:02:21'),
(122, 1, 16, 1, 1, 20, 58, 1, NULL, 10, '2025-05-20 14:02:23'),
(123, 1, 16, 1, 1, 19, 55, 0, NULL, NULL, '2025-05-20 14:02:25'),
(124, 1, 16, 1, 1, 3, 7, 1, NULL, 10, '2025-05-20 14:02:28'),
(125, 1, 16, 1, 1, 6, 16, 0, NULL, NULL, '2025-05-20 14:02:30'),
(126, 1, 16, 1, 1, 7, 19, 0, NULL, NULL, '2025-05-20 14:02:32'),
(127, 1, 16, 1, 1, 9, 25, 0, NULL, NULL, '2025-05-20 14:02:34'),
(128, 1, 16, 1, 1, 4, 10, 0, NULL, NULL, '2025-05-20 14:02:37'),
(129, 1, 16, 1, 1, 5, 13, 1, NULL, 10, '2025-05-20 14:02:39'),
(130, 1, 16, 1, 1, 8, 22, 0, NULL, NULL, '2025-05-20 14:02:43'),
(131, 1, 17, 3, 1, 78, 232, 0, NULL, NULL, '2025-05-21 05:25:16'),
(132, 1, 17, 3, 1, 75, 225, 1, NULL, 10, '2025-05-21 05:25:22'),
(133, 1, 17, 3, 1, 80, 238, 1, NULL, 10, '2025-05-21 05:25:26'),
(134, 1, 17, 3, 1, 87, 259, 1, NULL, 10, '2025-05-21 05:25:30'),
(135, 1, 17, 3, 1, 90, 270, 0, NULL, NULL, '2025-05-21 05:25:39'),
(136, 1, 17, 3, 1, 86, 257, 1, NULL, 10, '2025-05-21 05:25:46'),
(137, 1, 17, 3, 1, 89, 265, 1, NULL, 10, '2025-05-21 05:25:49'),
(138, 1, 17, 3, 1, 83, 248, 0, NULL, NULL, '2025-05-21 05:25:59'),
(139, 1, 17, 3, 1, 85, 253, 0, NULL, NULL, '2025-05-21 05:26:04'),
(140, 1, 17, 3, 1, 79, 235, 1, NULL, 10, '2025-05-21 05:26:08'),
(141, 1, 18, 2, 1, 36, 106, 1, NULL, 10, '2025-05-21 06:32:55'),
(142, 1, 18, 2, 1, 39, 115, 1, NULL, 10, '2025-05-21 06:33:09'),
(143, 1, 18, 2, 1, 40, 119, 0, NULL, NULL, '2025-05-21 06:33:18'),
(144, 1, 18, 2, 1, 50, 150, 0, NULL, NULL, '2025-05-21 06:33:34'),
(145, 1, 18, 2, 1, 44, 130, 1, NULL, 10, '2025-05-21 06:33:43'),
(146, 1, 18, 2, 1, 45, 133, 0, NULL, NULL, '2025-05-21 06:33:51'),
(147, 1, 18, 2, 1, 35, 104, 1, NULL, 10, '2025-05-21 06:34:20'),
(148, 1, 18, 2, 1, 37, 110, 1, NULL, 10, '2025-05-21 06:34:25'),
(149, 1, 18, 2, 1, 38, 114, 1, NULL, 10, '2025-05-21 06:34:30'),
(150, 1, 18, 2, 1, 41, 121, 1, NULL, 10, '2025-05-21 06:34:34'),
(151, 1, 19, 1, 1, 20, 58, 1, NULL, 10, '2025-05-21 07:27:58'),
(152, 1, 19, 1, 1, 18, 53, 0, NULL, NULL, '2025-05-21 07:28:04'),
(153, 1, 19, 1, 1, 14, 41, 1, NULL, 10, '2025-05-21 07:28:24'),
(154, 1, 19, 1, 1, 24, 71, 0, NULL, NULL, '2025-05-21 07:28:27'),
(155, 1, 19, 1, 1, 26, 77, 1, NULL, 10, '2025-05-21 07:28:30'),
(156, 1, 19, 1, 1, 30, 88, 1, NULL, 10, '2025-05-21 07:28:34'),
(157, 1, 19, 1, 1, 28, 83, 0, NULL, NULL, '2025-05-21 07:28:36'),
(158, 1, 19, 1, 1, 27, 80, 0, NULL, NULL, '2025-05-21 07:28:40'),
(159, 1, 19, 1, 1, 22, 65, 0, NULL, NULL, '2025-05-21 07:28:43'),
(160, 1, 19, 1, 1, 15, 45, 0, NULL, NULL, '2025-05-21 07:28:45'),
(161, 1, 20, 1, 1, 14, 40, 0, NULL, NULL, '2025-05-21 10:05:12'),
(162, 1, 20, 1, 1, 20, 58, 1, NULL, 10, '2025-05-21 10:05:23'),
(163, 1, 20, 1, 1, 15, 43, 0, NULL, NULL, '2025-05-21 10:05:31'),
(164, 1, 20, 1, 1, 10, 28, 1, NULL, 10, '2025-05-21 10:05:45'),
(165, 1, 20, 1, 1, 6, 17, 1, NULL, 10, '2025-05-21 10:05:54'),
(166, 1, 20, 1, 1, 4, 11, 1, NULL, 10, '2025-05-21 10:06:00'),
(167, 1, 20, 1, 1, 19, 56, 1, NULL, 10, '2025-05-21 10:06:17'),
(168, 1, 20, 1, 1, 18, 52, 1, NULL, 10, '2025-05-21 10:06:26'),
(169, 1, 20, 1, 1, 13, 37, 1, NULL, 10, '2025-05-21 10:06:39'),
(170, 1, 20, 1, 1, 25, 74, 1, NULL, 10, '2025-05-21 10:06:52'),
(171, 1, 21, 3, 1, 76, 227, 1, NULL, 10, '2025-05-21 10:10:27'),
(172, 1, 21, 3, 1, 73, 218, 0, NULL, NULL, '2025-05-21 10:10:35'),
(173, 1, 21, 3, 1, 77, 231, 0, NULL, NULL, '2025-05-21 10:10:44'),
(174, 1, 21, 3, 1, 63, 189, 0, NULL, NULL, '2025-05-21 10:10:51'),
(175, 1, 21, 3, 1, 65, 195, 0, NULL, NULL, '2025-05-21 10:11:01'),
(176, 1, 21, 3, 1, 66, 196, 1, NULL, 10, '2025-05-21 10:11:08'),
(177, 1, 21, 3, 1, 67, 200, 0, NULL, NULL, '2025-05-21 10:11:11'),
(178, 1, 21, 3, 1, 64, 191, 0, NULL, NULL, '2025-05-21 10:11:15'),
(179, 1, 21, 3, 1, 69, 206, 0, NULL, NULL, '2025-05-21 10:11:19'),
(180, 1, 21, 3, 1, 62, 186, 0, NULL, NULL, '2025-05-21 10:11:22'),
(181, 1, 22, 2, 1, 31, 91, 0, NULL, NULL, '2025-05-21 13:47:36'),
(182, 1, 22, 2, 1, 32, 94, 0, NULL, NULL, '2025-05-21 13:47:39'),
(183, 1, 22, 2, 1, 35, 103, 0, NULL, NULL, '2025-05-21 13:47:46'),
(184, 1, 22, 2, 1, 39, 115, 1, NULL, 10, '2025-05-21 13:47:49'),
(185, 1, 22, 2, 1, 37, 109, 0, NULL, NULL, '2025-05-21 13:47:53'),
(186, 1, 22, 2, 1, 40, 118, 0, NULL, NULL, '2025-05-21 13:48:06'),
(187, 1, 22, 2, 1, 33, 98, 1, NULL, 10, '2025-05-21 13:48:09'),
(188, 1, 22, 2, 1, 34, 100, 0, NULL, NULL, '2025-05-21 13:48:13'),
(189, 1, 23, 1, 1, 20, 58, 1, NULL, 10, '2025-05-22 05:29:22'),
(190, 1, 23, 1, 1, 12, 34, 0, NULL, NULL, '2025-05-22 05:29:25'),
(191, 1, 23, 1, 1, 14, 40, 0, NULL, NULL, '2025-05-22 05:29:29'),
(192, 1, 23, 1, 1, 6, 16, 0, NULL, NULL, '2025-05-22 05:29:32'),
(193, 1, 23, 1, 1, 3, 7, 1, NULL, 10, '2025-05-22 05:29:36'),
(194, 1, 23, 1, 1, 7, 20, 1, NULL, 10, '2025-05-22 05:29:40'),
(195, 1, 23, 1, 1, 11, 32, 1, NULL, 10, '2025-05-22 05:29:44'),
(196, 1, 23, 1, 1, 13, 38, 0, NULL, NULL, '2025-05-22 05:29:48'),
(197, 1, 23, 1, 1, 18, 53, 0, NULL, NULL, '2025-05-22 05:29:51'),
(198, 1, 23, 1, 1, 8, 23, 1, NULL, 10, '2025-05-22 05:29:56'),
(199, 1, 24, 3, 1, 79, 235, 1, NULL, 10, '2025-05-22 05:31:00'),
(200, 1, 24, 3, 1, 78, 233, 1, NULL, 10, '2025-05-22 05:31:07'),
(201, 1, 24, 3, 1, 74, 220, 1, NULL, 10, '2025-05-22 05:31:11'),
(202, 1, 24, 3, 1, 90, 268, 0, NULL, NULL, '2025-05-22 05:31:20'),
(203, 1, 24, 3, 1, 82, 246, 0, NULL, NULL, '2025-05-22 05:31:27'),
(204, 1, 24, 3, 1, 81, 242, 1, NULL, 10, '2025-05-22 05:31:33'),
(205, 1, 24, 3, 1, 75, 225, 1, NULL, 10, '2025-05-22 05:31:38'),
(206, 1, 24, 3, 1, 76, 227, 1, NULL, 10, '2025-05-22 05:31:43'),
(207, 1, 24, 3, 1, 80, 238, 1, NULL, 10, '2025-05-22 05:31:50'),
(208, 1, 24, 3, 1, 85, 255, 0, NULL, NULL, '2025-05-22 05:31:55'),
(209, 1, 26, 1, 1, 20, 58, 1, NULL, 10, '2025-05-22 05:32:58'),
(210, 1, 26, 1, 1, 15, 43, 0, NULL, NULL, '2025-05-22 05:33:01'),
(211, 1, 26, 1, 1, 18, 52, 1, NULL, 10, '2025-05-22 05:33:05'),
(212, 1, 26, 1, 1, 26, 76, 0, NULL, NULL, '2025-05-22 05:33:08'),
(213, 1, 26, 1, 1, 22, 64, 0, NULL, NULL, '2025-05-22 05:34:46'),
(214, 1, 26, 1, 1, 24, 70, 0, NULL, NULL, '2025-05-22 05:34:48'),
(215, 1, 26, 1, 1, 11, 31, 0, NULL, NULL, '2025-05-22 05:34:50'),
(216, 1, 26, 1, 1, 16, 47, 1, NULL, 10, '2025-05-22 05:34:52'),
(217, 1, 26, 1, 1, 17, 50, 1, NULL, 10, '2025-05-22 05:34:55'),
(218, 1, 26, 1, 1, 25, 74, 1, NULL, 10, '2025-05-22 05:34:57'),
(219, 1, 27, 1, 1, 20, 58, 1, NULL, 10, '2025-05-22 05:36:02'),
(220, 1, 27, 1, 1, 19, 55, 0, NULL, NULL, '2025-05-22 05:36:04'),
(221, 1, 27, 1, 1, 13, 37, 1, NULL, 10, '2025-05-22 05:36:07'),
(222, 1, 27, 1, 1, 23, 67, 0, NULL, NULL, '2025-05-22 05:36:09'),
(223, 1, 27, 1, 1, 22, 64, 0, NULL, NULL, '2025-05-22 05:36:11'),
(224, 1, 27, 1, 1, 21, 61, 0, NULL, NULL, '2025-05-22 05:36:13'),
(225, 1, 27, 1, 1, 17, 49, 0, NULL, NULL, '2025-05-22 05:36:15'),
(226, 1, 27, 1, 1, 14, 40, 0, NULL, NULL, '2025-05-22 05:36:17'),
(227, 1, 27, 1, 1, 18, 52, 1, NULL, 10, '2025-05-22 05:36:20'),
(228, 1, 27, 1, 1, 3, 7, 1, NULL, 10, '2025-05-22 05:36:23'),
(229, 1, 28, 1, 1, 16, 46, 0, NULL, NULL, '2025-05-22 05:36:44'),
(230, 1, 28, 1, 1, 11, 31, 0, NULL, NULL, '2025-05-22 05:36:46'),
(231, 1, 28, 1, 1, 13, 37, 1, NULL, 10, '2025-05-22 05:36:49'),
(232, 1, 28, 1, 1, 10, 28, 1, NULL, 10, '2025-05-22 05:36:51'),
(233, 1, 28, 1, 1, 4, 10, 0, NULL, NULL, '2025-05-22 05:36:53'),
(234, 1, 28, 1, 1, 1, 1, 0, NULL, NULL, '2025-05-22 05:36:55'),
(235, 1, 28, 1, 1, 8, 22, 0, NULL, NULL, '2025-05-22 05:36:57'),
(236, 1, 28, 1, 1, 3, 7, 1, NULL, 10, '2025-05-22 05:37:34'),
(237, 1, 28, 1, 1, 5, 13, 1, NULL, 10, '2025-05-22 05:37:58'),
(238, 1, 28, 1, 1, 12, 34, 0, NULL, NULL, '2025-05-22 05:38:32'),
(239, 1, 29, 2, 1, 34, 100, 0, NULL, NULL, '2025-05-22 06:03:43'),
(240, 1, 29, 2, 1, 39, 115, 1, NULL, 10, '2025-05-22 06:03:48'),
(241, 1, 29, 2, 1, 33, 97, 0, NULL, NULL, '2025-05-22 06:03:52'),
(242, 1, 29, 2, 1, 36, 106, 1, NULL, 10, '2025-05-22 06:03:55'),
(243, 1, 29, 2, 1, 32, 94, 0, NULL, NULL, '2025-05-22 06:03:57'),
(244, 1, 29, 2, 1, 38, 112, 0, NULL, NULL, '2025-05-22 06:04:00'),
(245, 1, 29, 2, 1, 37, 109, 0, NULL, NULL, '2025-05-22 06:04:02'),
(246, 1, 29, 2, 1, 35, 103, 0, NULL, NULL, '2025-05-22 06:04:05'),
(247, 1, 29, 2, 1, 31, 91, 0, NULL, NULL, '2025-05-22 06:04:09'),
(248, 1, 29, 2, 1, 40, 118, 0, NULL, NULL, '2025-05-22 06:04:11'),
(249, 1, 30, 1, 1, 11, 31, 0, NULL, NULL, '2025-05-22 06:46:31'),
(250, 1, 31, 1, 1, 13, 37, 1, NULL, 10, '2025-05-22 06:50:15'),
(251, 1, 31, 1, 1, 12, 34, 0, NULL, NULL, '2025-05-22 06:50:18'),
(252, 1, 31, 1, 1, 18, 52, 1, NULL, 10, '2025-05-22 06:50:20'),
(253, 1, 31, 1, 1, 27, 79, 0, NULL, NULL, '2025-05-22 06:50:22'),
(254, 1, 31, 1, 1, 24, 70, 0, NULL, NULL, '2025-05-22 06:50:25'),
(255, 1, 31, 1, 1, 28, 82, 1, NULL, 10, '2025-05-22 06:50:43'),
(256, 1, 31, 1, 1, 14, 40, 0, NULL, NULL, '2025-05-22 06:50:47'),
(257, 1, 31, 1, 1, 15, 43, 0, NULL, NULL, '2025-05-22 06:50:51'),
(258, 1, 31, 1, 1, 17, 49, 0, NULL, NULL, '2025-05-22 06:50:56'),
(259, 1, 31, 1, 1, 6, 16, 0, NULL, NULL, '2025-05-22 06:51:05'),
(260, 1, 37, 1, 1, 18, 52, 1, NULL, 10, '2025-05-22 10:38:25'),
(261, 1, 36, 1, 1, 20, 58, 1, NULL, 10, '2025-05-22 10:39:29'),
(262, 1, 36, 1, 1, 15, 43, 0, NULL, NULL, '2025-05-22 10:40:21'),
(263, 1, 37, 1, 1, 12, 34, 0, NULL, NULL, '2025-05-22 10:40:34'),
(264, 1, 33, 2, 1, 31, 91, 0, NULL, NULL, '2025-05-22 10:40:48'),
(265, 1, 38, 1, 1, 15, 43, 0, NULL, NULL, '2025-05-22 10:41:08'),
(266, 1, 33, 2, 1, 37, 110, 1, NULL, 10, '2025-05-22 10:42:54'),
(267, 1, 33, 2, 1, 40, 120, 1, NULL, 10, '2025-05-22 10:43:00'),
(268, 1, 38, 1, 1, 19, 55, 0, NULL, NULL, '2025-05-22 10:45:05'),
(269, 1, 39, 2, 1, 38, 114, 1, NULL, 10, '2025-05-22 10:46:30'),
(270, 1, 39, 2, 1, 40, 120, 1, NULL, 10, '2025-05-22 10:46:37'),
(271, 1, 39, 2, 1, 35, 103, 0, NULL, NULL, '2025-05-22 10:47:00'),
(272, 1, 39, 2, 1, 44, 130, 1, NULL, 10, '2025-05-22 10:47:07'),
(273, 1, 36, 1, 1, 14, 42, 0, NULL, NULL, '2025-05-22 10:49:52'),
(274, 1, 36, 1, 1, 3, 7, 1, NULL, 10, '2025-05-22 10:49:56'),
(275, 1, 37, 1, 1, 12, 34, 0, NULL, NULL, '2025-05-22 10:53:15'),
(276, 1, 37, 1, 1, 3, 7, 1, NULL, 10, '2025-05-22 10:53:21'),
(277, 1, 37, 1, 1, 10, 28, 1, NULL, 10, '2025-05-22 10:53:24'),
(278, 1, 37, 1, 1, 4, 10, 0, NULL, NULL, '2025-05-22 10:53:28'),
(279, 1, 37, 1, 1, 11, 31, 0, NULL, NULL, '2025-05-22 10:53:33'),
(280, 1, 37, 1, 1, 16, 46, 0, NULL, NULL, '2025-05-22 10:53:40'),
(281, 1, 37, 1, 1, 17, 49, 0, NULL, NULL, '2025-05-22 10:53:42'),
(282, 1, 37, 1, 1, 1, 1, 0, NULL, NULL, '2025-05-22 10:53:45'),
(283, 1, 36, 1, 1, 17, 49, 0, NULL, NULL, '2025-05-22 10:55:50'),
(284, 1, 36, 1, 1, 13, 38, 0, NULL, NULL, '2025-05-22 10:55:52'),
(285, 1, 36, 1, 1, 8, 23, 1, NULL, 10, '2025-05-22 10:55:54'),
(286, 1, 36, 1, 1, 2, 5, 1, NULL, 10, '2025-05-22 10:55:55'),
(287, 1, 36, 1, 1, 1, 1, 0, NULL, NULL, '2025-05-22 10:55:57'),
(288, 1, 36, 1, 1, 16, 47, 1, NULL, 10, '2025-05-22 10:56:01'),
(289, 1, 40, 1, 1, 19, 55, 0, NULL, NULL, '2025-05-22 10:56:16'),
(290, 1, 40, 1, 1, 17, 49, 0, NULL, NULL, '2025-05-22 10:56:19'),
(291, 1, 40, 1, 1, 15, 43, 0, NULL, NULL, '2025-05-22 10:56:23'),
(292, 1, 40, 1, 1, 7, 19, 0, NULL, NULL, '2025-05-22 10:56:26'),
(293, 1, 40, 1, 1, 6, 16, 0, NULL, NULL, '2025-05-22 10:56:29'),
(294, 1, 40, 1, 1, 10, 28, 1, NULL, 10, '2025-05-22 10:56:31'),
(295, 1, 40, 1, 1, 5, 13, 1, NULL, 10, '2025-05-22 10:56:34'),
(296, 1, 40, 1, 1, 9, 25, 0, NULL, NULL, '2025-05-22 10:56:37'),
(297, 1, 40, 1, 1, 4, 10, 0, NULL, NULL, '2025-05-22 10:56:39'),
(298, 1, 40, 1, 1, 1, 1, 0, NULL, NULL, '2025-05-22 10:56:44'),
(299, 1, 33, 2, 1, 32, 96, 1, NULL, 10, '2025-05-22 10:57:33'),
(300, 1, 33, 2, 1, 38, 114, 1, NULL, 10, '2025-05-22 10:57:37'),
(301, 1, 33, 2, 1, 33, 97, 0, NULL, NULL, '2025-05-22 10:57:43'),
(302, 1, 33, 2, 1, 49, 145, 1, NULL, 10, '2025-05-22 10:57:48'),
(303, 1, 33, 2, 1, 50, 148, 0, NULL, NULL, '2025-05-22 10:57:54'),
(304, 1, 33, 2, 1, 47, 141, 0, NULL, NULL, '2025-05-22 10:57:57'),
(305, 1, 33, 2, 1, 34, 101, 1, NULL, 10, '2025-05-22 10:58:03'),
(306, 1, 43, 2, 1, 37, 110, 1, NULL, 10, '2025-05-22 11:13:48'),
(307, 1, 43, 2, 1, 38, 113, 0, NULL, NULL, '2025-05-22 11:13:51'),
(308, 1, 43, 2, 1, 35, 103, 0, NULL, NULL, '2025-05-22 11:13:55'),
(309, 1, 43, 2, 1, 36, 106, 1, NULL, 10, '2025-05-22 11:13:59'),
(310, 1, 43, 2, 1, 32, 96, 1, NULL, 10, '2025-05-22 11:14:05'),
(311, 1, 43, 2, 1, 39, 115, 1, NULL, 10, '2025-05-22 11:14:12'),
(312, 1, 43, 2, 1, 49, 145, 1, NULL, 10, '2025-05-22 11:14:44'),
(313, 1, 43, 2, 1, 50, 148, 0, NULL, NULL, '2025-05-22 11:14:49'),
(314, 1, 43, 2, 1, 44, 130, 1, NULL, 10, '2025-05-22 11:14:53'),
(315, 1, 43, 2, 1, 58, 173, 0, NULL, NULL, '2025-05-22 11:14:57'),
(316, 1, 49, 1, 1, 13, 37, 1, NULL, 10, '2025-05-22 12:24:33'),
(317, 1, 49, 1, 1, 18, 52, 1, NULL, 10, '2025-05-22 12:24:47'),
(318, 1, 49, 1, 1, 20, 58, 1, NULL, 10, '2025-05-22 12:24:49'),
(319, 1, 49, 1, 1, 26, 76, 0, NULL, NULL, '2025-05-22 12:24:52'),
(320, 1, 49, 1, 1, 22, 66, 1, NULL, 10, '2025-05-22 12:24:54'),
(321, 1, 49, 1, 1, 25, 75, 0, NULL, NULL, '2025-05-22 12:24:56'),
(322, 1, 49, 1, 1, 16, 48, 0, NULL, NULL, '2025-05-22 12:24:58'),
(323, 1, 49, 1, 1, 19, 57, 0, NULL, NULL, '2025-05-22 12:25:02'),
(324, 1, 49, 1, 1, 15, 45, 0, NULL, NULL, '2025-05-22 12:25:04'),
(325, 1, 49, 1, 1, 10, 30, 0, NULL, NULL, '2025-05-22 12:25:11'),
(326, 1, 50, 1, 1, 19, 56, 1, NULL, 10, '2025-05-23 05:23:08'),
(327, 1, 50, 1, 1, 12, 34, 0, NULL, NULL, '2025-05-23 05:23:30'),
(328, 1, 50, 1, 1, 14, 41, 1, NULL, 10, '2025-05-23 05:23:35'),
(329, 1, 50, 1, 1, 25, 73, 0, NULL, NULL, '2025-05-23 05:23:42'),
(330, 1, 50, 1, 1, 22, 65, 0, NULL, NULL, '2025-05-23 05:23:47'),
(331, 1, 50, 1, 1, 21, 62, 1, NULL, 10, '2025-05-23 05:23:57'),
(332, 1, 50, 1, 1, 15, 44, 1, NULL, 10, '2025-05-23 05:24:06'),
(333, 1, 50, 1, 1, 17, 51, 0, NULL, NULL, '2025-05-23 05:24:11'),
(334, 1, 50, 1, 1, 18, 54, 0, NULL, NULL, '2025-05-23 05:24:24'),
(335, 1, 50, 1, 1, 3, 7, 1, NULL, 10, '2025-05-23 05:24:28'),
(336, 1, 51, 3, 1, 72, 214, 0, NULL, NULL, '2025-05-23 06:52:56'),
(337, 1, 51, 3, 1, 79, 235, 1, NULL, 10, '2025-05-23 06:52:58'),
(338, 1, 51, 3, 1, 73, 217, 0, NULL, NULL, '2025-05-23 06:53:01'),
(339, 1, 51, 3, 1, 68, 202, 0, NULL, NULL, '2025-05-23 06:53:03'),
(340, 1, 51, 3, 1, 62, 184, 0, NULL, NULL, '2025-05-23 06:53:04'),
(341, 1, 51, 3, 1, 64, 190, 1, NULL, 10, '2025-05-23 06:53:06'),
(342, 1, 51, 3, 1, 69, 205, 0, NULL, NULL, '2025-05-23 06:53:08'),
(343, 1, 51, 3, 1, 70, 208, 0, NULL, NULL, '2025-05-23 06:53:10'),
(344, 1, 51, 3, 1, 61, 181, 1, NULL, 10, '2025-05-23 06:53:12'),
(345, 1, 51, 3, 1, 63, 187, 0, NULL, NULL, '2025-05-23 06:53:15'),
(346, 3, 52, 2, 1, 44, 130, 1, NULL, 10, '2025-05-23 12:00:31'),
(347, 3, 52, 2, 1, 46, 137, 0, NULL, NULL, '2025-05-23 12:00:37'),
(348, 3, 52, 2, 1, 42, 124, 0, NULL, NULL, '2025-05-23 12:00:44'),
(349, 3, 52, 2, 1, 34, 100, 0, NULL, NULL, '2025-05-23 12:00:53'),
(350, 3, 52, 2, 1, 32, 96, 1, NULL, 10, '2025-05-23 12:00:59'),
(351, 3, 52, 2, 1, 39, 115, 1, NULL, 10, '2025-05-23 12:01:07'),
(352, 3, 52, 2, 1, 48, 143, 0, NULL, NULL, '2025-05-23 12:01:19'),
(353, 3, 52, 2, 1, 41, 121, 1, NULL, 10, '2025-05-23 12:01:22'),
(354, 3, 52, 2, 1, 50, 150, 0, NULL, NULL, '2025-05-23 12:01:26'),
(355, 3, 52, 2, 1, 35, 105, 0, NULL, NULL, '2025-05-23 12:01:33'),
(356, 3, 53, 2, 1, 34, 100, 0, NULL, NULL, '2025-05-23 12:03:29'),
(357, 3, 53, 2, 1, 33, 97, 0, NULL, NULL, '2025-05-23 12:03:31'),
(358, 3, 53, 2, 1, 39, 115, 1, NULL, 10, '2025-05-23 12:03:35'),
(359, 3, 53, 2, 1, 38, 112, 0, NULL, NULL, '2025-05-23 12:03:37'),
(360, 3, 53, 2, 1, 32, 94, 0, NULL, NULL, '2025-05-23 12:03:39'),
(361, 3, 53, 2, 1, 37, 109, 0, NULL, NULL, '2025-05-23 12:03:42'),
(362, 3, 53, 2, 1, 31, 91, 0, NULL, NULL, '2025-05-23 12:03:44'),
(363, 3, 53, 2, 1, 36, 106, 1, NULL, 10, '2025-05-23 12:03:46'),
(364, 3, 53, 2, 1, 40, 118, 0, NULL, NULL, '2025-05-23 12:03:48'),
(365, 3, 53, 2, 1, 35, 103, 0, NULL, NULL, '2025-05-23 12:03:50'),
(366, 3, 56, 4, 1, 108, 324, 0, NULL, NULL, '2025-05-23 13:09:22'),
(367, 3, 56, 4, 1, 105, 313, 0, NULL, NULL, '2025-05-23 13:09:28'),
(368, 3, 56, 4, 1, 107, 319, 0, NULL, NULL, '2025-05-23 13:09:31'),
(369, 3, 56, 4, 1, 100, 298, 0, NULL, NULL, '2025-05-23 13:09:35'),
(370, 3, 56, 4, 1, 97, 290, 0, NULL, NULL, '2025-05-23 13:09:37'),
(371, 3, 56, 4, 1, 98, 292, 0, NULL, NULL, '2025-05-23 13:09:39'),
(372, 3, 56, 4, 1, 94, 282, 0, NULL, NULL, '2025-05-23 13:09:43'),
(373, 3, 56, 4, 1, 93, 277, 0, NULL, NULL, '2025-05-23 13:09:45'),
(374, 3, 56, 4, 1, 92, 275, 0, NULL, NULL, '2025-05-23 13:09:48'),
(375, 3, 56, 4, 1, 95, 283, 1, NULL, 10, '2025-05-23 13:09:52'),
(376, 3, 57, 5, 1, 139, 415, 1, NULL, 10, '2025-05-23 13:10:53'),
(377, 3, 57, 5, 1, 137, 409, 0, NULL, NULL, '2025-05-23 13:11:01'),
(378, 3, 57, 5, 1, 138, 413, 1, NULL, 10, '2025-05-23 13:11:06'),
(379, 3, 57, 5, 1, 144, 431, 1, NULL, 10, '2025-05-23 13:11:14'),
(380, 3, 57, 5, 1, 145, 433, 0, NULL, NULL, '2025-05-23 13:11:17'),
(381, 3, 57, 5, 1, 143, 427, 0, NULL, NULL, '2025-05-23 13:11:20'),
(382, 3, 57, 5, 1, 134, 400, 0, NULL, NULL, '2025-05-23 13:11:22'),
(383, 3, 57, 5, 1, 135, 403, 1, NULL, 10, '2025-05-23 13:11:24'),
(384, 3, 57, 5, 1, 132, 394, 1, NULL, 10, '2025-05-23 13:11:26'),
(385, 3, 57, 5, 1, 147, 440, 1, NULL, 10, '2025-05-23 13:11:32'),
(386, 3, 58, 6, 1, 164, 490, 0, NULL, NULL, '2025-05-23 13:11:53'),
(387, 3, 58, 6, 1, 165, 494, 1, NULL, 10, '2025-05-23 13:11:58'),
(388, 3, 58, 6, 1, 162, 484, 0, NULL, NULL, '2025-05-23 13:12:01'),
(389, 3, 58, 6, 1, 153, 457, 0, NULL, NULL, '2025-05-23 13:12:04'),
(390, 3, 58, 6, 1, 156, 466, 0, NULL, NULL, '2025-05-23 13:12:06'),
(391, 3, 58, 6, 1, 158, 472, 0, NULL, NULL, '2025-05-23 13:12:08'),
(392, 3, 58, 6, 1, 157, 469, 0, NULL, NULL, '2025-05-23 13:12:09'),
(393, 3, 58, 6, 1, 154, 460, 0, NULL, NULL, '2025-05-23 13:12:11'),
(394, 3, 58, 6, 1, 159, 475, 0, NULL, NULL, '2025-05-23 13:12:13'),
(395, 3, 58, 6, 1, 155, 463, 0, NULL, NULL, '2025-05-23 13:12:15');

-- --------------------------------------------------------

--
-- Table structure for table `trn_attempts`
--

DROP TABLE IF EXISTS `trn_attempts`;
CREATE TABLE `trn_attempts` (
  `attemptid` int NOT NULL,
  `userid` int NOT NULL,
  `topicid` int NOT NULL,
  `questiontype` tinyint NOT NULL COMMENT '1: MCQ 2: Descriptive 3: Mixed',
  `iscompleted` tinyint(1) DEFAULT '0',
  `createdat` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `trn_attempts`
--

INSERT INTO `trn_attempts` (`attemptid`, `userid`, `topicid`, `questiontype`, `iscompleted`, `createdat`) VALUES
(1, 1, 1, 1, 1, '2025-05-20 11:31:04'),
(2, 1, 1, 1, 1, '2025-05-20 11:41:41'),
(3, 1, 1, 1, 1, '2025-05-20 11:42:59'),
(4, 1, 2, 1, 1, '2025-05-20 11:44:14'),
(5, 1, 2, 1, 1, '2025-05-20 11:48:15'),
(6, 1, 2, 1, 1, '2025-05-20 11:53:12'),
(7, 1, 3, 1, 1, '2025-05-20 11:56:11'),
(8, 1, 3, 1, 1, '2025-05-20 12:41:11'),
(9, 1, 3, 1, 1, '2025-05-20 12:41:43'),
(10, 1, 1, 1, 1, '2025-05-20 12:57:01'),
(11, 1, 1, 1, 0, '2025-05-20 13:08:44'),
(12, 1, 1, 1, 0, '2025-05-20 13:39:52'),
(13, 1, 1, 1, 1, '2025-05-20 13:46:00'),
(14, 1, 1, 1, 0, '2025-05-20 13:50:50'),
(15, 1, 1, 1, 1, '2025-05-20 13:51:39'),
(16, 1, 1, 1, 1, '2025-05-20 14:02:08'),
(17, 1, 3, 1, 1, '2025-05-21 05:25:07'),
(18, 1, 2, 1, 1, '2025-05-21 06:32:51'),
(19, 1, 1, 1, 1, '2025-05-21 07:27:54'),
(20, 1, 1, 1, 1, '2025-05-21 10:05:06'),
(21, 1, 3, 1, 1, '2025-05-21 10:10:04'),
(22, 1, 2, 1, 0, '2025-05-21 13:36:20'),
(23, 1, 1, 1, 1, '2025-05-22 05:29:17'),
(24, 1, 3, 1, 1, '2025-05-22 05:30:44'),
(25, 1, 3, 1, 0, '2025-05-22 05:32:09'),
(26, 1, 1, 1, 1, '2025-05-22 05:32:50'),
(27, 1, 1, 1, 1, '2025-05-22 05:35:59'),
(28, 1, 1, 1, 1, '2025-05-22 05:36:41'),
(29, 1, 2, 1, 1, '2025-05-22 06:03:39'),
(30, 1, 1, 1, 0, '2025-05-22 06:46:23'),
(31, 1, 1, 1, 1, '2025-05-22 06:50:11'),
(32, 1, 1, 1, 0, '2025-05-22 10:34:08'),
(33, 1, 2, 1, 1, '2025-05-22 10:37:00'),
(34, 1, 1, 1, 0, '2025-05-22 10:37:01'),
(35, 1, 1, 1, 0, '2025-05-22 10:37:05'),
(36, 1, 1, 1, 1, '2025-05-22 10:37:08'),
(37, 1, 1, 1, 1, '2025-05-22 10:38:19'),
(38, 1, 1, 1, 0, '2025-05-22 10:41:05'),
(39, 1, 2, 1, 0, '2025-05-22 10:46:21'),
(40, 1, 1, 1, 1, '2025-05-22 10:55:03'),
(41, 1, 2, 1, 0, '2025-05-22 11:04:03'),
(42, 1, 1, 1, 0, '2025-05-22 11:04:47'),
(43, 1, 2, 1, 1, '2025-05-22 11:13:44'),
(44, 1, 1, 1, 0, '2025-05-22 11:20:34'),
(45, 1, 1, 1, 0, '2025-05-22 11:34:46'),
(46, 1, 1, 1, 0, '2025-05-22 11:34:51'),
(47, 1, 1, 1, 0, '2025-05-22 11:35:24'),
(48, 1, 1, 1, 0, '2025-05-22 11:53:56'),
(49, 1, 1, 1, 1, '2025-05-22 12:24:30'),
(50, 1, 1, 1, 1, '2025-05-23 05:22:57'),
(51, 1, 3, 1, 1, '2025-05-23 06:52:49'),
(52, 3, 2, 1, 1, '2025-05-23 12:00:21'),
(53, 3, 2, 1, 1, '2025-05-23 12:03:26'),
(54, 3, 1, 1, 0, '2025-05-23 13:07:06'),
(55, 3, 4, 1, 0, '2025-05-23 13:07:19'),
(56, 3, 4, 1, 1, '2025-05-23 13:09:14'),
(57, 3, 5, 1, 1, '2025-05-23 13:10:44'),
(58, 3, 6, 1, 1, '2025-05-23 13:11:44');

-- --------------------------------------------------------

--
-- Table structure for table `trn_user_consent`
--

DROP TABLE IF EXISTS `trn_user_consent`;
CREATE TABLE `trn_user_consent` (
  `id` int NOT NULL,
  `clientid` int NOT NULL,
  `userid` int NOT NULL,
  `consent` tinyint(1) NOT NULL,
  `createdat` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `trn_user_consent`
--

INSERT INTO `trn_user_consent` (`id`, `clientid`, `userid`, `consent`, `createdat`) VALUES
(1, 1, 1, 1, '2025-05-22 12:26:53'),
(2, 1, 3, 1, '2025-05-23 12:02:48');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `userid` int NOT NULL,
  `clientid` int NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `usertype` int NOT NULL COMMENT '1- Super admin, 2 - Admin, 3 - User',
  `isactive` tinyint(1) DEFAULT '1',
  `isdeleted` tinyint(1) DEFAULT '0',
  `createdat` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userid`, `clientid`, `email`, `name`, `username`, `password`, `image`, `usertype`, `isactive`, `isdeleted`, `createdat`) VALUES
(1, 1, 'superadmin@gmail.com', 'Super Admin', 'superadmin@gmail.com', '$2b$10$UiIyGxoRqhr1swE5QVvpP.woKAWy90oJ0zzyzgNgBuJ.LFQ.P5Sei', 'QBOT1744280686269.jpeg', 1, 1, 0, '2025-05-23 16:41:54'),
(2, 1, 'admin@gmail.com', 'Admin', 'admin@gmail.com', '$2b$10$UiIyGxoRqhr1swE5QVvpP.woKAWy90oJ0zzyzgNgBuJ.LFQ.P5Sei', 'QBOT1744280686269.jpeg', 2, 1, 0, '2025-05-23 16:42:35'),
(3, 1, 'sourav@yopmail.com', 'Sourav Chatterjee', 'sourav@yopmail.com', '$2b$10$UiIyGxoRqhr1swE5QVvpP.woKAWy90oJ0zzyzgNgBuJ.LFQ.P5Sei', 'sourav.jpg', 3, 1, 0, '2025-05-16 13:36:57'),
(4, 1, 'john.doe@example.com', 'John Doe', 'john.doe@example.com', '$2b$12$S42GsqbzPmYelizsir6E0ej1bTyTvklNSZpn7AQKgSxBRZogALQ72', NULL, 3, 1, 0, '2025-05-30 14:56:06'),
(5, 1, 'jane.smith@example.com', 'Jane Smith', 'jane.smith@example.com', '$2b$12$0s70YdSrFmQHNdl/E.23NurZlVi4/t9RK3kVLL6VmnozOCg1mI87C', NULL, 3, 1, 0, '2025-05-30 14:56:06'),
(6, 1, 'john.doe@example.com', 'John Doe', 'john.doe@example.com', '$2b$12$Ed6w144KRzMulkcsXEgx5.xvgjgw0mhrD7AHK4DxQ2vPvHGEH0CeO', NULL, 3, 1, 0, '2025-05-30 15:03:07'),
(7, 1, 'jane.smith@example.com', 'Jane Smith', 'jane.smith@example.com', '$2b$12$9n2R9zqKGkvXjdCsTGIG0eRA7xQkq.k82EDZxfiFQWGW8gviaknla', NULL, 3, 1, 0, '2025-05-30 15:03:07'),
(8, 1, 'alay@yopmail.com', 'Alay Chandra', 'alay@yopmail.com', '$2b$12$duwIJvQHnjzsnTYI2ZesgOnVmaZQHJQTPbSIyIu9w8JOEwvHPQgJa', NULL, 3, 1, 0, '2025-05-30 15:03:07'),
(9, 1, 'aindrila@yopmail.com', 'Aindrila Patra', 'aindrila@yopmail.com', '$2b$12$mOSEYB0CrctFV6HEwi0haukms5U5JO71REhxdfElsGIEoeEWBXdTq', NULL, 3, 1, 0, '2025-05-30 15:03:07'),
(10, 1, 'john.doe@example.com', 'John Doe', 'john.doe@example.com', '$2b$12$iqM1fLWETEdRnTwCSGBdVeZQzAhyzd/OIv0FevrdoC3FgCvDUNDi.', NULL, 3, 1, 0, '2025-05-30 15:13:55'),
(11, 1, 'jane.smith@example.com', 'Jane Smith', 'jane.smith@example.com', '$2b$12$KCBPaRst6nWtA8cvm9Pc9eHRBQcrypjZkYF.3iBknlqeQBBlhpMMm', NULL, 3, 1, 0, '2025-05-30 15:13:55'),
(12, 1, 'alay@yopmail.com', 'Alay Chandra', 'alay@yopmail.com', '$2b$12$7nnnlFtNGKQnoxZwwMFwHuo6k.YkblbnClHD1glRwfaBOWGykztH.', NULL, 3, 1, 0, '2025-05-30 15:13:55'),
(13, 1, 'aindrila@yopmail.com', 'Aindrila Patra', 'aindrila@yopmail.com', '$2b$12$kpnfeu3EIwnu1Q6.Zqko.OEjrBY7PCPTrY7Gp0K2HuXuNg6ayXZeG', NULL, 3, 1, 0, '2025-05-30 15:13:55'),
(14, 1, 'john.doe@example.com', 'John Doe', 'john.doe@example.com', '$2b$12$.RNRnrIhuOLBjoU0oKJhZOVtJ2axa9jcfA1f4NAZ6AkWyoJZAvyC2', NULL, 3, 1, 0, '2025-05-30 15:15:54'),
(15, 1, 'jane.smith@example.com', 'Jane Smith', 'jane.smith@example.com', '$2b$12$83eZB8MM/dzbAVbxxMN43.ibXjJTux9Wg2Pyd1fSwtD8Olp6me0Eu', NULL, 3, 1, 0, '2025-05-30 15:15:54'),
(16, 1, 'alay@yopmail.com', 'Alay Chandra', 'alay@yopmail.com', '$2b$12$2ZUKHu1Gp6Migw.zFOythul.aX69hJLOLfDI05QnfiN46s7beRfBq', NULL, 3, 1, 0, '2025-05-30 15:15:54'),
(17, 1, 'aindrila@yopmail.com', 'Aindrila Patra', 'aindrila@yopmail.com', '$2b$12$S/SwUiYZMNwdyQ3TRqFS0.sKDogiwnsAXTJmDLUAUVA0VV3qvO5Je', NULL, 3, 1, 0, '2025-05-30 15:15:54'),
(18, 1, 'john.doe@example.com', 'John Doe', 'john.doe@example.com', '$2b$12$MLAmts4IwxWZn4n8kNGuJe92NwQftuKiFlnnTTxEak9zQuZfenM4u', NULL, 3, 1, 0, '2025-05-30 15:16:20'),
(19, 1, 'jane.smith@example.com', 'Jane Smith', 'jane.smith@example.com', '$2b$12$jMfUpycrBqqn6q/sU.VaG.DhDM79kVkup1uQTiGy7thU1ncb4AG9S', NULL, 3, 1, 0, '2025-05-30 15:16:20'),
(20, 1, 'alay@yopmail.com', 'Alay Chandra', 'alay@yopmail.com', '$2b$12$DWAdczbyP.VP7zVdR0lctuF0LLjpcUjVD.QLJO6fila2fK.Zj9Efm', NULL, 3, 1, 0, '2025-05-30 15:16:20'),
(21, 1, 'aindrila@yopmail.com', 'Aindrila Patra', 'aindrila@yopmail.com', '$2b$12$5ai8XKg1A3N1/VTnW54gwOw28RK407B2aFKzY3JDp4DoEDK59SBd2', NULL, 3, 1, 0, '2025-05-30 15:16:20'),
(22, 1, 'john.doe@example.com', 'John Doe', 'john.doe@example.com', '$2b$12$iLneJkgbTvUWemgjY4rgyO6ZSdNuWQF0J5o45MVup85mGGo3Ow.6K', NULL, 3, 1, 0, '2025-05-30 15:17:37'),
(23, 1, 'jane.smith@example.com', 'Jane Smith', 'jane.smith@example.com', '$2b$12$eE8h1CHfuiRiYafqjfEaI.thh.Q09TPXhDjW8HrndGoe9MTOskS5u', NULL, 3, 1, 0, '2025-05-30 15:17:37'),
(24, 1, 'alay@yopmail.com', 'Alay Chandra', 'alay@yopmail.com', '$2b$12$Zrk4oeznLIiVbc31iU9ZI.yenT5t7eaEGBdxeU9V7/.5UwXoydjBu', NULL, 3, 1, 0, '2025-05-30 15:17:37'),
(25, 1, 'aindrila@yopmail.com', 'Aindrila Patra', 'aindrila@yopmail.com', '$2b$12$3BfLewQwpHkA8YMEkq/Vl.uyMKjw1rLtAS1Wk/ad.ROKbYpDZP5Rq', NULL, 3, 1, 0, '2025-05-30 15:17:37');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `error_log`
--
ALTER TABLE `error_log`
  ADD PRIMARY KEY (`logid`);

--
-- Indexes for table `mst_categories`
--
ALTER TABLE `mst_categories`
  ADD PRIMARY KEY (`categoryid`);

--
-- Indexes for table `mst_clients`
--
ALTER TABLE `mst_clients`
  ADD PRIMARY KEY (`clientid`);

--
-- Indexes for table `mst_goals`
--
ALTER TABLE `mst_goals`
  ADD PRIMARY KEY (`goal_id`);

--
-- Indexes for table `mst_levels`
--
ALTER TABLE `mst_levels`
  ADD PRIMARY KEY (`level_id`);

--
-- Indexes for table `mst_options`
--
ALTER TABLE `mst_options`
  ADD PRIMARY KEY (`option_id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexes for table `mst_questions`
--
ALTER TABLE `mst_questions`
  ADD PRIMARY KEY (`question_id`),
  ADD KEY `topic_id` (`topic_id`),
  ADD KEY `level_id` (`level_id`);

--
-- Indexes for table `mst_topics`
--
ALTER TABLE `mst_topics`
  ADD PRIMARY KEY (`topic_id`);

--
-- Indexes for table `trn_answers`
--
ALTER TABLE `trn_answers`
  ADD PRIMARY KEY (`answerid`);

--
-- Indexes for table `trn_attempts`
--
ALTER TABLE `trn_attempts`
  ADD PRIMARY KEY (`attemptid`);

--
-- Indexes for table `trn_user_consent`
--
ALTER TABLE `trn_user_consent`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `error_log`
--
ALTER TABLE `error_log`
  MODIFY `logid` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `mst_categories`
--
ALTER TABLE `mst_categories`
  MODIFY `categoryid` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `mst_clients`
--
ALTER TABLE `mst_clients`
  MODIFY `clientid` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `mst_goals`
--
ALTER TABLE `mst_goals`
  MODIFY `goal_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `mst_levels`
--
ALTER TABLE `mst_levels`
  MODIFY `level_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `mst_options`
--
ALTER TABLE `mst_options`
  MODIFY `option_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=551;

--
-- AUTO_INCREMENT for table `mst_questions`
--
ALTER TABLE `mst_questions`
  MODIFY `question_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=247;

--
-- AUTO_INCREMENT for table `mst_topics`
--
ALTER TABLE `mst_topics`
  MODIFY `topic_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `trn_answers`
--
ALTER TABLE `trn_answers`
  MODIFY `answerid` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=396;

--
-- AUTO_INCREMENT for table `trn_attempts`
--
ALTER TABLE `trn_attempts`
  MODIFY `attemptid` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `trn_user_consent`
--
ALTER TABLE `trn_user_consent`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userid` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
