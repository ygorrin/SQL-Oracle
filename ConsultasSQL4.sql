--a)	Construya el script para poblar las tablas del Modelo presentado con los datos que se muestran en el ejemplo:
INSERT INTO CURSO VALUES ('1MA', '1 MEDIO A');
INSERT INTO CURSO VALUES ('2MA', '2 MEDIO A');

INSERT INTO alumno VALUES (20987456, 1, 'Juan', null, 'Pérez', 'Soto', 'Los Olivos 2011', 9854654, '1MA');
INSERT INTO alumno VALUES (19345876, 2, 'María', 'Eugenia', 'Carvajal', 'Olivares', '1 norte 512', 7421567, '2MA');

INSERT INTO asignatura VALUES ('LEN1M', 'LENGUAJE 1 MEDIO');
INSERT INTO asignatura VALUES ('MAT2M','MATEMÁTICAS 2 MEDIO'); 

INSERT INTO nota_alumno VALUES ( 20987456, 'LEN1M', 7, 6.5, 5.4, 4.5, NULL, 6, 'A');
INSERT INTO nota_alumno VALUES (19345876, 'MAT2M', 7, 7, 7, 7, 7, 7, 'A'); 

-- b)	Actualice la nota5 y promedio final del alumno con rut 20987456.  Actualice su nota5 en 
-- un 5,8 y actualice el nuevo promedio final.
UPDATE nota_alumno SET nota5 = 5.8 , promedio_final =(nota1 + nota2 + nota3 + nota4 +5.8)/5  
where numrut_alumno = 20987456;

--c)	Seleccione las notas mayores o iguales a 4.0
select nota1, nota2, nota3, nota4, nota5
from nota_alumno
where nota1>=4.0 and nota2>=4.0 and nota3>=4.0 and nota4>=4.0 and nota5>=4.0;

-- d)	Actualice una de las columnas de la tabla Alumno y una de la tabla Asignatura
UPDATE alumno SET snombre = 'Jose';
UPDATE asignatura SET nombre = 'MatMatNuevaMateria';

-- e)	Seleccione la sigla de la asignatura, la descripción de la asignatura, el rut del alumno, 
-- el nombre del alumno y su promedio final.
select a.sigla_asignatura as SiglaAsignatura, a.nombre as Descripcion, 
al.numrut_alumno||'-'||al.dvrut_alumno as RutAlumno, al.pnombre as NombreAlumno, n.promedio_final as PromedioFinal
from alumno al
inner join nota_alumno n on n.numrut_alumno = al.numrut_alumno
inner join asignatura a on a.sigla_asignatura = n.sigla_asignatura;

--f)	Elimine una tupla en cada una de las tablas.
delete from nota_alumno where numrut_alumno = 20987456; 
delete from alumno where numrut_alumno = 20987456; 
delete from curso where sigla_curso = '1MA'; 
delete from asignatura where sigla_asignatura = 'LEN1M'; 

INSERT INTO asignatura VALUES ('LEN1M', 'LENGUAJE 1 MEDIO');
INSERT INTO CURSO VALUES ('1MA', '1 MEDIO A');
INSERT INTO alumno VALUES (20987456, 1, 'Juan', null, 'Pérez', 'Soto', 'Los Olivos 2011', 9854654, '1MA');
INSERT INTO nota_alumno VALUES ( 20987456, 'LEN1M', 7, 6.5, 5.4, 4.5, NULL, 6, 'A');

--g)	Muestre todo el contenido de las tablas.
select * from alumno;
select * from asignatura;
select * from curso;
select* from nota_alumno; 

-- h)	Elimine todo el contenido de las tablas y luego elimine todas las tablas.
delete from alumno; 
delete from asignatura; 
delete from curso; 
delete from nota_alumno; 

drop table alumno cascade constraints;
drop table asignatura cascade constraints;
drop table curso cascade constraints;
drop table notaa_alumno cascade constraints;

-- truncate table asignatura;
-- delete from asignatura;

-- CREACIÓN TABLA ALUMNO
CREATE TABLE ALUMNO
(numrut_alumno NUMBER(10) NOT NULL,
 dvrut_alumno  VARCHAR2(1) NOT NULL,
 pnombre       VARCHAR2(25) NOT NULL,
 snombre       VARCHAR2(25),
 appaterno     VARCHAR2(25) NOT NULL,
 apmaterno     VARCHAR2(25) NOT NULL,
 direccion     VARCHAR2(20) NOT NULL,
 fono          NUMBER(10),
 sigla_curso   VARCHAR2(10),
CONSTRAINT PK_ALUMNO PRIMARY KEY(numrut_alumno),
CONSTRAINT FK_ALUMNO_CURSO FOREIGN KEY(sigla_curso) REFERENCES curso(sigla_curso));
