-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 22, 2026 at 08:37 PM
-- Server version: 5.7.44-48
-- PHP Version: 8.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `liammcke_inventory_recipes`
--

-- --------------------------------------------------------

--
-- Table structure for table `Favorites`
--

CREATE TABLE `Favorites` (
  `favorite_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `rating` int(11) DEFAULT NULL,
  `notes` text COLLATE utf8_unicode_ci,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Favorites`
--

INSERT INTO `Favorites` (`favorite_id`, `recipe_id`, `date_added`, `rating`, `notes`, `user_id`) VALUES
(1, 1, '2025-01-11 00:30:00', 5, 'Family favorite, make every Sunday.', 1),
(2, 4, '2025-02-14 18:00:00', 4, 'Great for taco night. Add jalapeños next time.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Grocery_List`
--

CREATE TABLE `Grocery_List` (
  `list_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `unit` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `is_purchased` tinyint(1) NOT NULL DEFAULT '0',
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Grocery_List`
--

INSERT INTO `Grocery_List` (`list_id`, `ingredient_id`, `quantity`, `unit`, `is_purchased`, `user_id`) VALUES
(1, 5, 400.00, 'grams', 0, 1),
(2, 10, 500.00, 'grams', 0, 1),
(3, 11, 6.00, 'count', 1, 1),
(4, 8, 3.00, 'count', 0, 1),
(5, 6, 2.00, 'count', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Ingredients`
--

CREATE TABLE `Ingredients` (
  `ingredient_id` int(11) NOT NULL,
  `ingredient_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `default_unit` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Ingredients`
--

INSERT INTO `Ingredients` (`ingredient_id`, `ingredient_name`, `default_unit`) VALUES
(1, 'Spaghetti', 'grams'),
(2, 'Eggs', 'count'),
(3, 'Pancetta', 'grams'),
(4, 'Parmesan Cheese', 'grams'),
(5, 'Chicken Breast', 'grams'),
(6, 'Bell Pepper', 'count'),
(7, 'Soy Sauce', 'ml'),
(8, 'Avocado', 'count'),
(9, 'Sourdough Bread', 'slices'),
(10, 'Ground Beef', 'grams'),
(11, 'Tortillas', 'count'),
(12, 'Romaine Lettuce', 'grams'),
(13, 'Feta Cheese', 'grams'),
(14, 'Olive Oil', 'ml');

-- --------------------------------------------------------

--
-- Table structure for table `Inventory`
--

CREATE TABLE `Inventory` (
  `inventory_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `unit` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `expiration_date` date DEFAULT NULL,
  `date_opened` date DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Inventory`
--

INSERT INTO `Inventory` (`inventory_id`, `ingredient_id`, `quantity`, `unit`, `expiration_date`, `date_opened`, `user_id`) VALUES
(1, 1, 500.00, 'grams', '2025-12-01', NULL, 1),
(2, 2, 12.00, 'count', '2025-03-15', '2025-03-01', 1),
(3, 4, 200.00, 'grams', '2025-04-01', '2025-03-01', 1),
(4, 14, 500.00, 'ml', '2026-01-01', '2025-02-01', 1),
(5, 7, 300.00, 'ml', '2025-11-01', '2025-01-15', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Nutritional_Values`
--

CREATE TABLE `Nutritional_Values` (
  `nutrition_id` int(11) NOT NULL,
  `ingredient_id` int(11) DEFAULT NULL,
  `recipe_id` int(11) DEFAULT NULL,
  `entity_type` enum('ingredient','recipe') COLLATE utf8_unicode_ci NOT NULL,
  `calories` decimal(8,2) DEFAULT NULL,
  `protein` decimal(8,2) DEFAULT NULL,
  `carbs` decimal(8,2) DEFAULT NULL,
  `sugar` decimal(8,2) DEFAULT NULL,
  `fat` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Nutritional_Values`
--

INSERT INTO `Nutritional_Values` (`nutrition_id`, `ingredient_id`, `recipe_id`, `entity_type`, `calories`, `protein`, `carbs`, `sugar`, `fat`) VALUES
(1, 1, NULL, 'ingredient', 3.50, 0.13, 0.71, 0.00, 0.01),
(2, 2, NULL, 'ingredient', 1.55, 0.13, 0.01, 0.00, 0.11),
(3, 4, NULL, 'ingredient', 4.00, 0.36, 0.00, 0.00, 0.29),
(4, 5, NULL, 'ingredient', 1.65, 0.31, 0.00, 0.00, 0.04),
(5, 8, NULL, 'ingredient', 1.60, 0.02, 0.09, 0.00, 0.15),
(6, 10, NULL, 'ingredient', 2.50, 0.26, 0.00, 0.00, 0.15),
(7, NULL, 1, 'recipe', 650.00, 35.00, 60.00, 2.00, 25.00),
(8, NULL, 2, 'recipe', 420.00, 48.00, 15.00, 5.00, 12.00),
(9, NULL, 3, 'recipe', 310.00, 14.00, 28.00, 2.00, 18.00),
(10, NULL, 4, 'recipe', 580.00, 38.00, 30.00, 3.00, 28.00),
(11, NULL, 5, 'recipe', 220.00, 8.00, 12.00, 4.00, 16.00);

-- --------------------------------------------------------

--
-- Table structure for table `Recipes`
--

CREATE TABLE `Recipes` (
  `recipe_id` int(11) NOT NULL,
  `recipe_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `instructions` text COLLATE utf8_unicode_ci,
  `image_url` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_api` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_fetched` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_favorited` tinyint(1) NOT NULL DEFAULT '0',
  `cache_priority` enum('favorite','recently_used','temporary') COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Recipes`
--

INSERT INTO `Recipes` (`recipe_id`, `recipe_name`, `instructions`, `image_url`, `source_api`, `last_fetched`, `is_favorited`, `cache_priority`) VALUES
(1, 'Spaghetti Carbonara', 'Boil pasta. Fry pancetta. Mix eggs and cheese. Combine all.', 'https://img.example.com/carbonara.jpg', 'Spoonacular', '2026-02-22 12:22:03', 1, 'favorite'),
(2, 'Chicken Stir Fry', 'Chop vegetables. Cook chicken. Add sauce and stir fry together.', 'https://img.example.com/stirfry.jpg', 'Spoonacular', '2026-02-22 12:22:03', 0, 'recently_used'),
(3, 'Avocado Toast', 'Toast bread. Mash avocado. Season and top with eggs.', 'https://img.example.com/avotoast.jpg', 'Edamam', '2026-02-22 12:22:03', 0, 'temporary'),
(4, 'Beef Tacos', 'Brown beef. Season with spices. Fill tortillas with toppings.', 'https://img.example.com/tacos.jpg', 'Spoonacular', '2026-02-22 12:22:03', 1, 'favorite'),
(5, 'Greek Salad', 'Chop vegetables. Add olives and feta. Dress with olive oil.', 'https://img.example.com/greeksalad.jpg', 'Edamam', '2026-02-22 12:22:03', 0, 'recently_used');

-- --------------------------------------------------------

--
-- Table structure for table `Recipe_Ingredients`
--

CREATE TABLE `Recipe_Ingredients` (
  `recipe_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `unit` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Recipe_Ingredients`
--

INSERT INTO `Recipe_Ingredients` (`recipe_id`, `ingredient_id`, `quantity`, `unit`) VALUES
(1, 1, 200.00, 'grams'),
(1, 2, 3.00, 'count'),
(1, 3, 100.00, 'grams'),
(1, 4, 50.00, 'grams'),
(2, 5, 300.00, 'grams'),
(2, 6, 2.00, 'count'),
(2, 7, 30.00, 'ml'),
(3, 2, 2.00, 'count'),
(3, 8, 1.00, 'count'),
(3, 9, 2.00, 'slices'),
(4, 10, 250.00, 'grams'),
(4, 11, 3.00, 'count'),
(5, 12, 150.00, 'grams'),
(5, 13, 60.00, 'grams'),
(5, 14, 20.00, 'ml');

-- --------------------------------------------------------

--
-- Table structure for table `Recipe_Tags`
--

CREATE TABLE `Recipe_Tags` (
  `recipe_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `date_tagged` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Recipe_Tags`
--

INSERT INTO `Recipe_Tags` (`recipe_id`, `tag_id`, `date_tagged`) VALUES
(1, 1, '2026-02-22 12:22:03'),
(1, 3, '2026-02-22 12:22:03'),
(2, 2, '2026-02-22 12:22:03'),
(2, 3, '2026-02-22 12:22:03'),
(3, 2, '2026-02-22 12:22:03'),
(3, 4, '2026-02-22 12:22:03'),
(4, 3, '2026-02-22 12:22:03'),
(4, 5, '2026-02-22 12:22:03'),
(5, 2, '2026-02-22 12:22:03'),
(5, 4, '2026-02-22 12:22:03');

-- --------------------------------------------------------

--
-- Table structure for table `Tags`
--

CREATE TABLE `Tags` (
  `tag_id` int(11) NOT NULL,
  `tag_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(7) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Tags`
--

INSERT INTO `Tags` (`tag_id`, `tag_name`, `color`) VALUES
(1, 'Italian', '#009246'),
(2, 'Quick', '#F4A261'),
(3, 'High Protein', '#E63946'),
(4, 'Vegetarian', '#2A9D8F'),
(5, 'Mexican', '#E9C46A');

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`user_id`, `name`, `password`) VALUES
(1, 'liam', 'hashed_password_123'),
(2, 'testuser', 'hashed_password_456');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Favorites`
--
ALTER TABLE `Favorites`
  ADD PRIMARY KEY (`favorite_id`),
  ADD UNIQUE KEY `recipe_id` (`recipe_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Grocery_List`
--
ALTER TABLE `Grocery_List`
  ADD PRIMARY KEY (`list_id`),
  ADD KEY `ingredient_id` (`ingredient_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Ingredients`
--
ALTER TABLE `Ingredients`
  ADD PRIMARY KEY (`ingredient_id`),
  ADD UNIQUE KEY `ingredient_name` (`ingredient_name`);

--
-- Indexes for table `Inventory`
--
ALTER TABLE `Inventory`
  ADD PRIMARY KEY (`inventory_id`),
  ADD KEY `ingredient_id` (`ingredient_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Nutritional_Values`
--
ALTER TABLE `Nutritional_Values`
  ADD PRIMARY KEY (`nutrition_id`),
  ADD KEY `ingredient_id` (`ingredient_id`),
  ADD KEY `recipe_id` (`recipe_id`);

--
-- Indexes for table `Recipes`
--
ALTER TABLE `Recipes`
  ADD PRIMARY KEY (`recipe_id`);

--
-- Indexes for table `Recipe_Ingredients`
--
ALTER TABLE `Recipe_Ingredients`
  ADD PRIMARY KEY (`recipe_id`,`ingredient_id`),
  ADD KEY `ingredient_id` (`ingredient_id`);

--
-- Indexes for table `Recipe_Tags`
--
ALTER TABLE `Recipe_Tags`
  ADD PRIMARY KEY (`recipe_id`,`tag_id`),
  ADD KEY `tag_id` (`tag_id`);

--
-- Indexes for table `Tags`
--
ALTER TABLE `Tags`
  ADD PRIMARY KEY (`tag_id`),
  ADD UNIQUE KEY `tag_name` (`tag_name`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Favorites`
--
ALTER TABLE `Favorites`
  MODIFY `favorite_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Grocery_List`
--
ALTER TABLE `Grocery_List`
  MODIFY `list_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Ingredients`
--
ALTER TABLE `Ingredients`
  MODIFY `ingredient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `Inventory`
--
ALTER TABLE `Inventory`
  MODIFY `inventory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Nutritional_Values`
--
ALTER TABLE `Nutritional_Values`
  MODIFY `nutrition_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `Recipes`
--
ALTER TABLE `Recipes`
  MODIFY `recipe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Tags`
--
ALTER TABLE `Tags`
  MODIFY `tag_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Favorites`
--
ALTER TABLE `Favorites`
  ADD CONSTRAINT `Favorites_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `Recipes` (`recipe_id`),
  ADD CONSTRAINT `Favorites_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

--
-- Constraints for table `Grocery_List`
--
ALTER TABLE `Grocery_List`
  ADD CONSTRAINT `Grocery_List_ibfk_1` FOREIGN KEY (`ingredient_id`) REFERENCES `Ingredients` (`ingredient_id`),
  ADD CONSTRAINT `Grocery_List_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

--
-- Constraints for table `Inventory`
--
ALTER TABLE `Inventory`
  ADD CONSTRAINT `Inventory_ibfk_1` FOREIGN KEY (`ingredient_id`) REFERENCES `Ingredients` (`ingredient_id`),
  ADD CONSTRAINT `Inventory_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

--
-- Constraints for table `Nutritional_Values`
--
ALTER TABLE `Nutritional_Values`
  ADD CONSTRAINT `Nutritional_Values_ibfk_1` FOREIGN KEY (`ingredient_id`) REFERENCES `Ingredients` (`ingredient_id`),
  ADD CONSTRAINT `Nutritional_Values_ibfk_2` FOREIGN KEY (`recipe_id`) REFERENCES `Recipes` (`recipe_id`);

--
-- Constraints for table `Recipe_Ingredients`
--
ALTER TABLE `Recipe_Ingredients`
  ADD CONSTRAINT `Recipe_Ingredients_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `Recipes` (`recipe_id`),
  ADD CONSTRAINT `Recipe_Ingredients_ibfk_2` FOREIGN KEY (`ingredient_id`) REFERENCES `Ingredients` (`ingredient_id`);

--
-- Constraints for table `Recipe_Tags`
--
ALTER TABLE `Recipe_Tags`
  ADD CONSTRAINT `Recipe_Tags_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `Recipes` (`recipe_id`),
  ADD CONSTRAINT `Recipe_Tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `Tags` (`tag_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
