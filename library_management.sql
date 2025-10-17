-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Oct 17, 2025 at 05:06 PM
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
-- Database: `library_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `book_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) DEFAULT NULL,
  `genre` varchar(100) DEFAULT NULL,
  `publisher` varchar(255) DEFAULT NULL,
  `year_published` int(11) DEFAULT NULL,
  `total_copies` int(11) DEFAULT 1,
  `available_copies` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`book_id`, `title`, `author`, `genre`, `publisher`, `year_published`, `total_copies`, `available_copies`) VALUES
(1, 'Book 1', 'Author C', 'Adventure', 'Publisher Y', 1994, 8, 8),
(2, 'Book 2', 'Author C', 'Science', 'Publisher X', 2005, 5, 5),
(3, 'Book 3', 'Author D', 'Fiction', 'Publisher X', 2021, 6, 6),
(4, 'Book 4', 'Author D', 'Science', 'Publisher X', 2016, 3, 3),
(5, 'Book 5', 'Author E', 'Education', 'Publisher Y', 2006, 6, 6),
(6, 'Book 6', 'Author B', 'Biography', 'Publisher X', 1998, 10, 10),
(7, 'Book 7', 'Author A', 'Romance', 'Publisher X', 1994, 6, 6),
(8, 'Book 8', 'Author E', 'Mystery', 'Publisher Z', 1998, 10, 10),
(9, 'Book 9', 'Author C', 'Romance', 'Publisher Z', 2012, 5, 5),
(10, 'Book 10', 'Author D', 'Fiction', 'Publisher Y', 2016, 5, 5),
(11, 'Book 11', 'Author E', 'Science', 'Publisher Y', 2001, 10, 10),
(12, 'Book 12', 'Author B', 'History', 'Publisher Z', 1997, 9, 9),
(13, 'Book 13', 'Author A', 'Mystery', 'Publisher X', 2005, 5, 5),
(14, 'Book 14', 'Author C', 'History', 'Publisher X', 2003, 7, 7),
(15, 'Book 15', 'Author A', 'Science', 'Publisher Z', 2021, 3, 3),
(16, 'Book 16', 'Author E', 'Mystery', 'Publisher Z', 2003, 4, 4),
(17, 'Book 17', 'Author B', 'Adventure', 'Publisher Y', 2022, 7, 7),
(18, 'Book 18', 'Author C', 'Fiction', 'Publisher Z', 2020, 2, 2),
(19, 'Book 19', 'Author A', 'Adventure', 'Publisher X', 1998, 4, 4),
(20, 'Book 20', 'Author D', 'Horror', 'Publisher Y', 1998, 7, 7),
(21, 'Book 21', 'Author B', 'Horror', 'Publisher X', 2002, 5, 5),
(22, 'Book 22', 'Author E', 'Horror', 'Publisher Y', 1994, 8, 8),
(23, 'Book 23', 'Author C', 'Biography', 'Publisher X', 2019, 4, 4),
(24, 'Book 24', 'Author C', 'Fiction', 'Publisher X', 1996, 4, 4),
(25, 'Book 25', 'Author A', 'Adventure', 'Publisher X', 2010, 9, 9),
(26, 'Book 26', 'Author E', 'Adventure', 'Publisher X', 2012, 10, 10),
(27, 'Book 27', 'Author A', 'Biography', 'Publisher Z', 2006, 9, 9),
(28, 'Book 28', 'Author C', 'History', 'Publisher Y', 2016, 8, 8),
(29, 'Book 29', 'Author B', 'Biography', 'Publisher X', 2014, 6, 6),
(30, 'Book 30', 'Author A', 'Science', 'Publisher Z', 2003, 10, 10),
(33, 'DBMS', 'xyz', 'Education', 'abc', 2030, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `borrowed_books`
--

CREATE TABLE `borrowed_books` (
  `borrow_id` int(11) NOT NULL,
  `book_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `borrow_date` date DEFAULT curdate(),
  `due_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `returned` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `borrowed_books`
--

INSERT INTO `borrowed_books` (`borrow_id`, `book_id`, `user_id`, `borrow_date`, `due_date`, `return_date`, `returned`) VALUES
(1, 21, 9, '2025-04-20', '2025-05-04', '2025-04-28', 1),
(2, 15, 3, '2025-05-04', '2025-05-18', NULL, 0),
(3, 8, 11, '2025-04-21', '2025-05-05', NULL, 0),
(4, 21, 13, '2025-05-07', '2025-05-21', NULL, 0),
(5, 20, 4, '2025-05-11', '2025-05-25', '2025-05-20', 1),
(6, 28, 9, '2025-05-16', '2025-05-30', NULL, 0),
(7, 21, 14, '2025-05-04', '2025-05-18', '2025-05-15', 1),
(8, 18, 15, '2025-04-21', '2025-05-05', '2025-05-10', 1),
(9, 27, 2, '2025-05-09', '2025-05-23', NULL, 0),
(10, 5, 19, '2025-04-25', '2025-05-09', '2025-04-27', 1);

-- --------------------------------------------------------

--
-- Table structure for table `damaged_books`
--

CREATE TABLE `damaged_books` (
  `damage_id` int(11) NOT NULL,
  `book_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `report_date` date DEFAULT curdate(),
  `damage_description` text DEFAULT NULL,
  `penalty_amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `damaged_books`
--

INSERT INTO `damaged_books` (`damage_id`, `book_id`, `user_id`, `report_date`, `damage_description`, `penalty_amount`) VALUES
(1, 14, 3, '2025-05-18', 'Damage report 1', 8.47),
(2, 28, 18, '2025-05-18', 'Damage report 2', 19.58),
(3, 8, 4, '2025-05-18', 'Damage report 3', 15.82),
(4, 15, 7, '2025-05-18', 'Damage report 4', 7.34),
(5, 30, 18, '2025-05-18', 'Damage report 5', 17.63);

-- --------------------------------------------------------

--
-- Table structure for table `registered_users`
--

CREATE TABLE `registered_users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `join_date` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `registered_users`
--

INSERT INTO `registered_users` (`user_id`, `name`, `email`, `phone`, `join_date`) VALUES
(1, 'User 1', 'user1@example.com', '1234567891', '2025-05-18'),
(2, 'User 2', 'user2@example.com', '1234567892', '2025-05-18'),
(3, 'User 3', 'user3@example.com', '1234567893', '2025-05-18'),
(4, 'User 4', 'user4@example.com', '1234567894', '2025-05-18'),
(5, 'User 5', 'user5@example.com', '1234567895', '2025-05-18'),
(6, 'User 6', 'user6@example.com', '1234567896', '2025-05-18'),
(7, 'User 7', 'user7@example.com', '1234567897', '2025-05-18'),
(8, 'User 8', 'user8@example.com', '1234567898', '2025-05-18'),
(9, 'User 9', 'user9@example.com', '1234567899', '2025-05-18'),
(10, 'User 10', 'user10@example.com', '1234567890', '2025-05-18'),
(11, 'User 11', 'user11@example.com', '1234567891', '2025-05-18'),
(12, 'User 12', 'user12@example.com', '1234567892', '2025-05-18'),
(13, 'User 13', 'user13@example.com', '1234567893', '2025-05-18'),
(14, 'User 14', 'user14@example.com', '1234567894', '2025-05-18'),
(15, 'User 15', 'user15@example.com', '1234567895', '2025-05-18'),
(16, 'User 16', 'user16@example.com', '1234567896', '2025-05-18'),
(17, 'User 17', 'user17@example.com', '1234567897', '2025-05-18'),
(18, 'User 18', 'user18@example.com', '1234567898', '2025-05-18'),
(19, 'User 19', 'user19@example.com', '1234567899', '2025-05-18'),
(20, 'User 20', 'user20@example.com', '1234567890', '2025-05-18'),
(23, 'Sumedh V Prabhu', 'eng23cs0470@dsu.edu.in', '9852636738', '2025-05-20');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `name`, `email`, `role`, `username`, `password`) VALUES
(1, 'Staff 1', 'staff1@library.com', 'Librarian', 'staff1', 'pass1'),
(2, 'Staff 2', 'staff2@library.com', 'Assistant', 'staff2', 'pass2'),
(3, 'Staff 3', 'staff3@library.com', 'Assistant', 'staff3', 'pass3'),
(4, 'Staff 4', 'staff4@library.com', 'Librarian', 'staff4', 'pass4'),
(5, 'Staff 5', 'staff5@library.com', 'Manager', 'staff5', 'pass5');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`book_id`);

--
-- Indexes for table `borrowed_books`
--
ALTER TABLE `borrowed_books`
  ADD PRIMARY KEY (`borrow_id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `damaged_books`
--
ALTER TABLE `damaged_books`
  ADD PRIMARY KEY (`damage_id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `registered_users`
--
ALTER TABLE `registered_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `borrowed_books`
--
ALTER TABLE `borrowed_books`
  MODIFY `borrow_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `damaged_books`
--
ALTER TABLE `damaged_books`
  MODIFY `damage_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `registered_users`
--
ALTER TABLE `registered_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `borrowed_books`
--
ALTER TABLE `borrowed_books`
  ADD CONSTRAINT `borrowed_books_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `borrowed_books_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `registered_users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `damaged_books`
--
ALTER TABLE `damaged_books`
  ADD CONSTRAINT `damaged_books_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `damaged_books_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `registered_users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
