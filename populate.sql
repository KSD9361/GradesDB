DELETE FROM Grades;
DELETE FROM GroupsStudents;
DELETE FROM Students;
DELETE FROM Groups;
DELETE FROM Subjects;
DELETE FROM Degrees;

INSERT INTO Degrees (degreeId, name, years) VALUES
	(1, 'Ingeniería del Software', 4),
	(2, 'Ingeniería del Computadores', 4),
	(3, 'Tecnologías Informáticas', 4);

INSERT INTO Subjects (subjectId, name, acronym, credits, year, type, degreeId) VALUES
	(1, 'Diseño y Pruebas', 'DP', 12, 3, 'Obligatoria', 1),
	(2, 'Acceso Inteligente a la Informacion', 'AII', 6, 4, 'Optativa', 1),
	(3, 'Optimizacion de Sistemas', 'OS', 6, 4, 'Optativa', 1),
	(4, 'Ingeniería de Requisitos', 'IR', 6, 2, 'Obligatoria', 1),
	(5, 'Análisis y Diseño de Datos y Algoritmos', 'ADDA', 12, 2, 'Obligatoria', 1),
	(6, 'Introducción a la Matematica Discreta', 'IMD', 6, 1, 'Formacion Basica', 2),
	(7, 'Redes de Computadores', 'RC', 6, 2, 'Obligatoria', 2),
	(8, 'Teoría de Grafos', 'TG', 6, 3, 'Obligatoria', 2),
	(9, 'Aplicaciones de Soft Computing', 'ASC', 6, 4, 'Optativa', 2),
	(10, 'Fundamentos de Programación', 'FP', 12, 1, 'Formacion Basica', 3),
	(11, 'Lógica Informatica', 'LI', 6, 2, 'Optativa', 3),
	(12, 'Gestión y Estrategia Empresarial', 'GEE', 90, 3, 'Optativa', 3),
	(13, 'Trabajo de Fin de Grado', 'TFG', 12, 4, 'Obligatoria', 3);
	
INSERT INTO Groups (groupId, name, activity, year, subjectId) VALUES
	(1, 'T1', 'Teoria', 2018, 1),
	(2, 'T2', 'Teoria', 2018, 1),
	(3, 'L1', 'Laboratorio', 2018, 1),
	(4, 'L2', 'Laboratorio', 2018, 1),
	(5, 'L3', 'Laboratorio', 2018, 1),
	(6, 'T1', 'Teoria', 2019, 1),
	(7, 'T2', 'Teoria', 2019, 1),
	(8, 'L1', 'Laboratorio', 2019, 1),
	(9, 'L2', 'Laboratorio', 2019, 1),
	(10, 'Teor1', 'Teoria', 2018, 2),
	(11, 'Teor2', 'Teoria', 2018, 2),
	(12, 'Lab1', 'Laboratorio', 2018, 2),
	(13, 'Lab2', 'Laboratorio', 2018, 2),
	(14, 'Teor1', 'Teoria', 2019, 2),
	(15, 'Lab1', 'Laboratorio', 2019, 2),
	(16, 'Lab2', 'Laboratorio', 2019, 2),
	(17, 'T1', 'Teoria', 2019, 10),
	(18, 'T2', 'Teoria', 2019, 10),
	(19, 'T3', 'Teoria', 2019, 10),
	(20, 'L1', 'Laboratorio', 2019, 10),
	(21, 'L2', 'Laboratorio', 2019, 10),
	(22, 'L3', 'Laboratorio', 2019, 10),
	(23, 'L4', 'Laboratorio', 2019, 10),
	(24, 'Clase', 'Teoria', 2019, 12);
	
