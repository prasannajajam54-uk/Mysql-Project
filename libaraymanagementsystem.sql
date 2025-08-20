use Library_system;
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(100),
    publisher VARCHAR(100),
    year_published YEAR,
    quantity INT CHECK (quantity >= 0)
);
desc books;
desc students;
desc issue;
INSERT INTO books (title, author, publisher, year_published, quantity) VALUES
('Database Management Systems', 'Korth', 'McGraw-Hill', 2018, 5),
('Let Us C', 'Yashwant Kanetkar', 'BPB Publications', 2015, 3),
('Java: The Complete Reference', 'Herbert Schildt', 'Oracle Press', 2020, 4),
('Python Programming', 'Reema Thareja', 'Oxford', 2021, 6);
select * from books;
INSERT INTO students (name, department, contact) VALUES
('Ravi Kumar', 'CSE', '9876543210'),
('Sneha Rao', 'ECE', '9123456780'),
('Amit Sharma', 'EEE', '9988776655'),
('Neha Singh', 'MECH', '9765432101');
select * from students;
INSERT INTO issue (book_id, student_id, issue_date, due_date) VALUES
(1, 1, '2025-08-01', '2025-08-15'),
(2, 2, '2025-08-03', '2025-08-17'),
(3, 3, '2025-08-05', '2025-08-19');
select * from issue;
select * from returns;
-- View all books
SELECT * FROM books;

-- View all students
SELECT * FROM students;

-- View issued books with student names
SELECT i.issue_id, b.title, s.name, i.issue_date, i.due_date
FROM issue i
JOIN books b ON i.book_id = b.book_id
JOIN students s ON i.student_id = s.student_id;

-- View returned books with fines
SELECT i.issue_id, b.title, s.name, r.return_date, r.fine
FROM return r
JOIN issue i ON r.issue_id = i.issue_id
JOIN books b ON i.book_id = b.book_id
JOIN students s ON i.student_id = s.student_id;
