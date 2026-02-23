CREATE TABLE Users (
    user_id   INT          NOT NULL AUTO_INCREMENT,
    name      VARCHAR(100) NOT NULL UNIQUE,
    password  VARCHAR(255) NOT NULL,
    PRIMARY KEY (user_id)
);

CREATE TABLE Recipes (
    recipe_id      INT           NOT NULL AUTO_INCREMENT,
    recipe_name    VARCHAR(255)  NOT NULL,
    instructions   TEXT,
    image_url      VARCHAR(500),
    source_api     VARCHAR(100),
    last_fetched   TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    is_favorited   BOOLEAN       NOT NULL DEFAULT FALSE,
    cache_priority ENUM('favorite', 'recently_used', 'temporary') NOT NULL,
    PRIMARY KEY (recipe_id)
);

CREATE TABLE Ingredients (
    ingredient_id   INT          NOT NULL AUTO_INCREMENT,
    ingredient_name VARCHAR(255) NOT NULL UNIQUE,
    default_unit    VARCHAR(50)  NOT NULL,
    PRIMARY KEY (ingredient_id)
);

CREATE TABLE Recipe_Ingredients (
    recipe_id     INT           NOT NULL,
    ingredient_id INT           NOT NULL,
    quantity      DECIMAL(10,2) NOT NULL CHECK (quantity > 0),
    unit          VARCHAR(50)   NOT NULL,
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id)     REFERENCES Recipes(recipe_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id)
);

CREATE TABLE Tags (
    tag_id   INT          NOT NULL AUTO_INCREMENT,
    tag_name VARCHAR(100) NOT NULL UNIQUE,
    color    VARCHAR(7)   NOT NULL,
    PRIMARY KEY (tag_id)
);

CREATE TABLE Recipe_Tags (
    recipe_id   INT       NOT NULL,
    tag_id      INT       NOT NULL,
    date_tagged TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (recipe_id, tag_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id),
    FOREIGN KEY (tag_id)    REFERENCES Tags(tag_id)
);

CREATE TABLE Favorites (
    favorite_id INT       NOT NULL AUTO_INCREMENT,
    recipe_id   INT       NOT NULL UNIQUE,
    user_id     INT       NOT NULL,
    date_added  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    rating      INT       CHECK (rating BETWEEN 1 AND 5),
    notes       TEXT,
    PRIMARY KEY (favorite_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id),
    FOREIGN KEY (user_id)   REFERENCES Users(user_id)
);

CREATE TABLE Inventory (
    inventory_id    INT           NOT NULL AUTO_INCREMENT,
    ingredient_id   INT           NOT NULL,
    user_id         INT           NOT NULL,
    quantity        DECIMAL(10,2) NOT NULL CHECK (quantity >= 0),
    unit            VARCHAR(50)   NOT NULL,
    expiration_date DATE,
    date_opened     DATE,
    PRIMARY KEY (inventory_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id),
    FOREIGN KEY (user_id)       REFERENCES Users(user_id)
);

CREATE TABLE Grocery_List (
    list_id       INT           NOT NULL AUTO_INCREMENT,
    ingredient_id INT           NOT NULL,
    user_id       INT           NOT NULL,
    quantity      DECIMAL(10,2) NOT NULL CHECK (quantity > 0),
    unit          VARCHAR(50)   NOT NULL,
    is_purchased  BOOLEAN       NOT NULL DEFAULT FALSE,
    PRIMARY KEY (list_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id),
    FOREIGN KEY (user_id)       REFERENCES Users(user_id)
);

CREATE TABLE Nutritional_Values (
    nutrition_id  INT           NOT NULL AUTO_INCREMENT,
    ingredient_id INT,
    recipe_id     INT,
    entity_type   ENUM('ingredient', 'recipe') NOT NULL,
    calories      DECIMAL(8,2)  CHECK (calories >= 0),
    protein       DECIMAL(8,2)  CHECK (protein >= 0),
    carbs         DECIMAL(8,2)  CHECK (carbs >= 0),
    sugar         DECIMAL(8,2)  CHECK (sugar >= 0),
    fat           DECIMAL(8,2)  CHECK (fat >= 0),
    PRIMARY KEY (nutrition_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id),
    FOREIGN KEY (recipe_id)     REFERENCES Recipes(recipe_id)
);

-- Users (insert first, referenced by Favorites, Inventory, Grocery_List)
INSERT INTO Users (name, password) VALUES
('liam',     'hashed_password_123'),
('testuser', 'hashed_password_456');