-- The passwords are securely hashed, they are the part of the email that goes before the @
-- e.g. the password for daniel@alum.us.es is daniel
INSERT INTO Students (studentId, accessMethod, dni, firstname, surname, birthdate, email, password) VALUES
	(1, 'Selectividad', '12345678A', 'Daniel', 'Pérez', '1991-01-01', 'daniel@alum.us.es', 'pbkdf2:sha256:150000$MFDEVOiE$615d831e4343ef1b359a53e031d7a80cdc1345e054dbc79e491e31ffdf2e56b9'),
	(2, 'Selectividad', '22345678A', 'Rafael', 'Ramírez', '1992-01-01', 'rafael@alum.us.es', 'pbkdf2:sha256:150000$JN8MUo8r$0ad468fb8dfaff284a84936f55a0bfbfe075f9989141c79bdf54abc5b230cf7c'),
	(3, 'Selectividad', '32345678A', 'Gabriel', 'Hernández', '1993-01-01', 'gabriel@alum.us.es', 'pbkdf2:sha256:150000$8UcUro47$b23a25f82b6ca0be308e8438d578f0bf66527b6e0df98aaeda43d3bdbd755fdf'),
	(4, 'Selectividad', '42345678A', 'Manuel', 'Fernández', '1994-01-01', 'manuel@alum.us.es', 'pbkdf2:sha256:150000$9dqpV3o2$f5fde5c291600472173cefa753a76dce4714f064a844465b08d501511ff264fc'),
	(5, 'Selectividad', '52345678A', 'Joel', 'Gómez', '1995-01-01', 'joel@alum.us.es', 'pbkdf2:sha256:150000$i6bxfzpR$d06f1fc34ceab664824eaf7078676ed6f8547c8ae327b5ca6ec2fea6460701e8'),
	(6, 'Selectividad', '62345678A', 'Abel', 'López', '1996-01-01', 'abel@alum.us.es', 'pbkdf2:sha256:150000$ddJZiDkz$21cf517286242ab8f007c63520111041a970bcfcc8c3314f2d6c184388c534e6'),
	(7, 'Selectividad', '72345678A', 'Azael', 'González', '1997-01-01', 'azael@alum.us.es', 'pbkdf2:sha256:150000$fNhwqoLc$552959ea838dba9ad6d0fd146325c5c1f5f01d81e9345497d8925e16acae9b4d'),
	(8, 'Selectividad', '8345678A', 'Uriel', 'Martínez', '1998-01-01', 'uriel@alum.us.es', 'pbkdf2:sha256:150000$IvaYiJof$d2a20a20757c27d5be3b743572da50090dfa8b7d6656906bea98f2f079782140'),
	(9, 'Selectividad', '92345678A', 'Gael', 'Sánchez', '1999-01-01', 'gael@alum.us.es', 'pbkdf2:sha256:150000$ZxooBkx2$40c4c6f4832076304e49fb78072e8d1bbee2eee12eb6c531d1851b0a854f088c'),
	(10, 'Titulado Extranjero', '12345678B', 'Noel', 'Álvarez', '1991-02-02', 'noel@alum.us.es', 'pbkdf2:sha256:150000$xzV6zMxL$b0654cb7804042b5a30f95161512b272e907306292be048c272bf909a612e31a'),
	(11, 'Titulado Extranjero', '22345678B', 'Ismael', 'Antúnez', '1992-02-02', 'ismael@alum.us.es', 'pbkdf2:sha256:150000$doZgJryP$e8770b616591e9637032d6fad9c3d13e1d30be4a598af03e7d99f28c46564f11'),
	(12, 'Titulado Extranjero', '32345678B', 'Nathanael', 'Antolinez', '1993-02-02', 'nathanael@alum.us.es', 'pbkdf2:sha256:150000$XIuXo4fh$8544fdae9296d72120ad0ba9be3ae636b491c915f1f5769cb52491cf8ea04659'),
	(13, 'Titulado Extranjero', '42345678B', 'Ezequiel', 'Aznárez', '1994-02-02', 'ezequiel@alum.us.es', 'pbkdf2:sha256:150000$43lkUhWJ$f346521f2e84cffac2fa01b35b817fbe1f933283c595f930a94aac46f8497795'),
	(14, 'Titulado Extranjero', '52345678B', 'Ángel', 'Chávez', '1995-02-02', 'angel@alum.us.es', 'pbkdf2:sha256:150000$wvKjLRDL$bca557874991cbcab4057c762f6b94fe7a27bce91ca980b18cb64e997759eb0d'),
	(15, 'Titulado Extranjero', '62345678B', 'Matusael', 'Gutiérrez', '1996-02-02', 'matusael@alum.us.es', 'pbkdf2:sha256:150000$leccfg3T$0a87e9695e301f6c159022c7c0d4667f5ce3070a15ed2a7f68ccf38c562ac8ff'),
	(16, 'Titulado Extranjero', '72345678B', 'Samael', 'Gálvez', '1997-02-02', 'samael@alum.us.es', 'pbkdf2:sha256:150000$9srTZm4d$1740a181815ae2cd1d02a1a1412a36fc2deb7ee5f870dbafa1ccff33e9dfe87d'),
	(17, 'Titulado Extranjero', '82345678B', 'Baraquiel', 'Ibáñez', '1998-02-02', 'baraquiel@alum.us.es', 'pbkdf2:sha256:150000$9hExqAbF$b6c1ca985988348896d350ed58bee90608326efa46029987bfb92b896a6174e6'),
	(18, 'Titulado Extranjero', '92345678B', 'Otoniel', 'Idiáquez', '1999-02-02', 'otoniel@alum.us.es', 'pbkdf2:sha256:150000$8bMkosVY$8c5b6b2850d32fa56f2106bdc34a8e03fb63a88b2f52e0e60a43a082f4ce221a'),
	(19, 'Titulado Extranjero', '12345678C', 'Niriel', 'Benítez', '1991-03-03', 'niriel@alum.us.es', 'pbkdf2:sha256:150000$FAVqwAhc$4cd334b187d0703382658459e7e5ee05deea6e657613759c8d79f1e1547ea3b3'),
	(20, 'Titulado Extranjero', '22345678C', 'Múriel', 'Bermúdez', '1992-03-03', 'muriel@alum.us.es', 'pbkdf2:sha256:150000$EyOUCUxW$0532f85ac33b660d260c07b016b24a254a0e3bc64e7dfa2f26117be1c5f4670b'),
	(21, 'Titulado Extranjero', '32345678C', 'John', 'AII', '2000-01-01', 'john@alum.us.es', 'pbkdf2:sha256:150000$OH1hCW6D$16d67497e2138b4a5f5dcd0093295dcb7b545130b12f5126d1ba867fff5c0bc5');
	
INSERT INTO GroupsStudents (groupStudentId, groupId, studentId) VALUES
	(1, 1, 1),
	(2, 3, 1),
	(3, 7, 1),
	(4, 8, 1),
	(5, 10, 1),
	(6, 12, 1),
	(7, 2, 2),
	(8, 3, 2),
	(9, 10, 2),
	(10, 12, 2),
	(11, 18, 21),
	(12, 21, 21);
	
INSERT INTO Grades (gradeId, value, gradeCall, withHonours, studentId, groupId) VALUES
	(1, 4.50, 1, 0, 1, 1),
	(2, 3.25, 2, 0, 1, 1),
	(3, 9.95, 1, 0, 1, 7),
	(4, 7.5, 1, 0, 1, 10),
	(5, 2.50, 1, 0, 2, 2),
	(6, 5.00, 2, 0, 2, 2),
	(7, 10.00, 1, 1, 2, 10),
	(8, 0.00, 1, 0, 21, 18),
	(9, 1.25, 2, 0, 21, 18),
	(10, 0.5, 3, 0, 21, 18);