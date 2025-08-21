CREATE DATABASE OnlineExamDB;
USE OnlineExamDB;
CREATE TABLE Student(
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(50)
);
CREATE TABLE Exam(
    exam_id INT PRIMARY KEY AUTO_INCREMENT,
    exam_name VARCHAR(100),
    total_marks INT,
    duration INT        -- in minutes
);
CREATE TABLE Question(
    question_id INT PRIMARY KEY AUTO_INCREMENT,
    exam_id INT,
    question_text VARCHAR(255),
    optionA VARCHAR(100),
    optionB VARCHAR(100),
    optionC VARCHAR(100),
    optionD VARCHAR(100),
    correct_option CHAR(1),
    FOREIGN KEY(exam_id) REFERENCES Exam(exam_id)
);
CREATE TABLE ExamResult(
    result_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    exam_id INT,
    score INT,
    exam_date DATE,
    status VARCHAR(20),     -- Passed / Failed
    FOREIGN KEY(student_id) REFERENCES Student(student_id),
    FOREIGN KEY(exam_id) REFERENCES Exam(exam_id)
);
INSERT INTO Student(name,email,password) VALUES 
('Priya','priya@gmail.com','12345'),
('Amit','amit@gmail.com','12345');
INSERT INTO Exam(exam_name,total_marks,duration) VALUES
('SQL Basic Test',50,30),
('Python Basic Test',50,30);
INSERT INTO Question(exam_id,question_text,optionA,optionB,optionC,optionD,correct_option) VALUES
(1,'SQL keyword to retrieve data?',
 'SELECT','CREATE','INSERT','DELETE','A'),
(1,'Which SQL keyword is used to remove table?',
 'DROP','ALTER','UPDATE','SELECT','A'),
(2,'Which keyword defines a function in Python?',
 'for','if','def','func','C');
 UPDATE Question SET optionD = 'TRUNCATE' WHERE question_id = 2;
 DELETE FROM Student WHERE student_id = 2;
SELECT * FROM Question WHERE question_text LIKE '%SQL%';
SELECT exam_id, COUNT(result_id) AS total_attempts, AVG(score) AS avg_score
FROM ExamResult
GROUP BY exam_id;
SELECT name FROM Student 
WHERE student_id IN (
      SELECT student_id FROM ExamResult WHERE status='Passed'
);
CREATE PROCEDURE AddStudent(
    IN sname VARCHAR(100),
    IN semail VARCHAR(100),
    IN spass VARCHAR(50)
)
BEGIN
    INSERT INTO Student(name,email,password)
    VALUES (sname,semail,spass);
END //
DELIMITER ;

-- CALL PROCEDURE EXAMPLE:
-- CALL AddStudent('Rohit','rohit@gmail.com','pass123');
-- 13. Trigger: set status automatically after inserting result
DELIMITER //
CREATE TRIGGER set_status_after_insert
BEFORE INSERT ON ExamResult
FOR EACH ROW
BEGIN
    IF NEW.score >= 25 THEN
        SET NEW.status = 'Passed';
    ELSE
        SET NEW.status = 'Failed';
    END IF;
END //
DELIMITER ;

-- Sample insert that will activate trigger:
INSERT INTO ExamResult(student_id,exam_id,score,exam_date)
VALUES(1,1,38,CURDATE());

