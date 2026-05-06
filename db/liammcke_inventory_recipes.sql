-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 06, 2026 at 08:57 AM
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
(9, 22, '2026-04-29 14:36:23', NULL, NULL, 5),
(10, 16, '2026-04-29 15:01:32', NULL, NULL, 1);

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
(11, 43, 2.00, 'cups', 1, 5),
(12, 91, 0.50, 'cup', 1, 5),
(13, 92, 4.00, 'tablespoons', 1, 5),
(14, 93, 3.00, 'tablespoons', 1, 5),
(15, 94, 1.00, 'teaspoon', 1, 5),
(16, 95, 3.00, 'servings', 1, 5),
(18, 14, 1.00, 'tsp', 1, 6),
(19, 30, 10.00, 'ounce', 1, 6),
(20, 35, 0.25, 'cup', 1, 6),
(21, 43, 3.00, 'Tbsp', 1, 6),
(22, 51, 0.25, 'tsp', 1, 6),
(23, 69, 15.00, 'ounce', 1, 6),
(24, 70, 2.00, 'tsp', 1, 6),
(25, 71, 0.50, 'tsp', 1, 6),
(26, 72, 4.00, 'dashes', 1, 6),
(27, 73, 0.50, 'cup', 1, 6),
(29, 35, 1.00, 'small', 1, 1),
(31, 37, 2.00, 'stalks', 1, 1),
(33, 141, 1.00, 'lb', 1, 1);

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
(14, 'Olive Oil', 'ml'),
(15, 'dashi', 'ounce'),
(16, 'agghg', '3'),
(17, 'sundried tomatoes', 'ounces'),
(18, 'Ground beef (80/20)', 'lbs'),
(19, 'Egg', 'count'),
(20, 'breadcrumbs', 'c'),
(21, 'Garlic (to taste)', 'count'),
(22, 'Herbs (whatever you have)', 'count'),
(23, 'BBQ Sauce', 'count'),
(24, 'Grape Jelly', 'count'),
(25, 'additional toppings: avocado', 'servings'),
(26, 'carrots', 'medium'),
(27, 'celery stalks', ''),
(28, 'flat leaf parsley', 'cup'),
(29, 'garlic', 'cloves'),
(30, 'canned tomatoes', 'ounce'),
(31, 'lentils', 'cups'),
(32, 'salt and pepper', 'servings'),
(33, 'turnip', 'large'),
(34, 'vegetable stock', 'cups'),
(35, 'onion', 'medium'),
(36, 'beef broth', 'oz'),
(37, 'celery', 'stalks'),
(38, 'cream of mushroom soup', 'oz'),
(39, 'green onions', ''),
(40, 'new potatoes', ''),
(41, 'dale&apos;s seasoning', 'cup'),
(42, 'stew meat', 'pounds'),
(43, 'water', 'cups'),
(44, 'brown rice', 'cups'),
(45, 'celery seed', 'teaspoon'),
(46, 'kidney beans', 'cups'),
(47, 'marjoram', 'teaspoon'),
(48, 'thyme', 'teaspoons'),
(49, 'eggplant', 'medium'),
(50, 'green beans', 'handfuls'),
(51, 'ground pepper', 'servings'),
(52, 'ground sage', 'teaspoons'),
(53, 'liquid smoke', 'teaspoon'),
(54, 'sea salt', 'teaspoons'),
(55, 'sriracha', 'teaspoon'),
(56, 'tomatoes', 'medium'),
(57, 'cashews', 'cup'),
(58, 'dried cherries', 'cup'),
(59, 'dried chickpeas', 'cups'),
(60, 'dried thyme', 'teaspoon'),
(61, 'ground cumin', 'teaspoon'),
(62, 'honey', 'tablespoons'),
(63, 'juice of orange', ''),
(64, 'quinoa', 'cups'),
(65, 'red wine vinegar', 'teaspoons'),
(66, 'sea-salt', 'servings'),
(67, 'sun-dried tomatoes', 'cup'),
(68, 'turmeric', 'teaspoon'),
(69, 'black beans', 'ounce'),
(70, 'chili powder', 'tsp'),
(71, 'cumin', 'tsp'),
(72, 'optional: of hot sauce', 'dashes'),
(73, 'rice', 'cup'),
(74, 'almond milk', 'cup'),
(75, 'baby spinach', 'cups'),
(76, 'banana', ''),
(77, 'mango', 'cup'),
(78, 'almonds', 'g'),
(79, 'cocoa', 'g'),
(80, 'chocolate of at least cocoa parts', 'g'),
(81, 'cream', 'ml'),
(82, 'peanuts', 'g'),
(83, 'rum', 'Tbs'),
(84, 'sugar', 'g'),
(85, 'cacao powder', 'tablespoons'),
(86, 'chia seeds', 'tablespoons'),
(87, 'coconut milk', 'tablespoon'),
(88, 'psyllium husk', 'teaspoon'),
(89, 'stevia', 'packets'),
(90, 'vanilla protein powder', 'scoop'),
(91, 'maple syrup', 'cup'),
(92, 'corn flour', 'tablespoons'),
(93, 'cocoa powder', 'tablespoons'),
(94, 'vanilla', 'teaspoon'),
(95, 'roasted hazelnuts', 'servings'),
(96, 'cherries', 'cup'),
(97, 'oat flour', 'cups'),
(98, 'grind cornmeal', 'cup'),
(99, 'baking powder', 'teaspoons'),
(100, 'baking soda', 'teaspoon'),
(101, 'salt', 'teaspoon'),
(102, 'ground nutmeg', 'teaspoon'),
(103, 'ground ginger', 'teaspoons'),
(104, 'walnuts', 'cup'),
(105, 'agave nectar', 'cup'),
(106, 'applesauce', 'cup'),
(107, 'yogurt', 'cup'),
(108, 'vanilla extract', 'teaspoons'),
(109, 'breakfast sausage patties', 'oz'),
(110, 'scallions', ''),
(111, 'veggies', 'cup'),
(112, 'sharp cheddar', 'cup'),
(113, 'salsa', 'Tablespoons'),
(114, 'wipe out the pan. add some olive oil and set over medium-low heat. pour in the whisked eggs', 'serving'),
(115, 'bake', 'serving'),
(116, 'this is one breakfast', 'serving'),
(117, 'this recipe is a contest entry', 'serving'),
(118, 'what do your kids like to eat', 'serving'),
(119, 'chillies', 'medium'),
(120, 'cinnamon powder', 'teaspoon'),
(121, 'coriander', 'cup'),
(122, 'cumin seeds', 'teaspoons'),
(123, 'curry leaves', ''),
(124, 'lemon juice or', 'tablespoon'),
(125, 'mung beans', 'cups'),
(126, 'mustard seeds', 'teaspoon'),
(127, 'sunflower oil', 'tablespoon'),
(128, 'tomato', 'medium'),
(129, 'baking potatoes', ''),
(130, 'butter', 'tablespoons'),
(131, 'cilantro', 'bunch'),
(132, 'curry', 'tablespoons'),
(133, 'fennel powder', 'teaspoon'),
(134, 'garam masala', 'teaspoon'),
(135, 'ginger', 'teaspoon'),
(136, 'lamb stew meat', 'pounds'),
(137, 'mushrooms', 'ounces'),
(138, 'oregano', 'tablespoon'),
(139, 'rosemary', 'tablespoon'),
(140, 'tomato paste', 'can'),
(141, 'equivalent amount of a ground beef/bulk sausage mix', 'lb'),
(142, 'ricotta', 'cup'),
(143, 'basil', 'pinch'),
(144, 'pasta sauce', 'oz'),
(145, 'pizza sauce', 'can'),
(146, 'pepper flakes', 'tsp'),
(147, 'pepperoni', ''),
(148, 'mozzarella', 'cups'),
(149, 'aged provolone', 'cup'),
(150, 'herbed parmesan drop biscuits', 'servings'),
(151, 'additional parmesan cheese', 'servings'),
(152, 'baking mix', 'cup'),
(153, 'seasoning', 'tsp'),
(154, 'milk', 'cup'),
(155, 'or', 'serving'),
(156, 'oreo cookies 3 cups', ''),
(157, 'cream cheese', 'package'),
(158, 'semi baking chocolate', 'oz'),
(159, 'candy corn', 'servings'),
(160, 'candy eyes', 'servings'),
(161, 'icing', 'servings'),
(162, 'red beans', 'beans'),
(163, 'asparagus', 'bag'),
(164, 'evoo', 'T'),
(165, 'peas', 'c'),
(166, 'vegetable broth', 'box'),
(167, 'grapeseed oil', 'tablespoons'),
(168, 'coconut oil', 'tablespoons'),
(169, 'cauliflower', 'head'),
(170, 'broccoli', 'cups'),
(171, 'sesame oil', 'teaspoons'),
(172, 'sesame seeds', 'servings'),
(173, 'additional scallion tops', 'servings'),
(174, 'you can use regular basil', 'cup'),
(175, 'boston lettuce', 'small head'),
(176, 'chili pepper', 'small'),
(177, 'fish sauce', 'cup'),
(178, 'coriander leaves', 'cup'),
(179, 'lime juice', 'tablespoons'),
(180, 'mint leaves', 'cup'),
(181, 'rice vinegar', 'cup'),
(182, 'shrimp', 'large'),
(183, 'spring roll wrappers', '8-inch'),
(184, 'nuoc cham', 'servings'),
(185, 'balsamic vinegar', 'teaspoon'),
(186, 'corn', 'cup'),
(187, 'black-eyed peas', 'cups'),
(188, 'curry powder', 'teaspoons'),
(189, 'globe', 'large'),
(190, 'ground coriander', 'teaspoon'),
(191, 'ground mustard powder', 'teaspoon'),
(192, 'juice of lemon', ''),
(193, 'chilies', ''),
(194, 'shallots', ''),
(195, 'swiss chard', 'bunch'),
(196, 'natural almond butter', 'tablespoons'),
(197, 'baby kale', 'cup'),
(198, 'mango pieces', 'cup'),
(199, 'matcha tea powder', 'tablespoon'),
(200, 'pineapple', 'cup'),
(201, 'butternut squash', 'large'),
(202, 'goat cheese', 'oz'),
(203, 'liquid egg substitute', 'cup'),
(204, 'non-fat milk', 'tbsp'),
(205, 'chives', 'T'),
(206, 't cream', ''),
(207, 'orange pepper', 'cup'),
(208, 'cheddar cheese', 'cup'),
(209, 'flour', 'cups'),
(210, 'powdered milk', 'tablespoon'),
(211, 'warm water', 'ml'),
(212, 'yeast', 'teaspoon'),
(213, 'bananas', ''),
(214, 'peanut butter', 'cup'),
(215, 'strawberries', 'cup');

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
(3, 4, 200.00, 'grams', '2025-04-01', '2025-03-01', 1),
(5, 7, 300.00, 'ml', '2025-11-01', '2025-01-15', 1),
(6, 8, 3.00, 'count', NULL, NULL, 1),
(7, 6, 2.00, 'count', NULL, NULL, 1),
(9, 10, 500.00, 'grams', NULL, '2026-04-29', 1),
(10, 11, 6.00, 'count', NULL, NULL, 1),
(14, 17, 8.00, 'ounces', '2027-12-12', NULL, 3),
(16, 18, 2.00, 'lbs', NULL, NULL, 1),
(18, 20, 1.00, 'c', NULL, NULL, 1),
(19, 29, 2.00, 'cloves', NULL, NULL, 1),
(20, 93, 3.00, 'tablespoons', NULL, NULL, 5),
(21, 92, 4.00, 'tablespoons', NULL, NULL, 5),
(22, 91, 0.50, 'cup', NULL, NULL, 5),
(23, 95, 3.00, 'servings', NULL, NULL, 5),
(24, 94, 1.00, 'teaspoon', NULL, NULL, 5),
(25, 43, 2.00, 'cups', NULL, NULL, 5),
(26, 14, 2.00, 'tablespoons', NULL, NULL, 1),
(27, 162, 6.00, 'beans', '2026-04-30', NULL, 6),
(28, 69, 15.00, 'ounce', NULL, NULL, 6),
(29, 30, 10.00, 'ounce', NULL, NULL, 6),
(30, 70, 2.00, 'tsp', NULL, NULL, 6),
(31, 71, 0.50, 'tsp', NULL, NULL, 6),
(32, 51, 0.25, 'tsp', NULL, NULL, 6),
(33, 14, 1.00, 'tsp', NULL, NULL, 6),
(34, 35, 0.25, 'cup', NULL, NULL, 6),
(35, 72, 4.00, 'dashes', NULL, NULL, 6),
(36, 73, 0.50, 'cup', NULL, NULL, 6),
(37, 43, 3.00, 'Tbsp', NULL, NULL, 6),
(38, 36, 14.50, 'oz', NULL, NULL, 1),
(39, 26, 2.00, 'large', NULL, NULL, 1),
(40, 38, 26.00, 'oz', NULL, NULL, 1),
(41, 35, 1.00, 'small', NULL, NULL, 1),
(42, 37, 2.00, 'stalks', NULL, NULL, 1),
(43, 141, 1.00, 'lb', NULL, NULL, 1);

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
  `user_id` int(11) DEFAULT NULL,
  `recipe_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `instructions` text COLLATE utf8_unicode_ci,
  `image_url` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_api` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_fetched` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cache_priority` enum('favorite','recently_used','temporary') COLLATE utf8_unicode_ci NOT NULL,
  `serving_size` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Recipes`
--

INSERT INTO `Recipes` (`recipe_id`, `user_id`, `recipe_name`, `instructions`, `image_url`, `source_api`, `last_fetched`, `cache_priority`, `serving_size`) VALUES
(1, 1, 'Spaghetti Carbonara', 'Boil pasta. Fry pancetta. Mix eggs and cheese. Combine all.', 'https://img.example.com/carbonara.jpg', 'Spoonacular', '2026-02-22 12:22:03', 'favorite', 1),
(2, 1, 'Chicken Stir Fry', 'Chop vegetables. Cook chicken. Add sauce and stir fry together.', 'https://img.example.com/stirfry.jpg', 'Spoonacular', '2026-02-22 12:22:03', 'recently_used', 1),
(3, 1, 'Avocado Toast', 'Toast bread. Mash avocado. Season and top with eggs.', 'https://img.example.com/avotoast.jpg', 'Edamam', '2026-02-22 12:22:03', 'temporary', 1),
(4, 1, 'Beef Tacos', 'Brown beef. Season with spices. Fill tortillas with toppings.', 'https://img.example.com/tacos.jpg', 'Spoonacular', '2026-02-22 12:22:03', 'favorite', 1),
(5, 1, 'Greek Salad', 'Chop vegetables. Add olives and feta. Dress with olive oil.', 'https://img.example.com/greeksalad.jpg', 'Edamam', '2026-02-22 12:22:03', 'recently_used', 1),
(13, 1, 'meatloaf', 'Step 1.  Preheat oven to 375F\nStep 2. Mix all ingredients in a bowl\nStep 3. Form into loaf on a baking sheet\nStep 4. Brush on BBQ sauce\nStep 5.  Bake until internal temp is at least 165F', NULL, 'User', '2026-04-29 01:29:59', '', 6),
(14, 1, 'Red Lentil Soup with Chicken and Turnips', '1. To a large dutch oven or soup pot, heat the olive oil over medium heat.\n2. Add the onion, carrots and celery and cook for 8-10 minutes or until tender, stirring occasionally.\n3. Add the garlic and cook for an additional 2 minutes, or until fragrant. Season conservatively with a pinch of salt and black pepper.To the pot, add the tomatoes, turnip and red lentils. Stir to combine. Stir in the vegetable stock and increase the heat on the stove to high. Bring the soup to a boil and then reduce to a simmer. Simmer for 20 minutes or until the turnips are tender and the lentils are cooked through.\n4. Add the chicken breast and parsley. Cook for an additional 5 minutes. Adjust seasoning to taste.\n5. Serve the soup immediately garnished with fresh parsley and any additional toppings. Enjoy!', 'https://img.spoonacular.com/recipes/715415-556x370.jpg', 'Spoonacular', '2026-04-29 01:51:22', '', 1),
(15, 1, 'Slow Cooker Beef Stew', '1. To get started, heat your slow cooker to low.\n2. Pour in the cream of mushroom soup, Dale&apos;s seasoning, water, and beef broth and stir until mixed well.\n3. Add in your stew meat, potatoes, onions, carrots, celery, and green onions. Stir well until covered and cook on low for 8 hours. You can add salt and pepper as desired, but the flavors and the Dale&apos;s marry together so well that you probably won’t need them.', 'https://img.spoonacular.com/recipes/715446-556x370.jpg', 'Spoonacular', '2026-04-29 01:51:22', '', 1),
(16, 1, 'Red Kidney Bean Jambalaya', '1. Rinse the kidney beans and brown rice separately. Cover the kidney beans with water and soak for 8 hours or overnight. In a separate bowl, cover the brown rice with water and soak for 8 hours or overnight.\n2. Drain and rinse the kidney beans, then transfer to a medium saucepan and cover with fresh water. Bring to a boil, reduce heat to medium-low, cover, and simmer for 1 hour or until just tender but not falling apart.\n3. Drain and set aside.\n4. Heat the oil in a large saucepan over medium heat. When hot, add the onion and saut for 5 minutes. Now add the garlic, carrots, celery and green beans, and stir for another 5 minutes. Next add the tomatoes, red pepper, eggplant, sage, thyme, marjoram and celery seed, and continue to stir for another few minutes.\n5. Pour in the vegetable stock, liquid smoke, rice and the cooked kidney beans. Bring to a boil, reduce heat to medium low, cover, and cook, stirring occasionally, for 45 minutes or until the rice is tender.\n6. Add water as necessary if the stew becomes too dry.Season with sriracha, salt and pepper, and taste for seasoning  add more liquid smoke, sriracha, salt, pepper or herbs as desired.', 'https://img.spoonacular.com/recipes/782601-556x370.jpg', 'Spoonacular', '2026-04-29 01:51:22', '', 1),
(17, 1, 'Quinoa and Chickpea Salad with Sun-Dried Tomatoes and Dried Cherries', '1. Rinse the quinoa and soak for 8 hours or overnight in 2 cups of water. Rinse the chickpeas and soak for 8 hours or overnight in several inches of water.Rinse the chickpeas and transfer to a small saucepan. Cover with fresh water and bring to a boil. Reduce heat to medium-low, cover, and simmer for 1 hour or until buttery soft.While the chickpeas are cooking, soak the sun-dried tomatoes in hot water for 30 minutes, then drain and chop. Meanwhile, bring the quinoa to a boil in a medium saucepan. Reduce heat to the lowest setting, cover, and simmer for 15 minutes or until the water is absorbed.\n2. Remove from heat and wait 5 minutes before fluffing with a fork.Meanwhile, toast the cashews in a dry unoiled skillet or saucepan over medium-low heat, tossing or stirring frequently, for 10 minutes until browned.\n3. Transfer the chickpeas, quinoa, sun-dried tomatoes, cashews and dried cherries to a large mixing bowl.\n4. Whisk the dressing ingredients together and pour over the salad. Stir to combine and serve at room temperature or chilled.', 'https://img.spoonacular.com/recipes/716004-556x370.jpg', 'Spoonacular', '2026-04-29 01:51:22', '', 1),
(18, 1, 'Easy Homemade Rice and Beans', '1. Heat the olive oil in a large pot over medium heat.\n2. Add onions and saute until soft, or for about 5 minutes.\n3. Add all other remaining ingredients and stir together. Increase the heat to medium high and bring to a boil. Cover and reduce heat to medium low so that the mixture simmers. Cook for 15-20 minutes, or until rice is fluffy and liquid is absorbed.*\n4. Serve with salsa, cheese, and sour cream.', 'https://img.spoonacular.com/recipes/716627-556x370.jpg', 'Spoonacular', '2026-04-29 01:51:22', '', 1),
(19, 5, 'Green Monster Ice Pops', '1. Place all ingredients into a blender and mix well.Taste the smoothie. If you find that it is not sweet enough, add 1 to 2 tablespoons of maple syrup or honey into the smoothie and blend.\n2. Pour smoothie into the ice pop molds. Insert a wooden popsicle stick into the mold, leaving about a quarter of the stick above the mold.\n3. Place the molds into the freezer for 2-3 hours to let freeze before serving.', 'https://img.spoonacular.com/recipes/645479-556x370.jpg', 'Spoonacular', '2026-04-29 14:35:36', '', 1),
(20, 5, 'Caramel Peanut Fudge Cake', '1. For the sponge, beat egg yolks with sugar for 3-4 minutes until the mixture doubles in volume and becomes pale yellow.\n2. Whisk the egg whites until soft peaks form.Fold the egg whites gently into the egg yolks cream.Gently stir in almonds and cocoa.Lightly butter and flour a 20 round cake pan, line with parchment paper.\n3. Pour in the sponge mixture\n4. Bake in preheated oven at 180C for about 20 minutes or until done (the trick with a toothpick).Leave the cake to cool completely in the cake pan, then carefully remove it and split into two layers.For the caramel cream heat sugar and water over medium heat and cook, stirring occasionally, until the sugar dissolves and comes to a boil. Continue cooking, but without stirring, until mixture becomes golden amber in color.\n5. Remove from flame and set aside.Whip the cream, gradually stir in the caramel syrup.\n6. Add peanuts, stir and combine.\n7. Mixture must be smooth (at first it will foam up a little).\n8. Transfer the cream to a bowl to cool down to room temperature and thicken.For the ganache bring the cream just to a boil over medium-high heat; pour over chocolate.\n9. Let stand 10 minutes. Stir very gently for 3-4 minutes until smooth and glossy, incorporating the cream steadily, without overworking.Cool ganache for an hour or until completely chilled, then beat for 2-3 minutes or until it becomes fluffy and lighter in color. Do not overbeat because it will become too thick and not spreadable.To assemble the cake, first sprinkle each cake layer with half of the rum and water syrup.\n10. Spread the caramel cream over the bottom layer, cover with the top layer (wet side down).Immediately spread ganache over top and sides of cake.', 'https://img.spoonacular.com/recipes/637016-556x370.jpg', 'Spoonacular', '2026-04-29 14:35:36', '', 1),
(21, 5, 'Cacao chia pudding with avocado mousse', '1. Add the chia seeds and psyllium in and slowly stir whilst adding the remainder almond milk. Put in the fridge overnight or for a few hours for the pudding to grow.for the mousse place the remainder ingredients in a blender and blend untill it becomes a thick mousse like consistancy.Take the premade cacao chia pudding and place in a glass bowltop with the avocado mousse', 'https://img.spoonacular.com/recipes/636676-556x370.jpg', 'Spoonacular', '2026-04-29 14:35:36', '', 1),
(22, 5, 'Chocolate Pudding - Rave Diet', '1. Combine water, maple syrup, cocoa, cornstarch or corn flour and vanilla together in a saucepan.\n2. Whisk smooth with a spoon or hand whisker.\n3. Cook over medium heat and stir constantly until pudding is very thick.\n4. Pour into dessert dishes and top with chopped hazelnuts.\n5. Cool and serve.', 'https://img.spoonacular.com/recipes/639177-556x370.jpg', 'Spoonacular', '2026-04-29 14:35:36', '', 1),
(23, 5, 'Fresh Cherry Scones', '1. Cut cherries in half and pit them (or use a cherry pitter).\n2. Place the cherries in a freezer-safe container and freeze for at least 3 hours prior to baking the scones. This ensures the cherries dont pop in the dough while theyre baking.\n3. In a Kitchen\n4. Aid (with the wire whisk attachment) or food processor, add the oat flour, cornmeal, baking powder, baking soda, nutmeg, ginger and salt.\n5. Mix or pulse to combine dry ingredients. In a bowl, combine the applesauce, yogurt, vanilla extract and agave nectar.  Stir to combine Very slowly pour the wet ingredients into the mixer with the dry ingredients about a quarter of a cup at a time (similar idea to making pie crust), mixing on medium speed. Once all the wet ingredients are combined with the dry, add chopped walnuts and mix until integrated into the dough. Taking the dough in your hands, form it into a disc shape. Refrigerate in a sealable container or plastic wrap for 1 hour.\n6. Preheat the oven to 375 degrees. Using a bread knife, cut the dough in half horizontally like you would a bun.\n7. Place half of the frozen cherries on one of the dough halves then place the other half of the dough on top. Press the dough halves together to seal the cherries in.  Press the remaining frozen cherries into the top of the dough. Using a serrated knife, cut diagonals into the dough in order to create eight triangles. Arrange on a parchment paper-lined baking sheet (be sure to give the triangles enough space to bake evenly).\n8. Bake for 23 minutes or until the tops of the scones are golden brown.\n9. Serve with butter, jam, honey, or nutella.', 'https://img.spoonacular.com/recipes/643450-556x370.jpg', 'Spoonacular', '2026-04-29 14:35:36', '', 1),
(24, 1, 'Baked Whole Wheat Breakfast Quesadilla', '1. I know some of your kids have already returned to school. My son&apos;s first day (of second grade! When did he get so big?! He&apos;s practically a teenager!) isn&apos;t for a couple weeks. But I&apos;m already getting into back-to-school mode—like, how am I going to get this kid back on a regular sleeping schedule?!\n2. One thing I&apos;ve definitely got a handle on is breakfast. So when I was invited through The Daily Meal&apos;s Culinary Content Network to participate in the @Johnsonville #backtoschoolbreakfast contest, I knew I had to make some delicious breakfast quesadillas!\n3. These quesadillas are a fun and hearty dish that will give your kids loads of energy throughout the morning. Not only do the quesadillas provide plenty of protein, they&apos;ve also got fiber and carbs from the whole wheat tortillas, and Vitamin C in all the vegetables. It&apos;s a breakfast designed to be playful—but also incredibly satisfying. \n4. Ingredients\n5. serves 2-4\n6. whole wheat tortillas (8&quot;)\n7. breakfast sausage patties (about 3 oz.)\n8. eggs, whisked\n9. -3 scallions, chopped, white and green parts separated\n10. /3 cup chopped veggies (I used a combo of zucchini plus red and yellow bell peppers)\n11. cup shredded sharp cheddar\n12. Tablespoons salsa\n13. olive oil for the pan and for brushing on the tortillas\n14. Preheat oven to 450 degrees.\n15. Heat a skillet to medium. Break the sausages into small pieces and place in the heated pan; add scallions and the other vegetables. Cook until the crumbled meat is browned and the veggies have begun to get tender.\n16. Remove from the pan to a plate.\n17. Wipe out the pan.\n18. Add some olive oil and set over medium-low heat.\n19. Pour in the whisked eggs, stir gently until they are set, and remove from the heat.\n20. Brush oil (or use cooking spray) on one side of two of the tortillas; place them, oiled-side down on an ungreased baking sheet. Take half the cheese and sprinkle it over the two tortillas. Top that with a layer of eggs on each tortilla, a spoonful of salsa, and the sausage and vegetable mixture. Then top everything with the rest of the cheese.\n21. Place the last tortillas on top, press down gently, and then brush the top of the tortillas with oil.\n22. Bake for 8-10 minutes, or until golden brown and crispy.\n23. Cut into wedges.\n24. Serve with additional chopped scallions and peppers, and with a side of salsa for dipping.\n25. You can get most of this dish prepped ahead of time: chop all the veggies, shred the cheese, brown the meat—heck, you can even scramble the eggs! Then just assemble and bake the quesadillas while the kids are getting dressed for school. Super easy, I promise.\n26. This is one hearty breakfast!\n27. This recipe is a contest entry for a Johnsonville promotion. It is not a sponsored post. \n28. What do your kids like to eat for breakfast on school days?', 'https://img.spoonacular.com/recipes/679540-556x370.png', 'Spoonacular', '2026-04-29 15:02:28', '', 1),
(25, 1, 'Gujarati Dry Mung Bean Curry', '1. Wash the mung beans and boil them in plenty of hot water with a pinch of baking powder until al-dente. If you have a pressure cooker thats about 6-7 whistles.\n2. Drain and set aside.In a large pan heat the oil and add the mustard seeds (wait for them to pop) then add the cumin seeds, asafoetida, curry leaves, garlic and chillies. Saut until aromatic. Obviously dont let it burn.\n3. Add the tomatoes, turmeric and mung beans and cook for two minutes. Be careful not to mash it up as you stir.\n4. Add the salt, sugar, lemon juice and cinnamon powder and cook for a further two minutes.Throw in the chopped coriander, combine and serve.', 'https://img.spoonacular.com/recipes/646043-556x370.jpg', 'Spoonacular', '2026-04-29 15:02:28', '', 1),
(26, 1, 'Slow Cooker Lamb Curry', '1. Pull out your slow cooker and add everything into the pot with the exception of the yogurt.Now turn on your pot, setting it on low for the next 4-6 hours or high for the next 3-5.When the time is up, open up your slow cooker, grab your yogurt and stir it into the curry.\n2. Serve over rice.', 'https://img.spoonacular.com/recipes/660290-556x370.jpg', 'Spoonacular', '2026-04-29 15:02:28', '', 1),
(27, 1, 'Easy Cheesy Pizza Casserole', '1. Brown ground beef in skillet; drain fat.\n2. Mix in pasta or pizza sauce and pepper flakes; set aside.\n3. Mix ricotta cheese with the herbs and Parmesan in a separate bowl; set aside.\n4. Mix the dry ingredients for the biscuits.\n5. Add milk and stir until combined.\n6. Preheat oven to 375 degrees.  Spray a 13 x 9 pan with non-stick spray.  Drop biscuit dough by teaspoons in the bottom of pan, spacing evenly.  It&apos;s OK if there is space between the dough--it will expand as it&apos;s cooked.  Top with ground beef mixture and dot with the ricotta cheese mixture.\n7. Bake at 375 for about 20 min or until biscuits are puffed and beginning to get golden brown.\n8. Top with mozzarella and provolone cheeses and distribute pepperoni slices evenly over top, increase oven temperature to 425 degrees.  Return to oven and bake until cheeses are melted and beginning to bubble.  This should take about 10 minutes.\n9. Remove from oven and let stand 5 minutes before slicing and serving.  May be topped with the additional Parmesan cheese.', 'https://img.spoonacular.com/recipes/641893-556x370.jpg', 'Spoonacular', '2026-04-29 15:02:28', '', 1),
(28, 1, 'How to Make OREO Turkeys for Thanksgiving', '1. Take a package of OREO cookies and crush them up finely.\n2. Take softened cream cheese and mix well with cookie crumbs.\n3. Roll into one inch cookie balls, and then freeze for 10 minutes.\n4. Dip cookie balls into melted chocolate and place on a prepared cookie sheet covered with wax paper.\n5. Place into the refrigerator for 15 minutes to an hour before decorating.\n6. Add 5 candy corn to the back of the ball as tail feathers.\n7. Use icing as glue to attach the candy eyes.\n8. Cut one candy corn into pieces, using the white tip as the nose, and the orange part (cut in half) as feet.', 'https://img.spoonacular.com/recipes/715449-556x370.jpg', 'Spoonacular', '2026-04-29 15:02:28', '', 1),
(29, 6, 'Red Lentil Soup with Chicken and Turnips', '1. To a large dutch oven or soup pot, heat the olive oil over medium heat.\n2. Add the onion, carrots and celery and cook for 8-10 minutes or until tender, stirring occasionally.\n3. Add the garlic and cook for an additional 2 minutes, or until fragrant. Season conservatively with a pinch of salt and black pepper.To the pot, add the tomatoes, turnip and red lentils. Stir to combine. Stir in the vegetable stock and increase the heat on the stove to high. Bring the soup to a boil and then reduce to a simmer. Simmer for 20 minutes or until the turnips are tender and the lentils are cooked through.\n4. Add the chicken breast and parsley. Cook for an additional 5 minutes. Adjust seasoning to taste.\n5. Serve the soup immediately garnished with fresh parsley and any additional toppings. Enjoy!', 'https://img.spoonacular.com/recipes/715415-556x370.jpg', 'Spoonacular', '2026-04-29 15:09:11', '', 1),
(30, 6, 'Slow Cooker Beef Stew', '1. To get started, heat your slow cooker to low.\n2. Pour in the cream of mushroom soup, Dale&apos;s seasoning, water, and beef broth and stir until mixed well.\n3. Add in your stew meat, potatoes, onions, carrots, celery, and green onions. Stir well until covered and cook on low for 8 hours. You can add salt and pepper as desired, but the flavors and the Dale&apos;s marry together so well that you probably won’t need them.', 'https://img.spoonacular.com/recipes/715446-556x370.jpg', 'Spoonacular', '2026-04-29 15:09:11', '', 1),
(31, 6, 'Red Kidney Bean Jambalaya', '1. Rinse the kidney beans and brown rice separately. Cover the kidney beans with water and soak for 8 hours or overnight. In a separate bowl, cover the brown rice with water and soak for 8 hours or overnight.\n2. Drain and rinse the kidney beans, then transfer to a medium saucepan and cover with fresh water. Bring to a boil, reduce heat to medium-low, cover, and simmer for 1 hour or until just tender but not falling apart.\n3. Drain and set aside.\n4. Heat the oil in a large saucepan over medium heat. When hot, add the onion and saut for 5 minutes. Now add the garlic, carrots, celery and green beans, and stir for another 5 minutes. Next add the tomatoes, red pepper, eggplant, sage, thyme, marjoram and celery seed, and continue to stir for another few minutes.\n5. Pour in the vegetable stock, liquid smoke, rice and the cooked kidney beans. Bring to a boil, reduce heat to medium low, cover, and cook, stirring occasionally, for 45 minutes or until the rice is tender.\n6. Add water as necessary if the stew becomes too dry.Season with sriracha, salt and pepper, and taste for seasoning  add more liquid smoke, sriracha, salt, pepper or herbs as desired.', 'https://img.spoonacular.com/recipes/782601-556x370.jpg', 'Spoonacular', '2026-04-29 15:09:11', '', 1),
(32, 6, 'Quinoa and Chickpea Salad with Sun-Dried Tomatoes and Dried Cherries', '1. Rinse the quinoa and soak for 8 hours or overnight in 2 cups of water. Rinse the chickpeas and soak for 8 hours or overnight in several inches of water.Rinse the chickpeas and transfer to a small saucepan. Cover with fresh water and bring to a boil. Reduce heat to medium-low, cover, and simmer for 1 hour or until buttery soft.While the chickpeas are cooking, soak the sun-dried tomatoes in hot water for 30 minutes, then drain and chop. Meanwhile, bring the quinoa to a boil in a medium saucepan. Reduce heat to the lowest setting, cover, and simmer for 15 minutes or until the water is absorbed.\n2. Remove from heat and wait 5 minutes before fluffing with a fork.Meanwhile, toast the cashews in a dry unoiled skillet or saucepan over medium-low heat, tossing or stirring frequently, for 10 minutes until browned.\n3. Transfer the chickpeas, quinoa, sun-dried tomatoes, cashews and dried cherries to a large mixing bowl.\n4. Whisk the dressing ingredients together and pour over the salad. Stir to combine and serve at room temperature or chilled.', 'https://img.spoonacular.com/recipes/716004-556x370.jpg', 'Spoonacular', '2026-04-29 15:09:11', '', 1),
(33, 6, 'Easy Homemade Rice and Beans', '1. Heat the olive oil in a large pot over medium heat.\n2. Add onions and saute until soft, or for about 5 minutes.\n3. Add all other remaining ingredients and stir together. Increase the heat to medium high and bring to a boil. Cover and reduce heat to medium low so that the mixture simmers. Cook for 15-20 minutes, or until rice is fluffy and liquid is absorbed.*\n4. Serve with salsa, cheese, and sour cream.', 'https://img.spoonacular.com/recipes/716627-556x370.jpg', 'Spoonacular', '2026-04-29 15:09:11', '', 1),
(34, 1, 'Asparagus and Pea Soup: Real Convenience Food', '1. Chop the garlic and onions.\n2. Saute the onions in the EVOO, adding the garlic after a couple of minutes; cook until the onions are translucent.\n3. Add the whole bag of asparagus and cover everything with the broth. Season with salt and pepper and a pinch of red pepper flakes, if using.Simmer until the asparagus is bright green and tender (if you&apos;ve thawed the asparagus it will only take a couple of minutes). Turn off the heat and puree using an immersion blender.\n4. Add peas (the heat of the soup will quickly thaw them) and puree until smooth; add more until it reaches the thickness you like.Top with chives and a small dollop of creme fraiche or sour cream or greek yogurt.', 'https://img.spoonacular.com/recipes/716406-556x370.jpg', 'Spoonacular', '2026-04-29 15:15:12', '', 1),
(35, 1, 'Cauliflower, Brown Rice, and Vegetable Fried Rice', '1. Remove the cauliflower&apos;s tough stem and reserve for another use. Using a food processor, pulse cauliflower florets until they resemble rice or couscous. You should end up with around four cups of &quot;cauliflower rice.&quot;\n2. Heat 1T butter and 1T oil in a large skillet over medium heat.\n3. Add garlic and the white and light green pieces of scallion. Sauté about a minute.\n4. Add the cauliflower to the pan. Stir to coat with oil, then spread out in pan and let sit; you want it cook a bit and to caramelize (get a bit brown), which will bring out the sweetness. After a couple of minutes, stir and spread out again.\n5. Add cold rice (it separates easily, so it won&apos;t clump up during cooking), plus the additional grapeseed and coconut oil or butter. Raise heat to medium-high. Toss everything together and, again, spread the mixture out over the whole pan and press a bit into the bottom.\n6. Let it sit for about two minutes—so the rice can get toasted and a little crispy.\n7. Add the peas and broccoli and stir again.\n8. Drizzle soy sauce and toasted sesame oil over rice.Cook for another minute or so and turn off heat.\n9. Add chopped scallion tops and toss.I like to toast some sesame seeds in a dry pan; I sprinkle these and some more raw, chopped scallion over the top of the rice for added flavor and crunch.Season to taste with salt and, if you&apos;d like, more soy sauce. Keep in mind that if you&apos;re serving this with something salty and saucy (ie. teriyaki chicken) you may want to hold off on adding too much salt to the fried rice.', 'https://img.spoonacular.com/recipes/716426-556x370.jpg', 'Spoonacular', '2026-04-29 15:15:12', '', 1),
(36, 1, 'Easy To Make Spring Rolls', '1. Have all the ingredients ready for assembly. In a large bowl filled with water, dip a wrapper in the water. The rice wrapper will begin to soften and this is your cue to remove it from the water and lay it flat.\n2. Place 2 shrimp halves in a row across the center and top with basil, mint, cilantro and lettuce. Leave about 1 to 2 inches uncovered on each side.  Fold uncovered sides inward, then tightly roll the wrapper, beginning at the end with the lettuce.  Repeat with remaining wrappers and ingredients.\n3. Cut and serve at room temperature with dipping sauce.The Culinary Chases Note: The rice wrapper can be fussy to handle if you let it soak too long. I usually give it a couple of swishes in the water and then remove. It may feel slightly stiff but by the time you are ready to roll up, the wrapper will become very pliable.  A typical spring roll contains cooked rice vermicelli, slivers of cooked pork and julienned carrots but you can use whatever suits your fancy.  Enjoy!', 'https://img.spoonacular.com/recipes/642129-556x370.jpg', 'Spoonacular', '2026-04-29 15:15:12', '', 1),
(37, 1, 'Corn Avocado Salsa', '1. Preheat oven to 375 degrees.\n2. Spread corn flat on a baking sheet.Spray lightly with olive oil spray.Roast corn in the oven for about 8-10 minutes. (Be careful not to brown too much or burn.)\n3. Remove from heat and allow to cool.Finely chop red pepper and garlic and mix in a bowl.Peel and coarsely chop avocado and add to bowl.\n4. Add cooled corn.\n5. Mix in cumin and vinegar and blend well.', 'https://img.spoonacular.com/recipes/640062-556x370.jpg', 'Spoonacular', '2026-04-29 15:15:12', '', 1),
(38, 1, 'Spicy Black-Eyed Pea Curry with Swiss Chard and Roasted Eggplant', '1. Rinse the black-eyed peas and soak in several inches of water for 6 hours or overnight.\n2. Drain and rinse, then transfer to a large saucepan and cover with fresh water. Bring to a boil, reduce heat to medium-low, cover, and simmer for 40 to 60 minutes. Take care not to overcook  the beans should be tender but not be falling apart.\n3. Drain and set aside.To prepare the eggplant, cut of the stem and bottom edge and then cut in half lengthwise. Score the flesh into diagonal 1-inch lines, then turn and score again until you have a diagonal pattern. Take care not to cut through the skin.\n4. Sprinkle with some salt and let sit for 40 minutes. Rinse and squeeze out any excess water.\n5. Brush the eggplant with some oil and transfer to a roasting pan.\n6. Bake in a preheated 400 oven until the flesh appears collapsed and is wrinkly.\n7. Remove from heat and let cool for about 10 minutes, season with a bit of salt, and remove the flesh from the eggplant. If there is too much water, drain in a strainer. Set aside.\n8. Heat the oil over medium heat in the same saucepan used to cook the black-eyed peas. When hot, toss in the shallots and chilies and saut for 2 to 3 minutes. Now add the spices and stir for another minute, until fragrant.\n9. Add the tomato, cook for another few minutes, and then add the eggplant and black-eyed peas, and cook for another few minutes, stirring often.\n10. Pour a few tablespoons of water into the pan and add handfuls of chard at a time until wilted.\n11. Add more water as necessary.\n12. Add the lemon juice and salt to taste near the end of the cooking time.\n13. Remove from heat, cover, and let sit for a few minutes before serving.', 'https://img.spoonacular.com/recipes/798400-556x370.jpg', 'Spoonacular', '2026-04-29 15:15:12', '', 1),
(39, 7, 'Powerhouse Almond Matcha Superfood Smoothie', '1. Combine all of the ingredients in a blender. Blend on high until smooth.\n2. Serve immediately.', 'https://img.spoonacular.com/recipes/756814-556x370.jpg', 'Spoonacular', '2026-04-29 15:16:08', '', 1),
(40, 7, 'Butternut Squash Frittata', '1. Preheat oven to 350Spray a 10 oz oven safe dish with cooking spray\n2. Add your butternut squash\n3. In a measuring cup add your eggs and milk.\n4. Mix until combined.\n5. Pour over butternut squash.\n6. Sprinkle with pepper and top with cheese.\n7. Bake in oven for 30-35 minutes, until middle is slightly firm\n8. Let it cool for a few minutes', 'https://img.spoonacular.com/recipes/636589-556x370.jpg', 'Spoonacular', '2026-04-29 15:16:08', '', 1),
(41, 7, 'Finger Foods: Frittata Muffins', '', 'https://img.spoonacular.com/recipes/716432-556x370.jpg', 'Spoonacular', '2026-04-29 15:16:08', '', 1),
(42, 7, 'Doughnuts', '1. In a bowl mix the water with the yeast and honey, whisk and allow to sit for 15 minutes or until the mixture is foamy.\n2. Mix the flour with the salt and powdered milk and pour the yeast mixture into the bowl.Knead the dough till its elastic and not sticky and cover and leave to double in size. This could take 1-2 hours.On a lightly floured surface, roll out your dough but not to thin so your doughnuts are not flat and cut the dough into circles. If You have a doughnut cutter use that, if not use a small round shaped cover or bowl to make your circles and a smaller container for the middle hole. You can improvise and use the mouth of a plastic bottle to make the hole in the middle.Leave to rise for another 45 minutes.\n3. Heat up your oil and fry the doughnuts till they are brown on both sides.Vanilla Glaze\n4. Mix 1 cup of powdered sugar with 30 ml of milk and 1 teaspoon of vanilla.\n5. Whisk till its properly mixed and drizzle the doughnuts with it.\n6. Add sprinkles for garnishing\n7. Chocolate GlazeI used a chocolate sauce and drizzled over the doughnuts with sprinkles to top it.', 'https://img.spoonacular.com/recipes/716276-556x370.jpg', 'Spoonacular', '2026-04-29 15:16:08', '', 1),
(43, 7, 'Peanut Butter and Jelly Smoothie', '1. Place ingredients in a high speed blender like Blendtec for super smooth texture, blend on high.If using a regular blender put milk and strawberries in then blend.Next, add banana pieces and peanut butter, process until smooth.\n2. Garnish with crushed peanuts and serve.', 'https://img.spoonacular.com/recipes/655235-556x370.jpg', 'Spoonacular', '2026-04-29 15:16:08', '', 1);

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
(4, 10, 250.00, 'grams'),
(4, 11, 3.00, 'count'),
(5, 12, 150.00, 'grams'),
(5, 13, 60.00, 'grams'),
(5, 14, 20.00, 'ml'),
(13, 7, 1.00, 'tbsp'),
(13, 10, 2.00, 'lbs'),
(13, 19, 1.00, 'count'),
(13, 20, 1.00, 'c'),
(13, 21, 1.00, 'count'),
(13, 22, 1.00, 'count'),
(13, 23, 1.00, 'count'),
(13, 24, 1.00, 'count'),
(14, 5, 2.00, 'cups'),
(14, 14, 2.00, 'tablespoons'),
(14, 25, 8.00, 'servings'),
(14, 26, 3.00, 'medium'),
(14, 27, 3.00, ''),
(14, 28, 0.50, 'cup'),
(14, 29, 6.00, 'cloves'),
(14, 30, 28.00, 'ounce'),
(14, 31, 2.00, 'cups'),
(14, 32, 8.00, 'servings'),
(14, 33, 1.00, 'large'),
(14, 34, 8.00, 'cups'),
(14, 35, 1.00, 'medium'),
(15, 26, 2.00, 'large'),
(15, 35, 1.00, 'small'),
(15, 36, 14.50, 'oz'),
(15, 37, 2.00, 'stalks'),
(15, 38, 26.00, 'oz'),
(15, 39, 3.00, ''),
(15, 40, 10.00, ''),
(15, 41, 0.50, 'cup'),
(15, 42, 2.00, 'pounds'),
(15, 43, 2.00, 'cups'),
(16, 6, 1.00, ''),
(16, 14, 2.00, 'tablespoons'),
(16, 26, 2.00, 'medium'),
(16, 29, 2.00, 'cloves'),
(16, 34, 3.00, 'cups'),
(16, 35, 1.00, 'small'),
(16, 37, 2.00, 'stalks'),
(16, 44, 2.00, 'cups'),
(16, 45, 1.00, 'teaspoon'),
(16, 46, 2.00, 'cups'),
(16, 47, 1.00, 'teaspoon'),
(16, 48, 2.00, 'teaspoons'),
(16, 49, 1.00, 'medium'),
(16, 50, 3.00, 'handfuls'),
(16, 51, 6.00, 'servings'),
(16, 52, 2.00, 'teaspoons'),
(16, 53, 0.50, 'teaspoon'),
(16, 54, 1.50, 'teaspoons'),
(16, 55, 1.00, 'teaspoon'),
(16, 56, 2.00, 'medium'),
(17, 14, 2.00, 'tablespoons'),
(17, 57, 0.33, 'cup'),
(17, 58, 0.33, 'cup'),
(17, 59, 1.50, 'cups'),
(17, 60, 0.50, 'teaspoon'),
(17, 61, 0.50, 'teaspoon'),
(17, 62, 1.50, 'tablespoons'),
(17, 63, 1.00, ''),
(17, 64, 2.00, 'cups'),
(17, 65, 2.00, 'teaspoons'),
(17, 66, 6.00, 'servings'),
(17, 67, 0.50, 'cup'),
(17, 68, 0.50, 'teaspoon'),
(18, 14, 1.00, 'tsp'),
(18, 30, 10.00, 'ounce'),
(18, 35, 0.25, 'cup'),
(18, 43, 3.00, 'Tbsp'),
(18, 51, 0.25, 'tsp'),
(18, 69, 15.00, 'ounce'),
(18, 70, 2.00, 'tsp'),
(18, 71, 0.50, 'tsp'),
(18, 72, 4.00, 'dashes'),
(18, 73, 0.50, 'cup'),
(19, 8, 1.00, ''),
(19, 62, 1.00, 'tablespoon'),
(19, 74, 1.50, 'cup'),
(19, 75, 2.00, 'cups'),
(19, 76, 1.00, ''),
(19, 77, 1.00, 'cup'),
(20, 2, 6.00, ''),
(20, 43, 2.00, 'Tbs'),
(20, 78, 100.00, 'g'),
(20, 79, 25.00, 'g'),
(20, 80, 300.00, 'g'),
(20, 81, 500.00, 'ml'),
(20, 82, 150.00, 'g'),
(20, 83, 1.00, 'Tbs'),
(20, 84, 150.00, 'g'),
(21, 8, 0.50, ''),
(21, 43, 150.00, 'mls'),
(21, 74, 1.00, 'cup'),
(21, 85, 2.00, 'tablespoons'),
(21, 86, 2.00, 'tablespoons'),
(21, 87, 1.00, 'tablespoon'),
(21, 88, 1.00, 'teaspoon'),
(21, 89, 2.00, 'packets'),
(21, 90, 0.50, 'scoop'),
(22, 43, 2.00, 'cups'),
(22, 91, 0.50, 'cup'),
(22, 92, 4.00, 'tablespoons'),
(22, 93, 3.00, 'tablespoons'),
(22, 94, 1.00, 'teaspoon'),
(22, 95, 3.00, 'servings'),
(23, 96, 1.00, 'cup'),
(23, 97, 2.50, 'cups'),
(23, 98, 1.00, 'cup'),
(23, 99, 2.00, 'teaspoons'),
(23, 100, 0.50, 'teaspoon'),
(23, 101, 0.50, 'teaspoon'),
(23, 102, 1.00, 'teaspoon'),
(23, 103, 2.00, 'teaspoons'),
(23, 104, 0.50, 'cup'),
(23, 105, 0.33, 'cup'),
(23, 106, 0.75, 'cup'),
(23, 107, 0.25, 'cup'),
(23, 108, 2.00, 'teaspoons'),
(24, 2, 3.00, ''),
(24, 11, 4.00, ''),
(24, 14, 1.00, 'serving'),
(24, 109, 3.00, 'oz'),
(24, 110, 2.00, ''),
(24, 111, 0.33, 'cup'),
(24, 112, 1.00, 'cup'),
(24, 113, 2.00, 'Tablespoons'),
(24, 114, 1.00, 'serving'),
(24, 115, 1.00, 'serving'),
(24, 116, 1.00, 'serving'),
(24, 117, 1.00, 'serving'),
(24, 118, 1.00, 'serving'),
(25, 29, 1.00, 'tablespoon'),
(25, 68, 0.50, 'teaspoon'),
(25, 84, 4.00, 'servings'),
(25, 99, 1.00, 'small pinch'),
(25, 101, 4.00, 'servings'),
(25, 119, 2.00, 'medium'),
(25, 120, 1.00, 'teaspoon'),
(25, 121, 0.25, 'cup'),
(25, 122, 2.00, 'teaspoons'),
(25, 123, 6.00, ''),
(25, 124, 1.00, 'tablespoon'),
(25, 125, 1.50, 'cups'),
(25, 126, 1.00, 'teaspoon'),
(25, 127, 1.00, 'tablespoon'),
(25, 128, 1.00, 'medium'),
(26, 14, 2.00, 'tablespoons'),
(26, 29, 3.00, 'cloves'),
(26, 35, 1.00, ''),
(26, 36, 2.00, 'cups'),
(26, 101, 0.50, 'teaspoon'),
(26, 107, 0.50, 'cup'),
(26, 129, 2.00, ''),
(26, 130, 2.00, 'tablespoons'),
(26, 131, 1.00, 'bunch'),
(26, 132, 2.00, 'tablespoons'),
(26, 133, 0.50, 'teaspoon'),
(26, 134, 0.50, 'teaspoon'),
(26, 135, 1.00, 'teaspoon'),
(26, 136, 5.50, 'pounds'),
(26, 137, 6.00, 'ounces'),
(26, 138, 1.00, 'tablespoon'),
(26, 139, 1.00, 'tablespoon'),
(26, 140, 1.00, 'can'),
(27, 4, 1.00, 'Tbs'),
(27, 138, 1.00, 'pinch'),
(27, 141, 1.00, 'lb'),
(27, 142, 0.50, 'cup'),
(27, 143, 1.00, 'pinch'),
(27, 144, 26.00, 'oz'),
(27, 145, 1.00, 'can'),
(27, 146, 0.13, 'tsp'),
(27, 147, 0.50, ''),
(27, 148, 2.00, 'cups'),
(27, 149, 0.50, 'cup'),
(27, 150, 6.00, 'servings'),
(27, 151, 6.00, 'servings'),
(27, 152, 2.25, 'cup'),
(27, 153, 1.00, 'tsp'),
(27, 154, 0.67, 'cup'),
(27, 155, 1.00, 'serving'),
(28, 156, 36.00, ''),
(28, 157, 1.00, 'package'),
(28, 158, 16.00, 'oz'),
(28, 159, 48.00, 'servings'),
(28, 160, 48.00, 'servings'),
(28, 161, 48.00, 'servings'),
(29, 5, 2.00, 'cups'),
(29, 14, 2.00, 'tablespoons'),
(29, 25, 8.00, 'servings'),
(29, 26, 3.00, 'medium'),
(29, 27, 3.00, ''),
(29, 28, 0.50, 'cup'),
(29, 29, 6.00, 'cloves'),
(29, 30, 28.00, 'ounce'),
(29, 31, 2.00, 'cups'),
(29, 32, 8.00, 'servings'),
(29, 33, 1.00, 'large'),
(29, 34, 8.00, 'cups'),
(29, 35, 1.00, 'medium'),
(30, 26, 2.00, 'large'),
(30, 35, 1.00, 'small'),
(30, 36, 14.50, 'oz'),
(30, 37, 2.00, 'stalks'),
(30, 38, 26.00, 'oz'),
(30, 39, 3.00, ''),
(30, 40, 10.00, ''),
(30, 41, 0.50, 'cup'),
(30, 42, 2.00, 'pounds'),
(30, 43, 2.00, 'cups'),
(31, 6, 1.00, ''),
(31, 14, 2.00, 'tablespoons'),
(31, 26, 2.00, 'medium'),
(31, 29, 2.00, 'cloves'),
(31, 34, 3.00, 'cups'),
(31, 35, 1.00, 'small'),
(31, 37, 2.00, 'stalks'),
(31, 44, 2.00, 'cups'),
(31, 45, 1.00, 'teaspoon'),
(31, 46, 2.00, 'cups'),
(31, 47, 1.00, 'teaspoon'),
(31, 48, 2.00, 'teaspoons'),
(31, 49, 1.00, 'medium'),
(31, 50, 3.00, 'handfuls'),
(31, 51, 6.00, 'servings'),
(31, 52, 2.00, 'teaspoons'),
(31, 53, 0.50, 'teaspoon'),
(31, 54, 1.50, 'teaspoons'),
(31, 55, 1.00, 'teaspoon'),
(31, 56, 2.00, 'medium'),
(32, 14, 2.00, 'tablespoons'),
(32, 57, 0.33, 'cup'),
(32, 58, 0.33, 'cup'),
(32, 59, 1.50, 'cups'),
(32, 60, 0.50, 'teaspoon'),
(32, 61, 0.50, 'teaspoon'),
(32, 62, 1.50, 'tablespoons'),
(32, 63, 1.00, ''),
(32, 64, 2.00, 'cups'),
(32, 65, 2.00, 'teaspoons'),
(32, 66, 6.00, 'servings'),
(32, 67, 0.50, 'cup'),
(32, 68, 0.50, 'teaspoon'),
(33, 14, 1.00, 'tsp'),
(33, 30, 10.00, 'ounce'),
(33, 35, 0.25, 'cup'),
(33, 43, 3.00, 'Tbsp'),
(33, 51, 0.25, 'tsp'),
(33, 69, 15.00, 'ounce'),
(33, 70, 2.00, 'tsp'),
(33, 71, 0.50, 'tsp'),
(33, 72, 4.00, 'dashes'),
(33, 73, 0.50, 'cup'),
(34, 29, 2.00, 'cloves'),
(34, 35, 0.50, ''),
(34, 163, 1.00, 'bag'),
(34, 164, 1.00, 'T'),
(34, 165, 2.00, 'c'),
(34, 166, 1.00, 'box'),
(35, 7, 3.00, 'T'),
(35, 29, 5.00, 'cloves'),
(35, 44, 3.00, 'cups'),
(35, 101, 8.00, 'servings'),
(35, 110, 7.00, ''),
(35, 165, 1.00, 'cup'),
(35, 167, 2.00, 'tablespoons'),
(35, 168, 2.00, 'tablespoons'),
(35, 169, 1.00, 'head'),
(35, 170, 2.00, 'cups'),
(35, 171, 2.00, 'teaspoons'),
(35, 172, 8.00, 'servings'),
(35, 173, 8.00, 'servings'),
(36, 6, 4.00, 'servings'),
(36, 29, 1.00, 'clove'),
(36, 43, 0.25, 'cup'),
(36, 84, 1.00, 'tablespoon'),
(36, 174, 0.50, 'cup'),
(36, 175, 1.00, 'small head'),
(36, 176, 1.00, 'small'),
(36, 177, 0.25, 'cup'),
(36, 178, 0.50, 'cup'),
(36, 179, 2.00, 'tablespoons'),
(36, 180, 0.50, 'cup'),
(36, 181, 0.25, 'cup'),
(36, 182, 8.00, 'large'),
(36, 183, 8.00, '8-inch'),
(36, 184, 4.00, 'servings'),
(37, 6, 0.50, 'medium'),
(37, 8, 1.00, ''),
(37, 29, 1.00, 'clove'),
(37, 71, 1.00, 'teaspoon'),
(37, 185, 1.00, 'teaspoon'),
(37, 186, 0.75, 'cup'),
(38, 14, 2.00, 'teaspoons'),
(38, 43, 5.00, 'tablespoons'),
(38, 54, 1.00, 'teaspoon'),
(38, 61, 0.50, 'teaspoon'),
(38, 128, 1.00, 'medium'),
(38, 134, 0.50, 'teaspoon'),
(38, 187, 2.00, 'cups'),
(38, 188, 2.00, 'teaspoons'),
(38, 189, 1.00, 'large'),
(38, 190, 0.50, 'teaspoon'),
(38, 191, 0.50, 'teaspoon'),
(38, 192, 3.00, ''),
(38, 193, 2.00, ''),
(38, 194, 2.00, ''),
(38, 195, 1.00, 'bunch'),
(39, 74, 1.50, 'cups'),
(39, 76, 1.00, 'medium'),
(39, 86, 2.00, 'teaspoons'),
(39, 108, 0.50, 'teaspoon'),
(39, 196, 2.00, 'tablespoons'),
(39, 197, 1.00, 'cup'),
(39, 198, 0.50, 'cup'),
(39, 199, 1.00, 'tablespoon'),
(39, 200, 0.75, 'cup'),
(40, 6, 1.00, 'serving'),
(40, 201, 1.00, 'large'),
(40, 202, 0.50, 'oz'),
(40, 203, 0.50, 'cup'),
(40, 204, 2.00, 'tbsp'),
(41, 2, 6.00, ''),
(41, 32, 1.00, 'serving'),
(41, 128, 0.33, 'cup'),
(41, 170, 0.75, 'cup'),
(41, 205, 2.00, 'T'),
(41, 206, 1.00, ''),
(41, 207, 0.33, 'cup'),
(41, 208, 0.50, 'cup'),
(42, 62, 30.00, 'ml'),
(42, 101, 0.50, 'teaspoon'),
(42, 209, 1.50, 'cups'),
(42, 210, 1.00, 'tablespoon'),
(42, 211, 150.00, 'ml'),
(42, 212, 1.00, 'teaspoon'),
(43, 74, 1.00, 'cup'),
(43, 213, 2.00, ''),
(43, 214, 0.50, 'cup'),
(43, 215, 0.50, 'cup');

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
(2, 2, '2026-04-27 02:46:23'),
(2, 3, '2026-02-22 12:22:03'),
(4, 3, '2026-02-22 12:22:03'),
(4, 5, '2026-02-22 12:22:03'),
(5, 2, '2026-02-22 12:22:03'),
(5, 4, '2026-02-22 12:22:03'),
(15, 7, '2026-04-29 14:31:39'),
(16, 8, '2026-04-29 15:01:44');

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
(5, 'Mexican', '#E9C46A'),
(6, 'Cant spell', '#D5B8DA'),
(7, 'Sunday Meal', '#D5B8DA'),
(8, 'tlll', '#D5B8DA');

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
(1, 'liam', 'pass123'),
(2, 'testuser', 'hashed_password_456'),
(3, 'someuser', '$2y$10$1qS1p/9P4c/iG0JX0tC7Aen2Ptn1ehYsal3XA7arm.jYQ8QCifgOS'),
(4, 'hungry', '$2y$10$Xt4l739DgUaVa2i6ZFI4wuCUMfpLSmZtZth0RLUuRI2IUn/mdfZ/y'),
(5, 'megan', '$2y$10$0uZaVcJZ1Xa7CDEnTl/CwOnV4oeUlp2Wh5qcdTeObeeJFJwcMHeje'),
(6, 'Good_cook', '$2y$10$.2HRDvLD0wP3se5rvrygDevyyVLe8OV2JIBTHR5ZuKAhOV8uk66Dy'),
(7, 'keelyf', '$2y$10$a/ptRXf/V/LWiW86xRoDOOMriFhDG6eLa9.zmmhe6UWYcn0KwI5Au');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Favorites`
--
ALTER TABLE `Favorites`
  ADD PRIMARY KEY (`favorite_id`),
  ADD UNIQUE KEY `recipe_id` (`recipe_id`),
  ADD UNIQUE KEY `user_recipe` (`user_id`,`recipe_id`),
  ADD UNIQUE KEY `recipe_id_2` (`recipe_id`,`user_id`);

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
  ADD PRIMARY KEY (`recipe_id`),
  ADD KEY `idx_recipes_user` (`user_id`);

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
  MODIFY `favorite_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `Grocery_List`
--
ALTER TABLE `Grocery_List`
  MODIFY `list_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `Ingredients`
--
ALTER TABLE `Ingredients`
  MODIFY `ingredient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=216;

--
-- AUTO_INCREMENT for table `Inventory`
--
ALTER TABLE `Inventory`
  MODIFY `inventory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `Nutritional_Values`
--
ALTER TABLE `Nutritional_Values`
  MODIFY `nutrition_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `Recipes`
--
ALTER TABLE `Recipes`
  MODIFY `recipe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `Tags`
--
ALTER TABLE `Tags`
  MODIFY `tag_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
