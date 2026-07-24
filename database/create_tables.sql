DROP DATABASE IF EXISTS taskflow;

CREATE DATABASE taskflow;

USE taskflow;

CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    manager_name VARCHAR(100)
);