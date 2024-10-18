-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 18, 2024 at 11:43 AM
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
-- Database: `gradgate`
--

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

CREATE TABLE `applications` (
  `application_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `job_id` int(11) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `colleges`
--

CREATE TABLE `colleges` (
  `clg_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `college_name` text DEFAULT NULL,
  `location` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employer`
--

CREATE TABLE `employer` (
  `eid` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `e_mail` varchar(100) NOT NULL,
  `company_name` varchar(100) NOT NULL,
  `industry_type` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL,
  `about` text NOT NULL,
  `e_phone` varchar(12) NOT NULL,
  `imgUrl` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employer`
--

INSERT INTO `employer` (`eid`, `user_id`, `e_mail`, `company_name`, `industry_type`, `location`, `about`, `e_phone`, `imgUrl`) VALUES
(19, 58, 'bini@gmail.com', 'feathersoft', 'IT', 'Fort Kochi, Kochi, Ernakulam, Kerala, 682001, India', '[{\"insert\":\"Sophisticate Software Development company\\n\"}]', '369852741', 'https://imgv3.fotor.com/images/gallery/AI-3D-Female-Profile-Picture.jpg'),
(20, 59, 'fsd@ghf.fd', 'dfs', 'sdf', 'Línea D, Lavalle, Microcentro, San Nicolás, Buenos Aires, Comuna 1, Ciudad Autónoma de Buenos Aires,', '[{\"insert\":\"ghasdhs\\n\"}]', '12365498', 'https://thumbs.dreamstime.com/b/profile-picture-caucasian-male-employee-posing-office-happy-young-wo'),
(21, 60, 'anu@gmail.com', 'softturn', 'IT', 'Taxi, Klay, Bomi County, Liberia', '', '36985274', 'https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/profile-photos-4.jpg'),
(22, 69, 'lal@gmail.com', 'sdsdf', 'sdsf', 'sdff', '[{\"insert\":\"dsfs\\n\"}]', '369852425', 'assets/images/no-profile-picture-15258 (1).png'),
(23, 70, 'op@gmail.com', 'sdqwe', 'wqeq', 'wedwe', '', '36985247', 'assets/images/no-profile-picture-15258 (1).png'),
(24, 77, 'kiya@gmail.com', 'asdaasdas', 'asdas', 'sadd', '[{\"insert\":\"xasca\\n\"}]', '36985247', 'assets/images/no-profile-picture-15258 (1).png'),
(25, 78, 'lini@gmail.com', 'infosis', 'IT service', 'Ernakulam, Kerala, India', '[{\"insert\":\"Better Quality pdct\\n\"}]', '9638527410', 'https://th.bing.com/th/id/OIP.Q8Ijt8KzH4fuTfsAvBW8lwHaE7?rs=1&pid=ImgDetMain');

-- --------------------------------------------------------

--
-- Table structure for table `job_postings`
--

CREATE TABLE `job_postings` (
  `job_id` int(11) NOT NULL,
  `emp_id` int(11) DEFAULT NULL,
  `job_title` text DEFAULT NULL,
  `job_description` text DEFAULT NULL,
  `salary` int(11) NOT NULL,
  `job_type` varchar(30) NOT NULL,
  `department` varchar(150) NOT NULL,
  `requirements` text DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `status` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job_postings`
--

INSERT INTO `job_postings` (`job_id`, `emp_id`, `job_title`, `job_description`, `salary`, `job_type`, `department`, `requirements`, `end_date`, `status`) VALUES
(1, 21, 'it', '[{\"insert\":\"xasca\\n\"}]', 5000, 'it', 'gfhgfg,fcgh,hg', 'dfasfs', '2024-10-30 00:53:20', 'active'),
(2, 21, 'sdsds1', 'sdsds2', 5000, 'sdsds3', 'sdsds4', 'sdsds5', '2024-10-30 00:53:20', 'Active'),
(9, 21, 'testing job', '[{\"insert\":\"\\n\"}]', 50000, 'Full Time', 'CSE,DS', 'testing job', '2024-10-24 00:00:00', 'Active'),
(10, 21, 'testing job', '[{\"insert\":\"\\n\"}]', 50000, 'Full Time', 'CSE,DS', 'testing job', '2024-10-24 00:00:00', 'Active'),
(11, 19, 'marketing ', '[{\"insert\":\"\\n\"}]', 20000, 'Full Time', 'CSE,DS,CE,EC', 'marketing ', '2024-10-31 00:00:00', 'Active'),
(12, 25, 'Test Engineer', '[{\"insert\":\"\\n\"}]', 35000, 'Full Time', 'CSE,AIML,DS,EC', 'Test Engineer', '2024-10-31 00:00:00', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `job_id` int(11) DEFAULT NULL,
  `name` text DEFAULT NULL,
  `skills` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `mail` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `mail`, `password`, `user_type`) VALUES
(58, 'bini@gmail.com', '$2y$10$GjIKiXZQGW/oAb7z2BD3ceqqg46bt4142LkEB53Btce4QqnVc.8qW', 'Employer'),
(59, 'fsd@ghf.fd', '$2y$10$suVag8hJKu2fnSITaLBG3OyL2sD9xNYS30mJdtLHbOxCYZMkXWaTq', 'Employer'),
(60, 'anu@gmail.com', '$2y$10$7AgvAZXHhJwk5k7hphJv1uryQseKYp4mi35EWQNUywnc4TUp44pp.', 'Employer'),
(61, 'hari@gmail.com', '$2y$10$SjU/XnE4blicasxuik74Pe82IH9i8RmP.nrJEeWu/fW0fFV2SrnG6', 'Employer'),
(62, 'rini@gmail.com', '$2y$10$PTLJHPR1XMbbkcq2amZ4ze3qDbLsSC06fF4vutkc4zzIIJFOpmIKu', 'Employer'),
(63, 'tinu@gmail.com', '$2y$10$2pitloGF8SBnajBErZZtRusF/wekAW5RTjcDteFiL0cBSwFG3zcde', 'Employer'),
(64, 'sda@d.fd', '$2y$10$AoBlZNXXoeE7YGE5mq0cHuAnmwQ1EJLMZgi/7BIM0U6FxG5/sfl2y', 'Employer'),
(65, 'nini@dg.sl', '$2y$10$hozZVgoUOqv7qia7xnWZ1e4L3.ssIU6XsM7vMciy70KZ8LUlxIndG', 'Employer'),
(66, 'pp@gmail.com', '$2y$10$0W2ATYV/XoRD2y8twisda.MfYAbIgwEwD.4sqwPfN2YguYuDqW.mG', 'Employer'),
(67, 'lilly@gmail.com', '$2y$10$nW4BmOfDTntX3AVKQC42Puo/G9AG4UwaCXQrhY.43csYa2VWQ26nm', 'Employer'),
(68, 'sini@gmail.com', '$2y$10$ztNKQSmImsvS1rZD6y3XNOrgdsO9jcIBVoYWt7bEjgjh5z.cmo8PC', 'Employer'),
(69, 'lal@gmail.com', '$2y$10$/k1tl8fuusjpfdvEonc6L.HJnacNSXR4HhNsRlqD.PmtytDGR2fiy', 'Employer'),
(70, 'op@gmail.com', '$2y$10$Cry6O/8TBxSgwAmH6ddMPuiU41fbaqo1Ec6V0/1phESWhhHZheG7C', 'Employer'),
(71, 'lal@gmail.com', '$2y$10$R0tfCJf6X8WBlOfoW5yId.fDmFwepPn6KAPCJDQjZQ2/pA40coX5O', 'Employer'),
(72, 'lal@gmail.com', '$2y$10$gpKIY42zJeAk3teOhCc40..xwmG7fyyKcJZGc8Sp7O5K/1I/CLTE.', 'Employer'),
(73, 'lal@gmail.com', '$2y$10$cLcOdvAPeHthdTtBK0sI2OM.qji2dhptocsrfWBu.WNj8fEv9ikcK', 'Employer'),
(74, 'lal@gmail.com', '$2y$10$m7s2kZmH92a2xJs.GcIkoOXEDNE3D4q8ZzXblq7sbjOQpmH6Een6u', 'Employer'),
(75, 'lal@gmail.com', '$2y$10$qksH6LEy.7IpeZkDb/FCNuYtp5.ejhqwkJbszlBASuKgQ9txT.9B6', 'Employer'),
(76, 'lal@gmail.com', '$2y$10$XAKzmi7Up3qCxYdhyk3Uc.8TwxSOctRGYiUqhHkGY/FeCzll5lNHe', 'Employer'),
(77, 'kiya@gmail.com', '$2y$10$0PL1qmxZ9RyYjm3fRISGw.3VEoalFsx1KvU3POjzHCuQJ0gtNtY7S', 'Employer'),
(78, 'lini@gmail.com', '$2y$10$LBlGDqMVDDpGmXAsQROScuf1Trl92UBHsvPJm7LCgwi1h0dd5YliK', 'Employer');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`application_id`),
  ADD KEY `job_id` (`job_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `colleges`
--
ALTER TABLE `colleges`
  ADD PRIMARY KEY (`clg_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `employer`
--
ALTER TABLE `employer`
  ADD PRIMARY KEY (`eid`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `job_postings`
--
ALTER TABLE `job_postings`
  ADD PRIMARY KEY (`job_id`),
  ADD KEY `emp_id` (`emp_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `colleges`
--
ALTER TABLE `colleges`
  MODIFY `clg_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employer`
--
ALTER TABLE `employer`
  MODIFY `eid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `job_postings`
--
ALTER TABLE `job_postings`
  MODIFY `job_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applications`
--
ALTER TABLE `applications`
  ADD CONSTRAINT `applications_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `job_postings` (`job_id`),
  ADD CONSTRAINT `applications_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);

--
-- Constraints for table `colleges`
--
ALTER TABLE `colleges`
  ADD CONSTRAINT `colleges_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `employer`
--
ALTER TABLE `employer`
  ADD CONSTRAINT `employer_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `job_postings`
--
ALTER TABLE `job_postings`
  ADD CONSTRAINT `job_postings_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employer` (`eid`);

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