-- Recipes
INSERT INTO Recipes (recipe_name, instructions, image_url, source_api, is_favorited, cache_priority) VALUES
('Spaghetti Carbonara', 'Boil pasta. Fry pancetta. Mix eggs and cheese. Combine all.',     'https://img.example.com/carbonara.jpg',  'Spoonacular', TRUE,  'favorite'),
('Chicken Stir Fry',    'Chop vegetables. Cook chicken. Add sauce and stir fry together.', 'https://img.example.com/stirfry.jpg',    'Spoonacular', FALSE, 'recently_used'),
('Avocado Toast',       'Toast bread. Mash avocado. Season and top with eggs.',             'https://img.example.com/avotoast.jpg',   'Edamam',      FALSE, 'temporary'),
('Beef Tacos',          'Brown beef. Season with spices. Fill tortillas with toppings.',    'https://img.example.com/tacos.jpg',      'Spoonacular', TRUE,  'favorite'),
('Greek Salad',         'Chop vegetables. Add olives and feta. Dress with olive oil.',      'https://img.example.com/greeksalad.jpg', 'Edamam',      FALSE, 'recently_used');

-- Ingredients
INSERT INTO Ingredients (ingredient_name, default_unit) VALUES
('Spaghetti',       'grams'),
('Eggs',            'count'),
('Pancetta',        'grams'),
('Parmesan Cheese', 'grams'),
('Chicken Breast',  'grams'),
('Bell Pepper',     'count'),
('Soy Sauce',       'ml'),
('Avocado',         'count'),
('Sourdough Bread', 'slices'),
('Ground Beef',     'grams'),
('Tortillas',       'count'),
('Romaine Lettuce', 'grams'),
('Feta Cheese',     'grams'),
('Olive Oil',       'ml');

-- Recipe_Ingredients
INSERT INTO Recipe_Ingredients (recipe_id, ingredient_id, quantity, unit) VALUES
(1, 1,  200.00, 'grams'),   -- Carbonara: Spaghetti
(1, 2,  3.00,   'count'),   -- Carbonara: Eggs
(1, 3,  100.00, 'grams'),   -- Carbonara: Pancetta
(1, 4,  50.00,  'grams'),   -- Carbonara: Parmesan
(2, 5,  300.00, 'grams'),   -- Stir Fry: Chicken
(2, 6,  2.00,   'count'),   -- Stir Fry: Bell Pepper
(2, 7,  30.00,  'ml'),      -- Stir Fry: Soy Sauce
(3, 8,  1.00,   'count'),   -- Avocado Toast: Avocado
(3, 9,  2.00,   'slices'),  -- Avocado Toast: Sourdough
(3, 2,  2.00,   'count'),   -- Avocado Toast: Eggs
(4, 10, 250.00, 'grams'),   -- Tacos: Ground Beef
(4, 11, 3.00,   'count'),   -- Tacos: Tortillas
(5, 12, 150.00, 'grams'),   -- Greek Salad: Romaine
(5, 13, 60.00,  'grams'),   -- Greek Salad: Feta
(5, 14, 20.00,  'ml');      -- Greek Salad: Olive Oil

-- Tags
INSERT INTO Tags (tag_name, color) VALUES
('Italian',      '#009246'),
('Quick',        '#F4A261'),
('High Protein', '#E63946'),
('Vegetarian',   '#2A9D8F'),
('Mexican',      '#E9C46A');

-- Recipe_Tags
INSERT INTO Recipe_Tags (recipe_id, tag_id) VALUES
(1, 1),  -- Carbonara: Italian
(1, 3),  -- Carbonara: High Protein
(2, 2),  -- Stir Fry: Quick
(2, 3),  -- Stir Fry: High Protein
(3, 2),  -- Avocado Toast: Quick
(3, 4),  -- Avocado Toast: Vegetarian
(4, 5),  -- Tacos: Mexican
(4, 3),  -- Tacos: High Protein
(5, 4),  -- Greek Salad: Vegetarian
(5, 2);  -- Greek Salad: Quick

-- Favorites (user_id = 1 for liam)
INSERT INTO Favorites (recipe_id, user_id, date_added, rating, notes) VALUES
(1, 1, '2025-01-10 18:30:00', 5, 'Family favorite, make every Sunday.'),
(4, 1, '2025-02-14 12:00:00', 4, 'Great for taco night. Add jalapenos next time.');

