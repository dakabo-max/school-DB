
-- Fetch all the class name where Music is thought as a subject.
SELECT 
   c.CLASS_ID,
   c.CLASS_NAME,
   s.SUBJECT_NAME
FROM classes AS c
LEFT JOIN subjects AS s
ON c.SUBJECT_ID = s.SUBJECT_ID
WHERE s.SUBJECT_NAME = 'music';


-- Fetch the full name of all staff who teach Mathematics.
SELECT 
   DISTINCT(CONCAT(s.FIRST_NAME,' ', s.LAST_NAME)) AS full_name,
   sbj.SUBJECT_NAME
FROM staff AS s
LEFT JOIN classes AS c ON s.STAFF_ID = c.TEACHER_ID
JOIN subjects AS sbj ON c.SUBJECT_ID = sbj.SUBJECT_ID
WHERE sbj.SUBJECT_NAME = 'Mathematics';


-- Fetch all staff who teach grade 8, 9, 10 and also fetch all the non-teaching staff
SELECT 
   s.STAFF_TYPE, 
   CONCAT(s.FIRST_NAME,' ',s.LAST_NAME) AS FULL_NAME, 
   s.AGE, 
   s.GENDER, 
   s.JOIN_DATE
FROM staff AS s
LEFT JOIN classes AS c ON s.STAFF_ID = c.TEACHER_ID
WHERE c.CLASS_NAME IN ('Grade 8', 'Grade 9', 'Grade 10')
UNION ALL
SELECT 
   STAFF_TYPE, 
   CONCAT(FIRST_NAME,' ',LAST_NAME) AS FULL_NAME, 
   AGE, 
   GENDER, 
   JOIN_DATE 
FROM staff
WHERE STAFF_TYPE = 'Non-Teaching';


-- Count no of students in each class
SELECT 
   CLASS_ID, 
   COUNT(STUDENT_ID) AS STUDENTS_COUNT
FROM student_classes
GROUP BY CLASS_ID;


-- Return only the records where there are more than 100 students in each class
SELECT 
   CLASS_ID, 
   COUNT(STUDENT_ID) AS STUDENTS_COUNT
FROM student_classes
GROUP BY CLASS_ID
HAVING COUNT(STUDENT_ID) > 100;

-- Parents with more than 1 kid in school.
SELECT 
   p.ID, 
   p.FIRST_NAME, 
   p.LAST_NAME, 
   p.GENDER, 
   p.ADDRESS_ID,
   COUNT(sp.STUDENT_ID) AS STUDENT_COUNT
FROM parents AS p
JOIN student_parent AS sp ON p.ID = sp.PARENT_ID
GROUP BY p.ID
HAVING COUNT(sp.STUDENT_ID) > 1;

-- Staff details who’s salary is less than 5000
EXPLAIN ANALYZE
SELECT * 
FROM staff AS s
JOIN staff_salary AS ss ON s.STAFF_ID = ss.STAFF_ID
WHERE SALARY < 5000;


-- Calculates the average salary of a teaching staff.
SELECT 
   ROUND(AVG(ss.SALARY),2) AS AVG_SALARY
FROM staff AS s
JOIN staff_salary AS ss ON s.STAFF_ID = ss.STAFF_ID
WHERE STAFF_TYPE = 'Teaching';


-- Calculates the total salary of all staff.
SELECT 
   s.STAFF_TYPE,
   SUM(ss.SALARY) AS TOTAL_SALARY
FROM staff AS s
JOIN staff_salary AS ss ON s.STAFF_ID = ss.STAFF_ID
GROUP BY s.STAFF_TYPE;

-- Calculates the least salary of all staff.
SELECT 
   s.STAFF_TYPE,
   MIN(ss.SALARY) AS MIN_SALARY
FROM staff AS s
JOIN staff_salary AS ss ON s.STAFF_ID = ss.STAFF_ID
GROUP BY s.STAFF_TYPE;

-- Calculates the highest salary of all staff.
SELECT 
   s.STAFF_TYPE,
   MAX(ss.SALARY) AS MAX_SALARY
FROM staff AS s
JOIN staff_salary AS ss ON s.STAFF_ID = ss.STAFF_ID
GROUP BY s.STAFF_TYPE;