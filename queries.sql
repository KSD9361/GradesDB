-- 
-- Autor: INAS
-- Fecha: Octube 2026
-- Descripción: Consultas SQL de ejemplo para grades_db
--              Cubre conceptos de consultas simples y avanzadas
-- 

USE grades_db;





SELECT s.degree_id FROM degrees s WHERE s.degree_name ='Tecnologías Informáticas';

SELECT * 
FROM students_subject;


SELECT *
FROM grades s
WHERE s.student_id = 12;

SELECT s.student_id, s.grade_value
FROM grades s;

SELECT s.student_id, s.grade_value, s.exam_call
FROM grades s
WHERE s.grade_value > 5;

-- students del grupo 2 matriculados en FP
SELECT ss.subject_id, ss.subject_id, s.acronym
FROM subjects s
JOIN students_subject ss ON ss.subject_id = s.subject_id
WHERE s.acronym = 'FP';




CREATE OR REPLACE VIEW l_students AS
SELECT 
    ss.student_id,
    ss.subject_id,
    sb.degree_id,
    sb.subject_name,
    sb.acronym,
    sb.credits,
    sb.course,
    sb.subject_type
FROM students_subject ss
JOIN subjects sb ON sb.subject_id = ss.subject_id;

SELECT * 
FROM l_students;

-- Average grade of students from group 7
SELECT AVG(g.grade_value) AS average_grade
FROM grades g
WHERE g.group_id = 7;
-- Average age of professors named David
SELECT AVG(p.age) AS average_age
FROM people p
WHERE p.first_name = 'David';


-- Total credits of group 1
SELECT SUM(s.credits) AS total_credits
FROM teaching_loads s 
WHERE s.group_id = 1;


-- How many professors are there? 

SELECT COUNT(*) AS total_profs
FROM professors;


SELECT subject_type, COUNT(*) AS total_type
FROM subjects
GROUP BY subject_type;

SELECT MAX(g.grade_value) AS max_grade
FROM grades g;

SELECT MIN(g.grade_value) AS min_grade
FROM grades g;

-- Professors between the ages 20-50
SELECT p.first_name, p.last_name, p.age
FROM people p
WHERE p.age < 50 OR p.age > 20;

-- Professors with the ages 21 and 43
SELECT p.first_name, p.last_name, p.age
FROM people p
WHERE p.age IN (21, 43);

SELECT g.grade_id, g.grade_value, g.exam_call
FROM grades g
WHERE g.grade_value BETWEEN 5 AND 7;

SELECT DISTINCT p.first_name, p.age
FROM people p
ORDER BY p.age DESC;





-- SUBCONSULTAS (20-)

-- El edad mas alto entre las 10 primeras personas
SELECT MAX(p.age) AS max_age
FROM people p
WHERE p.person_id BETWEEN 1 AND 10;

-- Consulta 21: Materias con 6 creditos
SELECT DISTINCT ge.subject_id
FROM students_subject ge
WHERE ge.subject_id IN (
    SELECT g.subject_id 
    FROM subjects g 
    WHERE g.credits = 6
);

-- Personas con menor edad que la media

SELECT s.first_name, s.age
FROM people s
WHERE s.age < (SELECT AVG(age) FROM people);

-- Nombres que terminan en S
SELECT p.first_name, p.last_name, p.dni
FROM people p
WHERE p.first_name LIKE '%S';

--  Nombres de 5 letras
SELECT p.first_name, p.last_name, p.dni
FROM people p
WHERE p.first_name LIKE '____';

-- Vista 2:Todos los profesores con información completa
CREATE OR REPLACE VIEW view_professors AS
SELECT 
    p.person_id,
    p.first_name,
    p.last_name,
    p.dni,
    p.email,
    p.age,
    pp.professor_id,
    pp.category,
    tl.group_id,
    tl.credits
FROM people p
JOIN professors pp ON p.person_id = pp.professor_id
JOIN teaching_loads tl ON pp.professor_id = tl.professor_id;

SELECT *
FROM view_professors;

SELECT COUNT(*) AS total_credits
FROM view_professors;

-- Consulta 29: Average credits of each professor
SELECT v.first_name, v.last_name, AVG(v.credits) AS average_credits
FROM view_professors v
GROUP BY v.person_id, v.first_name, v.last_name;

-- Las 10 personas mas viejas
SELECT p.first_name, p.last_name, p.age
FROM people p 
ORDER BY p.age DESC
LIMIT 3 OFFSET 3;




