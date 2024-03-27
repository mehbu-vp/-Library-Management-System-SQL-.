-- Project Name: Library Management System SQL Project
/*
Purpose:
The purpose of this project is to create a database system using SQL for efficiently managing a library's collection of books, authors, and user interactions.
*/
/*
Key Features:
1.Book management
2.Author Management
3.User Interaction
4.Borrowing History
5.Reports and Insights
*/

/*
Technology Stack:

SQL: For database creation, table management, and querying.
MySQL: Specific RDBMS used for this project.
Basic SQL queries for CRUD operations: SELECT, INSERT, UPDATE, DELETE.
*/

CREATE DATABASE LIBRARY;
USE library;

-- create table authors
CREATE TABLE authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100)
);
-- create table books
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author_id INT,
    genre VARCHAR(50),
    published_year INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);
-- create table user
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    email VARCHAR(255)
);

-- insert data into the tables
INSERT INTO authors (author_id, author_name)
VALUES
    (1, 'Jane Austen'),
    (2, 'Mark Twain'),
    (3, 'Agatha Christie');

INSERT INTO books (book_id, title, author_id, genre, published_year)
VALUES
    (1, 'Pride and Prejudice', 1, 'Classic', 1813),
    (2, 'Emma', 1, 'Classic', 1815),
    (3, 'Tom Sawyer', 2, 'Adventure', 1876),
    (4, 'Murder on the Orient Express', 3, 'Mystery', 1934);

INSERT INTO users (user_id, user_name, email)
VALUES
    (1, 'Alice', 'alice@example.com'),
    (2, 'Bob', 'bob@example.com');
    
-- Query to Get All Books 
SELECT * from books;

-- Query to Get Books by Author(use join)
SELECT b.title, a.author_name
FROM books b
JOIN authors a ON b.author_id = a.author_id;

-- Query to Get Users Who Borrowed Books
-- create a new table borrow
CREATE TABLE borrow (
    borrow_id INT PRIMARY KEY,
    user_id INT,
    book_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);
-- insert records into table
INSERT INTO borrow (borrow_id, user_id, book_id, borrow_date, return_date)
VALUES
    (1, 1, 1, '2022-01-01', '2022-01-15'),
    (2, 2, 3, '2022-02-01', NULL);
-- join the tables
SELECT u.user_name, b.title, br.borrow_date, br.return_date
FROM borrow br
JOIN users u ON br.user_id = u.user_id
JOIN books b ON br.book_id = b.book_id;

-- Create Views
CREATE VIEW book_author AS
SELECT b.title AS book_title, a.author_name AS author
FROM books b
JOIN authors a ON b.author_id = a.author_id;

SELECT * FROM book_author;

-- Add Index
-- Add Index to Books' Genre
CREATE INDEX idx_genre ON books (genre);

-- Query to Get Books Published After a Specific Year
SELECT title, author_name, published_year
FROM books b
JOIN authors a ON b.author_id = a.author_id
WHERE published_year > 1900;

-- Query to Get Users Who Have Borrowed Books
SELECT u.user_name, COUNT(b.book_id) AS num_books_borrowed
FROM borrow br
JOIN users u ON br.user_id = u.user_id
JOIN books b ON br.book_id = b.book_id
GROUP BY u.user_name;

-- Query to Get Total Number of Books in Each Genre
SELECT genre, COUNT(book_id) AS num_books
FROM books
GROUP BY genre;

-- Query to Get Authors and the Number of Books They Have Written
SELECT a.author_name, COUNT(b.book_id) AS num_books
FROM authors a
LEFT JOIN books b ON a.author_id = b.author_id
GROUP BY a.author_name;

-- Query to Get the User Who Borrowed the Most Books
SELECT u.user_name, COUNT(br.borrow_id) AS num_borrowed
FROM users u
JOIN borrow br ON u.user_id = br.user_id
GROUP BY u.user_name
ORDER BY num_borrowed DESC
LIMIT 1;

/*
Conclusion:
The Library Management System SQL Project provides a robust and efficient solution for managing a library's collection of books,
 authors, and user interactions.Through the use of SQL queries and relational database principles, 
 the system offers a streamlined approach to library operations.
*/












