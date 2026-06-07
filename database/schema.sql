-- Create database
CREATE DATABASE IF NOT EXISTS Budget_db;
USE Budget_db;

-- Accounts table
CREATE TABLE accounts (
    account_id INT(11) AUTO_INCREMENT PRIMARY KEY,
    account_name VARCHAR(45) NOT NULL
);

-- Categories table
CREATE TABLE categories (
    category_id INT(11) AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(45) NOT NULL,
    transaction_type VARCHAR(45) NOT NULL
);

-- Transactions table
CREATE TABLE transactions (
    transaction_id INT(11) AUTO_INCREMENT PRIMARY KEY,
    transaction_type VARCHAR(45) NOT NULL,
    account_id INT(11),
    amount DECIMAL(10,2) NOT NULL,
    category_id INT(11),
    created_at DATE NOT NULL,

    FOREIGN KEY (account_id) REFERENCES accounts(account_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Budgets table
CREATE TABLE budgets (
    budget_id INT(11) AUTO_INCREMENT PRIMARY KEY,
    category_id INT(11) NOT NULL,
    month_year VARCHAR(7) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    UNIQUE (category_id, month_year)
);