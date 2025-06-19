-- 1. Find all computer science courses offered in Fall 2025
SELECT c.code, c.course_number, c.title, f.last_name AS instructor, o.schedule
FROM courses c
JOIN course_offerings o ON c.id = o.course_id
JOIN faculty f ON o.instructor_id = f.id
JOIN departments d ON c.department_id = d.id
WHERE d.code = 'COMP' AND o.semester = 'Fall' AND o.year = 2025;

-- 2. Get class roster for a specific course offering
SELECT s.id, s.last_name, s.first_name, s.email
FROM students s
JOIN enrollments e ON s.id = e.student_id
WHERE e.offering_id = 12345
ORDER BY s.last_name, s.first_name;

-- 3. Calculate average grade for a course across all offerings
SELECT c.code, c.course_number, c.title,
       AVG(e.grade) AS average_grade,
       COUNT(e.id) AS enrollment_count
FROM courses c
JOIN course_offerings o ON c.id = o.course_id
JOIN enrollments e ON o.id = e.offering_id
WHERE c.code = 'MATH' AND c.course_number = '101'
  AND e.grade IS NOT NULL;

-- 4. Find all students with GPA above 3.5 in computer science
SELECT s.id, s.last_name, s.first_name, g.gpa
FROM students s
JOIN student_gpa g ON s.id = g.id
JOIN departments d ON s.major_department_id = d.id
WHERE d.code = 'COMP' AND g.gpa > 3.5
ORDER BY g.gpa DESC;

-- 5. Update a student's grade
UPDATE enrollments
SET grade = 3.7
WHERE student_id = 10023 AND offering_id = 12345;

-- 6. Register a new student for a course
INSERT INTO enrollments (student_id, offering_id)
VALUES (10024, 12346);

-- 7. Find all courses taught by a specific professor
SELECT c.code, c.course_number, c.title, o.semester, o.year
FROM courses c
JOIN course_offerings o ON c.id = o.course_id
WHERE o.instructor_id = 54321
ORDER BY o.year DESC, o.semester;

-- 8. Get department enrollment statistics
SELECT d.code, d.name,
       COUNT(DISTINCT s.id) AS student_count,
       COUNT(DISTINCT f.id) AS faculty_count,
       COUNT(DISTINCT c.id) AS course_count
FROM departments d
LEFT JOIN students s ON d.id = s.major_department_id
LEFT JOIN faculty f ON d.id = f.department_id
LEFT JOIN courses c ON d.id = c.department_id
GROUP BY d.id
ORDER BY student_count DESC;
