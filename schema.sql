DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS course_offerings;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS faculty;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    code TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL
);

-- Students table
CREATE TABLE students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    major_department_id INTEGER,
    enrollment_date DATE NOT NULL,
    FOREIGN KEY (major_department_id) REFERENCES departments(id)
);

-- Faculty table
CREATE TABLE faculty (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    department_id INTEGER NOT NULL,
    rank TEXT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- Courses table
CREATE TABLE courses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    code TEXT NOT NULL,
    course_number TEXT NOT NULL,
    title TEXT NOT NULL,
    credits INTEGER NOT NULL CHECK (credits > 0),
    department_id INTEGER NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- Course offerings table
CREATE TABLE course_offerings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_id INTEGER NOT NULL,
    instructor_id INTEGER,
    semester TEXT NOT NULL CHECK (semester IN ('Fall', 'Spring', 'Summer')),
    year INTEGER NOT NULL,
    schedule TEXT,
    UNIQUE(course_id, semester, year),
    FOREIGN KEY (course_id) REFERENCES courses(id),
    FOREIGN KEY (instructor_id) REFERENCES faculty(id)
);

-- Enrollments table
CREATE TABLE enrollments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER NOT NULL,
    offering_id INTEGER NOT NULL,
    grade NUMERIC CHECK (grade BETWEEN 0.0 AND 4.0),
    UNIQUE(student_id, offering_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (offering_id) REFERENCES course_offerings(id)
);

DROP VIEW IF EXISTS faculty_workload;
DROP VIEW IF EXISTS student_transcripts;
DROP VIEW IF EXISTS student_gpa;
-- Student GPA view
CREATE VIEW student_gpa AS
SELECT s.id, AVG(e.grade) AS gpa
FROM students s
JOIN enrollments e ON s.id = e.student_id
WHERE e.grade IS NOT NULL
GROUP BY s.id;

-- Student transcripts view
CREATE VIEW student_transcripts AS
SELECT s.id AS student_id, c.code, c.course_number, c.title,
       o.semester, o.year, e.grade, c.credits
FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN course_offerings o ON e.offering_id = o.id
JOIN courses c ON o.course_id = c.id;

-- Faculty workload view
CREATE VIEW faculty_workload AS
SELECT f.id, f.last_name, COUNT(o.id) AS courses_taught
FROM faculty f
LEFT JOIN course_offerings o ON f.id = o.instructor_id
GROUP BY f.id;