-- Inventory (user_id = 1 for liam)
INSERT INTO Inventory (ingredient_id, user_id, quantity, unit, expiration_date, date_opened) VALUES
(1,  1, 500.00, 'grams', '2025-12-01', NULL),
(2,  1, 12.00,  'count', '2025-03-15', '2025-03-01'),
(4,  1, 200.00, 'grams', '2025-04-01', '2025-03-01'),
(14, 1, 500.00, 'ml',    '2026-01-01', '2025-02-01'),
(7,  1, 300.00, 'ml',    '2025-11-01', '2025-01-15');

-- Grocery_List (user_id = 1 for liam)
INSERT INTO Grocery_List (ingredient_id, user_id, quantity, unit, is_purchased) VALUES
(5,  1, 400.00, 'grams', FALSE),
(10, 1, 500.00, 'grams', FALSE),
(11, 1, 6.00,   'count', TRUE),
(8,  1, 3.00,   'count', FALSE),
(6,  1, 2.00,   'count', TRUE);

-- Nutritional_Values (per ingredient per gram, and per recipe total)
INSERT INTO Nutritional_Values (ingredient_id, recipe_id, entity_type, calories, protein, carbs, sugar, fat) VALUES
(1,  NULL, 'ingredient', 3.50,  0.13, 0.71, 0.00, 0.01),  -- Spaghetti
(2,  NULL, 'ingredient', 1.55,  0.13, 0.01, 0.00, 0.11),  -- Eggs
(4,  NULL, 'ingredient', 4.00,  0.36, 0.00, 0.00, 0.29),  -- Parmesan
(5,  NULL, 'ingredient', 1.65,  0.31, 0.00, 0.00, 0.04),  -- Chicken Breast
(8,  NULL, 'ingredient', 1.60,  0.02, 0.09, 0.00, 0.15),  -- Avocado
(10, NULL, 'ingredient', 2.50,  0.26, 0.00, 0.00, 0.15),  -- Ground Beef
(NULL, 1,  'recipe',     650.00, 35.00, 60.00, 2.00, 25.00), -- Carbonara total
(NULL, 2,  'recipe',     420.00, 48.00, 15.00, 5.00, 12.00), -- Stir Fry total
(NULL, 3,  'recipe',     310.00, 14.00, 28.00, 2.00, 18.00), -- Avocado Toast total
(NULL, 4,  'recipe',     580.00, 38.00, 30.00, 3.00, 28.00), -- Tacos total
(NULL, 5,  'recipe',     220.00,  8.00, 12.00, 4.00, 16.00); -- Greek Salad total

-- Query 1: Favorited recipes with rating 4 or higher
SELECT r.recipe_name, f.rating, f.notes
FROM Favorites f
JOIN Recipes r ON f.recipe_id = r.recipe_id
WHERE f.rating >= 4 AND r.is_favorited = TRUE;

-- Query 2: Total calories and protein per recipe using arithmetic
SELECT r.recipe_name,
       SUM(nv.calories * ri.quantity) AS total_calories,
       SUM(nv.protein * ri.quantity)  AS total_protein_g
FROM Recipes r
JOIN Recipe_Ingredients ri ON r.recipe_id = ri.recipe_id
JOIN Nutritional_Values nv ON ri.ingredient_id = nv.ingredient_id
WHERE nv.entity_type = 'ingredient'
GROUP BY r.recipe_name;

-- Query 3: Recipes with their tags
SELECT r.recipe_name, t.tag_name, t.color
FROM Recipes r
INNER JOIN Recipe_Tags rt ON r.recipe_id = rt.recipe_id
INNER JOIN Tags t ON rt.tag_id = t.tag_id
ORDER BY r.recipe_name;

-- Query 4: Number of recipes per ingredient with average quantity
SELECT i.ingredient_name,
       COUNT(ri.recipe_id) AS recipe_count,
       AVG(ri.quantity)    AS avg_quantity_used
FROM Ingredients i
JOIN Recipe_Ingredients ri ON i.ingredient_id = ri.ingredient_id
GROUP BY i.ingredient_name
ORDER BY recipe_count DESC;

-- Query 5: Ingredients used in more than 2 recipes
SELECT i.ingredient_name, COUNT(ri.recipe_id) AS recipe_count
FROM Ingredients i
JOIN Recipe_Ingredients ri ON i.ingredient_id = ri.ingredient_id
GROUP BY i.ingredient_name
HAVING COUNT(ri.recipe_id) > 2;
