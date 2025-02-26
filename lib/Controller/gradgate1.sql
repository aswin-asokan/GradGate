-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 24, 2024 at 09:25 AM
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
-- Database: `gradgate1`
--

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

CREATE TABLE `applications` (
  `application_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `job_id` int(11) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `response` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `applications`
--

INSERT INTO `applications` (`application_id`, `student_id`, `job_id`, `status`, `response`) VALUES
(5, 4, 20, 'selected', 'accepted'),
(7, 9, 20, 'selected', 'waiting..'),
(12, 9, 15, 'selected', 'accepted'),
(14, 9, 17, 'applied', 'waiting..'),
(15, 10, 21, 'selected', 'accepted');

-- --------------------------------------------------------

--
-- Table structure for table `colleges`
--

CREATE TABLE `colleges` (
  `clg_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `college_name` text DEFAULT NULL,
  `location` text DEFAULT NULL,
  `phone` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `colleges`
--

INSERT INTO `colleges` (`clg_id`, `user_id`, `college_name`, `location`, `phone`) VALUES
(1, 107, 'Mar Athanasius College of Engineering', 'kothamangalam', '98567536'),
(2, 115, 'GEC THRISSUR', 'Thrissur', '969852471'),
(3, 118, 'GEC PALAKKAD', 'Palakkad,Kerala,India', '9879685364'),
(4, 126, 'Marian College of Engineering', 'Ernakulam,Kerala', '985674236');

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
(31, 102, 'info@feathersoft.com', 'Feathersoft', 'IT', 'Fort Kochi, Kochi, Ernakulam, Kerala, 682001, India', '[{\"insert\":\"Sophisticated Software Development company\\n\"}]', '9638527410', 'https://webixytech.com/admin_panel/assets/project_images/1625120256What_is_an_IT_company.jpg'),
(32, 103, 'contact@softturn.com', 'Softturn', 'IT', 'Taxi, Klay, Bomi County, Liberia', '[{\"insert\":\"General description with IT focus\\n\"}]', '2579564578', 'https://www.megahubhk.com/wp-content/uploads/2015/07/Final-Company-Background-Image.jpg'),
(33, 104, 'support@logictech.it', 'LogicTech', ' IT Services', ' Pesaro e Urbino, Marche, Italia', '[{\"insert\":\" Product-based company\\n\"}]', '8745964789', 'https://www.megahubhk.com/wp-content/uploads/2015/07/Final-Company-Background-Image.jpg'),
(34, 105, 'contact@infosis.com', 'Infosis', 'IT Service', 'Ernakulam, Kerala, India', '[{\"insert\":\" Better Quality Products\\n\"}]', '8571354789', 'https://www.businessinsider.in/photo/51495462/Heres-Indias-top-IT-company-Infosys-giving-you-10-grea'),
(35, 106, 'info@loominol.com', 'Loominol', 'Digital Marketing', ' Pune City, Pune, Maharashtra, India', '[{\"insert\":\"Digital Marketing Company\\n\"}]', '8529374586', 'https://media.glassdoor.com/o/ce/f6/7f/93/infosys-mysore-campus.jpg');

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
(15, 31, 'Software Developer', '[{\"insert\":\"\\n\"}]', 50000, 'Full Time', 'CSE', 'Software Developer', '2024-11-20 00:00:00', 'Active'),
(16, 32, 'IT Support Specialist', '[{\"insert\":\"\\n\"}]', 60000, 'Full Time', 'CSE', 'IT Support Specialist', '2024-11-13 00:00:00', 'Active'),
(17, 33, ' Data Analyst', '[{\"insert\":\"\\n\"}]', 65000, 'Full Time', 'CSE', ' Data Analyst', '2024-11-12 00:00:00', 'Active'),
(18, 34, ' DevOps Engineer', '[{\"insert\":\"\\n\"}]', 50000, 'Full Time', 'DS', ' DevOps Engineer', '2024-11-28 00:00:00', 'Active'),
(19, 35, ' Cybersecurity Analyst', '[{\"insert\":\"\\n\"}]', 67000, 'Full Time', 'CSE', ' Cybersecurity Analyst', '2024-11-20 00:00:00', 'Active'),
(20, 33, 'HR manager', '[{\"insert\":\"\\n\"}]', 60000, 'Full Time', 'CSE,AIML,DS', 'HR manager', '2024-10-31 00:00:00', 'Active'),
(21, 31, 'Marketing Manager', '[{\"insert\":\"Communication Skills, field work\\n\"}]', 65000, 'Full Time', 'AIML,DS,EC', 'Marketing Manager', '2024-10-31 00:00:00', 'Active'),
(22, 35, 'Project Manager', '[{\"insert\":\"As a project manager, you have to be aware of a project’s potential for profit or loss and the decisions that could lead to either. Throughout the project, you should be attuned to the stakeholders’ measures of success and how each person’s decisions and actions could contribute to—or detract from—achieving those aims.\\r\\n\\r\\nYou should understand your company’s (or the department’s) risk tolerance—do they have a budget dedicated to experimentation, or does every project need to yield a profit? With that framework, you can mediate decisions about the project’s timeline, resources and goals.\\n\"}]', 55000, 'Full Time', 'CSE,AIML,DS,EC,EEE', 'Project Manager', '2024-11-30 00:00:00', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `app_id` int(11) DEFAULT 0,
  `name` text DEFAULT NULL,
  `phone` varchar(15) NOT NULL,
  `coll_id` int(11) NOT NULL,
  `department` varchar(20) NOT NULL,
  `salary` int(11) NOT NULL DEFAULT 0,
  `about` text DEFAULT NULL,
  `imgUrl` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `user_id`, `app_id`, `name`, `phone`, `coll_id`, `department`, `salary`, `about`, `imgUrl`) VALUES
(4, 112, 5, 'Jia', '98765496', 1, 'CSE', 0, '[{\"insert\":\"Location: Pune, India\\nSkills:\\n\\nProficient in Python, R, and SQL for data analysis.\\nExperience with machine learning libraries (e.g., TensorFlow, Scikit-learn).\\n\"}]', 'https://i.pinimg.com/originals/3e/37/a1/3e37a1bd45c70cb972bf95105ba4adc6.jpg'),
(5, 119, 0, 'Sonakshi', '963863596', 2, 'CSE', 0, '[{\"insert\":\"Analytical skills: identifying a problem and coming up with a technological solution to address it.\\r\\nProblem-solving skills: the ability to solve complex problems in a systematic and logical way.\\r\\nCreativity: the ability to think outside the box and come up with innovative solutions.\\n\"}]', 'https://static.vecteezy.com/system/resources/previews/024/354/297/non_2x/business-woman-isolated-illustration-ai-generative-free-photo.jpg'),
(8, 122, 0, 'Pooja PP', '9856324789', 1, 'CSE', 0, '[{\"insert\":\"You should be familiar with the different data analysis concepts such as artificial intelligence. Similarly, you should be adept at data visualization as it would help you share your findings with other team members.\\r\\n\\r\\nData visualization helps you share your results with the stakeholders and non-technical members of your organization.\\n\"}]', 'https://img.freepik.com/premium-photo/woman-sits-desk-with-laptop-plant-background_1007866-105.jpg'),
(9, 123, 12, 'Bineesha KP', '9874563210', 1, 'CSE', 0, '[{\"insert\":\"Passionate BTech CSE Student | Aspiring Software Developer | Exploring AI and Full-Stack Development | Tech Enthusiast with a Growth Mindset\\n\"}]', 'https://www.cumanagement.com/sites/default/files/2023-07/young-woman-career-brand.jpg'),
(10, 124, 15, 'anna irene ditto', '7464839389', 1, 'DS', 0, '[{\"insert\":\"i am enthusiastic coder.\\n\"}]', 'https://i.pinimg.com/originals/e6/78/4b/e6784b9cd722d02e014d7e60ebe25e39.jpg'),
(11, 125, 0, 'Maria', '986574231', 1, 'DS', 0, '[{\"insert\":\"languages known.php,mysql,html ,python\\n\"}]', 'https://i.pinimg.com/originals/3e/37/a1/3e37a1bd45c70cb972bf95105ba4adc6.jpg');

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
(102, 'info@feathersoft.com', '$2y$10$p5.5c69XXAMGkIiB9NdA6efA475N.X5ZvFK2qc3zacyG4DzF8xxg.', 'Employer'),
(103, 'contact@softturn.com', '$2y$10$/0ROwEXcR5JraJm9T6926.1gfLcb0tQkzJ1jUXwxtb3IwnKuPKO4G', 'Employer'),
(104, 'support@logictech.it', '$2y$10$xc6JCpua0yrgIIB4.Id0senMy38T/A/BCQOX9hJwvZ1mtroIWrB7i', 'Employer'),
(105, 'contact@infosis.com', '$2y$10$y6Ohk6KPm711I7KxVwO1i.0lmRZCd482WJh79ixF9u2c0vK8EMUKG', 'Employer'),
(106, 'info@loominol.com', '$2y$10$V/OoafUu2s1b4tcYfBvyYuq8Wcw8iZuN2lJdghP0Dp9ry1..KG35S', 'Employer'),
(107, 'mace@gmail.com', '$2y$10$5bZL6tHqdQYd7MhE66Ut9.qPv1pMr3ZhPqM0oVTAojc.LIhEyS/v.', 'College'),
(112, 'jio@gmail.com', '$2y$10$Ki17eBLeGOewwLLUPLRvdesoJwkZLmia7FRo3OdqW7oMs.HMa9VW.', 'Student'),
(115, 'gectcr@gmail.com', '$2y$10$qT8nwOoF9bQr8C1SfJZNOeh1Yu70zB6Z54oFOJ3VDW5EvsDDtsTs2', 'College'),
(116, 'geckd@gmail.com', '$2y$10$PL7HuBxt9TGuGYAGo1sphe6mUQaZTbbn/xoKxsjnTMtOm5z0hAWgC', 'College'),
(118, 'gecpkd@gmail.com', '$2y$10$9gUL9DGOWLUqPH8InDlVJerykJKFUdsH0GL7pgd9iIHM14aEqGzQi', 'College'),
(119, 'sona@gmail.com', '$2y$10$Kj.QHZUqx97uusYNT1xRm.RUGcxN7NIskxOOdjprJxPId2eX0dtga', 'Student'),
(122, 'poojapp@gmail.com', '$2y$10$y2J6Pu8I.kac1iCskbIRwuEWTXfoMTaFMDIJ5iFODy4kXwrZsQyB.', 'Student'),
(123, 'bineesha@gmail.com', '$2y$10$zDyUScx2iP.hws/eTKom7O2ZLIsxlv2WwQqYiq45CQpxTc1/9Hum.', 'Student'),
(124, 'annairene2004@gmail.com', '$2y$10$.LS1NKCAU8kGOFS.mzfVlum0Ydz6woEDk/sv8YGy68NW.SdZNOLDq', 'Student'),
(125, 'marian@gmail.com', '$2y$10$WhWdP0BHm20GHW0ZxCfZmuORe9lGGNe5t2BVfsxMEO7Kkt4m1WQ4G', 'Student'),
(126, 'mariancollege@gmail.com', '$2y$10$eymzCUp7p/HveQ/etQWOtu.NhrscjEUXVD0sY6HeRd773DS/jSWfy', 'College');

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
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `colleges`
--
ALTER TABLE `colleges`
  MODIFY `clg_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `employer`
--
ALTER TABLE `employer`
  MODIFY `eid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `job_postings`
--
ALTER TABLE `job_postings`
  MODIFY `job_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

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
