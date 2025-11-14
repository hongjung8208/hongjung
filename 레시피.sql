
CREATE DATABASE recipe_db;
USE recipe_db;

CREATE TABLE Recipes (
    recipe_id INT PRIMARY KEY,
    recipe_name VARCHAR(255) NOT NULL,
    ingredients TEXT,
    calories DECIMAL(10, 2),
    protein DECIMAL(10, 2),
    fat DECIMAL(10, 2),
    carbohydrates DECIMAL(10, 2),
    sodium DECIMAL(10, 2),
    main_image_url VARCHAR(1024),
    category VARCHAR(100),
    method VARCHAR(100),
    serving_weight VARCHAR(50),
    hashtag VARCHAR(255),
    recipe_tip TEXT
);


--  RecipeSteps 테이블 생성 
CREATE TABLE RecipeSteps (
    step_id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT NOT NULL,
    step_number INT NOT NULL,
    instruction TEXT,
    image_url VARCHAR(1024),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id) ON DELETE CASCADE
);


--  Users 테이블 생성 

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    bmi_value DECIMAL(5, 2),
    bmi_category VARCHAR(50)
);

-- 비밀번호 칼럼 추가
ALTER TABLE Users
ADD COLUMN password_hash VARCHAR(255) NOT NULL;