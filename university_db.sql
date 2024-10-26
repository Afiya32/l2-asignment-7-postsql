-- Active: 1729709476102@@127.0.0.1@5432@university_db
-- creating student table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100),
    age INTEGER,
    email VARCHAR(100),
    frontend_mark INTEGER,
    backend_mark INTEGER,
    status VARCHAR(50)
);
-- creating course table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    credits INTEGER
);
-- creating enroller table
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id)
);
-- insert data part
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES 
    ('Sameer', 21, 'sameer@example.com', 48, 60, NULL),
    ('Zoya', 23, 'zoya@example.com', 52, 58, NULL),
    ('Nabil', 22, 'nabil@example.com', 37, 46, NULL),
    ('Rafi', 24, 'rafi@example.com', 41, 40, NULL),
    ('Sophia', 22, 'sophia@example.com', 50, 52, NULL),
    ('Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);
    INSERT INTO courses (course_name, credits)
VALUES 
    ('Next.js', 3),
    ('React.js', 4),
    ('Databases', 3),
    ('Prisma', 3);
    INSERT INTO enrollment (student_id, course_id)
VALUES 
    (1, 1),
    (1, 2),
    (2, 1),
    (3, 2);
    -- query part
    -- Insert a New Student Record
    INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES ('Biplob', 21, 'biplobguru123@gmail.com', 58, 60, NULL);
-- Retrieve Names of Students Enrolled in 'Next.js':
SELECT s.student_name
FROM students s
JOIN enrollment e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Next.js';
-- Update the Status of the Top Student to 'Awarded'
UPDATE students
SET status = 'Awarded'
WHERE (frontend_mark + backend_mark) = (
    SELECT MAX(frontend_mark + backend_mark) FROM students
);
-- Delete Courses with No Enrollments
DELETE FROM courses
WHERE course_id NOT IN (SELECT DISTINCT course_id FROM enrollment);
-- Retrieve Names of Students with LIMIT and OFFSET:
SELECT student_name
FROM students
ORDER BY student_id
LIMIT 2 OFFSET 2;
-- Retrieve Course Names and Enrollment Counts:
SELECT c.course_name, COUNT(e.student_id) AS students_enrolled
FROM courses c
LEFT JOIN enrollment e ON c.course_id = e.course_id
GROUP BY c.course_name;
-- Calculate Average Age of Students:
SELECT AVG(age) AS average_age FROM students;
-- Retrieve Students with 'example.com' in Email:
SELECT student_name
FROM students
WHERE email LIKE '%example.com%';