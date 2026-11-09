DELIMITER //
CREATE OR REPLACE PROCEDURE ejemplo_variables_locales()
BEGIN
    DECLARE v_contador INT DEFAULT 0;
    DECLARE v_nombre VARCHAR(100);
    DECLARE v_promedio DECIMAL(4,2);
    
    -- Asignar valores
    SET v_contador = 10;
    SELECT first_name INTO v_nombre FROM people WHERE person_id = 1;
    
    SELECT v_contador, v_nombre;
END //
DELIMITER ;
-- Asignar valor directamente
SET @resultado = 100;

-- Asignar desde una consulta
SELECT AVG(grade_value) INTO @promedio_general FROM grades;

-- Usar en procedimientos
CALL p_student_average(6, @promedio_estudiante);

-- Consultar el valor
SELECT @promedio_estudiante;
CREATE OR REPLACE PROCEDURE ejemplo_in(
    IN p_student_id INT
)
BEGIN
    SELECT * FROM students WHERE student_id = p_student_id;
END;
CREATE OR REPLACE PROCEDURE ejemplo_out(
    IN p_student_id INT,
    OUT p_average DECIMAL(4,2)
)
BEGIN
    SELECT AVG(grade_value) INTO p_average
    FROM grades
    WHERE student_id = p_student_id;
END;
CREATE OR REPLACE PROCEDURE ejemplo_inout(
    INOUT p_contador INT
)
BEGIN
    SET p_contador = p_contador + 1;
END;
DELIMITER //
CREATE OR REPLACE PROCEDURE p_calculate_and_store(
    IN p_student_id INT,          -- Parámetro de entrada
    OUT p_result DECIMAL(4,2)     -- Parámetro de salida
)
BEGIN
    DECLARE v_count INT;           -- Variable local
    DECLARE v_sum DECIMAL(6,2);    -- Variable local
    
    -- Contar notas del estudiante
    SELECT COUNT(*), SUM(grade_value) 
    INTO v_count, v_sum
    FROM grades
    WHERE student_id = p_student_id;
    
    -- Calcular promedio
    IF v_count > 0 THEN
        SET p_result = v_sum / v_count;
    ELSE
        SET p_result = 0;
    END IF;
    
    -- Guardar en variable de usuario para uso posterior
    SET @last_calculation = p_result;
END //
DELIMITER ;

-- Uso del procedimiento
CALL p_calculate_and_store(6, @average);
SELECT @average AS 'Promedio', @last_calculation AS 'Última calculada';
DELIMITER //
CREATE OR REPLACE PROCEDURE nombre_procedimiento(
    IN param1 TIPO,
    IN param2 TIPO,
    OUT resultado TIPO
)
BEGIN
    -- Cuerpo del procedimiento
    -- Instrucciones SQL
END //
DELIMITER ;
-- Borrar las notas del estudiante con DNI '10000006F'
CALL p_delete_student_grades('10000006F');

-- Verificar que se borraron
SELECT * FROM grades g
JOIN students s ON s.student_id = g.student_id
JOIN people p ON p.person_id = s.student_id
WHERE p.dni = '10000006F';
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
-- Borrar todos los datos (¡cuidado con esta operación!)
CALL p_delete_all_data();

-- Verificar que las tablas están vacías
SELECT COUNT(*) AS total_grades FROM grades;
SELECT COUNT(*) AS total_students FROM students;
SELECT COUNT(*) AS total_people FROM people;
