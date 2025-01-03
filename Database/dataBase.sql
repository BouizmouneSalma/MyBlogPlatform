CREATE DATABASE ProjetGestionArticles;
USE ProjetGestionArticles;

-- Table Users
CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('user', 'admin') DEFAULT 'user'
);

-- Table Articles
CREATE TABLE Articles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    image VARCHAR(255),
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    userId INT NOT NULL,
    FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE
);

-- Table Comments
CREATE TABLE Comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME NULL,
    userId INT,
    articleId INT NOT NULL,
    FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE SET NULL,
    FOREIGN KEY (articleId) REFERENCES Articles(id) ON DELETE CASCADE
);

-- Table Categories
CREATE TABLE Categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Table Tags
CREATE TABLE Tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Table Article_Tags
CREATE TABLE Article_Tags (
    idA INT NOT NULL,
    idT INT NOT NULL,
    PRIMARY KEY (idA, idT),
    FOREIGN KEY (idA) REFERENCES Articles(id) ON DELETE CASCADE,
    FOREIGN KEY (idT) REFERENCES Tags(id) ON DELETE CASCADE
);

-- Table Article_Categories
CREATE TABLE Article_Categories (
    articleId INT NOT NULL,
    categoryId INT NOT NULL,
    PRIMARY KEY (articleId, categoryId),
    FOREIGN KEY (articleId) REFERENCES Articles(id) ON DELETE CASCADE,
    FOREIGN KEY (categoryId) REFERENCES Categories(id) ON DELETE CASCADE
);
INSERT INTO Users (username, email, password, role) VALUES
('admin', 'admin@example.com', 'hashed_password', 'admin'),
('user1', 'user1@example.com', 'hashed_password', 'user');

INSERT INTO Categories (name) VALUES
('Tech'), ('Health'), ('Education');

INSERT INTO Tags (name) VALUES
('PHP'), ('MySQL'), ('HTML'), ('CSS');