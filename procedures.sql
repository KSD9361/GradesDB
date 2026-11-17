--
-- Autor: Inas
-- Fecha: Noviembre de 2026
-- Descripción: Procedimientos almacenados de grades_db
-- Se incluye en: iissi1/labs/L4 y L7 (en fragmentos) y AN-B
--

USE grades_db;

DELIMITER //

-- Borra todas las notas del alumno con el DNI indicado
CREATE OR REPLACE PROCEDURE p_delete_student_grades(
    IN p_student_dni CHAR(9)
)
BEGIN
    DECLARE v_student_id INT;

    -- El DNI está en people; el id del alumno es el de la persona (herencia)
    SELECT student_id INTO v_student_id
    FROM people p
    JOIN students s ON s.student_id = p.person_id
    WHERE p.dni = p_student_dni;

    DELETE FROM grades WHERE student_id = v_student_id;
END //

-- Borra todos los datos de la BD sin borrar las tablas
CREATE OR REPLACE PROCEDURE p_delete_all_data()
BEGIN
    -- Primero las tablas que referencian a otras y después las referenciadas,
    -- para que ninguna fila se quede apuntando a una que ya no existe (FK)
    DELETE FROM grades;
    DELETE FROM teaching_loads;
    DELETE FROM students_groups;
    DELETE FROM students_subjects;
    DELETE FROM groups;
    DELETE FROM subjects;
    DELETE FROM students;
    DELETE FROM professors;
    DELETE FROM degrees;
    DELETE FROM people;
END //

-- Devuelve en el parámetro de salida p_average la nota media del alumno
-- (NULL si no tiene notas). Compárese con la función f_student_average (L5)
CREATE OR REPLACE PROCEDURE p_student_average(
    IN p_student_id INT,
    OUT p_average DECIMAL(4,2)
)
BEGIN
    SELECT AVG(grade_value) INTO p_average
    FROM grades
    WHERE student_id = p_student_id;
END //

-- Sube un 15 % las notas entre 4.5 y 8 de un grupo en una convocatoria
-- (sin pasar de 10) y muestra cuántas notas ha cambiado
CREATE OR REPLACE PROCEDURE p_boost_group_grades(
    IN p_group_id INT,
    IN p_exam_call VARCHAR(20)
)
BEGIN
    DECLARE v_affected_rows INT;
    DECLARE v_group_name VARCHAR(40);

    SELECT group_name INTO v_group_name
    FROM groups
    WHERE group_id = p_group_id;

    UPDATE grades
    -- LEAST devuelve el menor de los dos: la nota no pasa de 10
    SET grade_value = LEAST(grade_value * 1.15, 10.0)
    WHERE group_id = p_group_id
      AND exam_call = p_exam_call
      AND grade_value BETWEEN 4.5 AND 8.0;

    -- ROW_COUNT(): filas modificadas por la última sentencia (el UPDATE)
    SET v_affected_rows = ROW_COUNT();

    SELECT v_group_name AS group_name,
           v_affected_rows AS updated_grades;
END //

-- Asigna las matrículas de honor de un grupo en una convocatoria: a las
-- mejores notas a partir de 9, como máximo al 5 % de los alumnos del grupo
CREATE OR REPLACE PROCEDURE p_assign_honors(
    IN p_group_id INT,
    IN p_exam_call VARCHAR(20)
)
BEGIN
    DECLARE v_total_students INT;
    DECLARE v_max_honors INT;

    SELECT COUNT(*) INTO v_total_students
    FROM students_groups
    WHERE group_id = p_group_id;

    -- FLOOR redondea hacia abajo: con menos de 20 alumnos no hay matrículas
    SET v_max_honors = FLOOR(v_total_students * 0.05);

    IF v_max_honors = 0 THEN
        SELECT CONCAT('No se pueden asignar matrículas de honor: ',
                      'el 5% de ', v_total_students,
                      ' estudiantes matriculados es 0') AS mensaje;
    ELSE
        -- Se quitan las matrículas anteriores para volver a asignarlas
        UPDATE grades
        SET with_honors = 0
        WHERE group_id = p_group_id
          AND exam_call = p_exam_call;

        -- MariaDB no admite LIMIT en una subconsulta con IN: por eso las notas
        -- elegidas se calculan en una tabla derivada (selected_grades)
        UPDATE grades
        SET with_honors = 1
        WHERE grade_id IN (
            SELECT selected_grades.grade_id
            FROM (
                SELECT grade_id
                FROM grades
                WHERE group_id = p_group_id
                  AND exam_call = p_exam_call
                  AND grade_value >= 9.0
                ORDER BY grade_value DESC
                LIMIT v_max_honors
            ) AS selected_grades
        );
    END IF;
END //

-- Inserta un grado y una asignatura de ese grado. Sin transacción: si falla
-- el INSERT de la asignatura, el grado se queda insertado
CREATE OR REPLACE PROCEDURE p_insert_degree_subject(
    IN p_degree_name VARCHAR(80),
    IN p_degree_years TINYINT,
    IN p_subject_name VARCHAR(120),
    IN p_subject_acronym VARCHAR(12),
    IN p_subject_credits TINYINT,
    IN p_subject_course TINYINT,
    IN p_subject_type VARCHAR(30)
)
BEGIN
    DECLARE v_new_degree_id INT;

    INSERT INTO degrees (degree_name, duration_years)
    VALUES (p_degree_name, p_degree_years);

    -- LAST_INSERT_ID(): id AUTO_INCREMENT asignado por el último INSERT
    SET v_new_degree_id = LAST_INSERT_ID();

    INSERT INTO subjects (degree_id, subject_name, acronym, credits, course, subject_type)
    VALUES (v_new_degree_id, p_subject_name, p_subject_acronym,
            p_subject_credits, p_subject_course, p_subject_type);
END //

-- Llama a p_insert_degree_subject dentro de una transacción: si falla
-- cualquiera de sus dos INSERT, se deshacen ambos
CREATE OR REPLACE PROCEDURE p_insert_degree_subject_transactional(
    IN p_degree_name VARCHAR(80),
    IN p_degree_years TINYINT,
    IN p_subject_name VARCHAR(120),
    IN p_subject_acronym VARCHAR(12),
    IN p_subject_credits TINYINT,
    IN p_subject_course TINYINT,
    IN p_subject_type VARCHAR(30)
)
BEGIN
    -- Ante cualquier error se deshace la transacción y se relanza el error
    -- (RESIGNAL) para que lo reciba quien llamó al procedimiento
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Mismas inserciones que la versión no transaccional, sin repetir su código
    CALL p_insert_degree_subject(p_degree_name, p_degree_years,
                                 p_subject_name, p_subject_acronym,
                                 p_subject_credits, p_subject_course, p_subject_type);

    COMMIT;
END //

DELIMITER ;
