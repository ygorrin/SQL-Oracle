-- Consulta Número de mascotas atendidas
select distinct count(codigo) as MascotasAtendidas
from mascota;

-- Numero de perros y gatos atendidos en la clinica
select tipo_mascota as TipoMascota, count(tipo_mascota) as NroAtenciones
from mascota
group by tipo_mascota;

--Consultar Rut del dueño, nombre del dueño, nombre de la mascota y el tipo de mascota
select d.rut as RutDueño, d.nombre as NombreDueño, 
m.nombre as NombreMascota, m.tipo_mascota as TipoMascota
from dueno d inner join mascota m on m.dueno_rut = d.rut;

--Seleccione el nombre del doctor, especialidad y nombre de la mascota
select v.nombre as NombreDoctor, v.especialidad as Especialidad, m.nombre as NombreMascota
from veterinario v inner join mascota m on v.rut=m.veterinario_rut;

-- Seleccione la patente de la clínica, nombre del doctor, rut del doctor y especialidad médica
select c.patente as PatenteClinica, v.nombre||' '||v.apellido as NombreDoctor, 
v.rut as RutDoctor, v.especialidad as EspecilidadDoctor
from veterinario v inner join clinica c on c.patente = v.clinica_patente;

-- Determine el peso promedio de las mascotas ‘perro’ y tipo ‘gato’
select tipo_mascota as tipo, avg(peso) as PesoPromedio from mascota
where tipo_mascota = 'Perro' or tipo_mascota = 'Gato' group by tipo_mascota;

-- Crear Secuencia, para codificar mascotas
create sequence CodificarMascota
increment by 1 start with 1 minvalue 1 maxvalue 200 cycle; 

-- Crear Dueño
insert into dueno(rut, nombre, apellido, telefono, direccion)
values ('4444445-5','Lalin', 'Camil', 99489760, 'Aqui');
select * from dueno;

-- Crear Mascota
insert into mascota (codigo , dueno_rut , edad , nombre , peso , sexo , tipo_mascota , veterinario_rut)
values (CODIFICARMASCOTA.nextval, '4444445-5', 34,'Pinpon',43,'Femenino','Hanster','12345678-7');
insert into mascota (codigo , dueno_rut , edad , nombre , peso , sexo , tipo_mascota , veterinario_rut)
values (CODIFICARMASCOTA.nextval, '4444445-5', 15,'Mimo',11,'Masculino','Hanster','12345678-6');
select * from mascota;

-- Borrar un registro
delete from mascota where codigo = '9';
select * from mascota;

--****** Scrip que crea las bases de datos iniciales**********

CREATE TABLE CLINICA
  (
    patente   VARCHAR2 (50) NOT NULL ,
    direccion VARCHAR2 (50) NOT NULL ,
    telefono  INTEGER NOT NULL
  ) ;
ALTER TABLE CLINICA ADD CONSTRAINT CLINICA_PK PRIMARY KEY ( patente ) ;


CREATE TABLE DUENO
  (
    rut       VARCHAR2 (12) NOT NULL ,
    nombre    VARCHAR2 (50) NOT NULL ,
    apellido  VARCHAR2 (50) NOT NULL ,
    telefono  INTEGER NOT NULL ,
    direccion VARCHAR2 (100) NOT NULL
  ) ;
ALTER TABLE DUENO ADD CONSTRAINT DUENO_PK PRIMARY KEY ( rut ) ;


CREATE TABLE MASCOTA
  (
    codigo          VARCHAR2 (12) NOT NULL ,
    nombre          VARCHAR2 (50) NOT NULL ,
    tipo_mascota    VARCHAR2 (50) NOT NULL ,
    peso            INTEGER NOT NULL ,
    edad            INTEGER NOT NULL ,
    sexo            VARCHAR2 (50) NOT NULL ,
    DUENO_rut       VARCHAR2 (12) NOT NULL ,
    VETERINARIO_rut VARCHAR2 (12) NOT NULL
  ) ;
ALTER TABLE MASCOTA ADD CONSTRAINT MASCOTA_PK PRIMARY KEY ( codigo ) ;

CREATE TABLE VETERINARIO
  (
    rut             VARCHAR2 (12) NOT NULL ,
    nombre          VARCHAR2 (50) NOT NULL ,
    especialidad    VARCHAR2 (50) NOT NULL ,
    apellido        VARCHAR2 (50) NOT NULL ,
    CLINICA_patente VARCHAR2 (50) NOT NULL
  ) ;
ALTER TABLE VETERINARIO ADD CONSTRAINT VETERINARIO_PK PRIMARY KEY ( rut ) ;

ALTER TABLE MASCOTA ADD CONSTRAINT MASCOTA_DUENO_FK FOREIGN KEY ( DUENO_rut ) REFERENCES DUENO ( rut ) ;

ALTER TABLE MASCOTA ADD CONSTRAINT MASCOTA_VETERINARIO_FK FOREIGN KEY ( VETERINARIO_rut ) REFERENCES VETERINARIO ( rut ) ;

ALTER TABLE VETERINARIO ADD CONSTRAINT VETERINARIO_CLINICA_FK FOREIGN KEY ( CLINICA_patente ) REFERENCES CLINICA ( patente ) ;


-- Insertando filas

insert into dueno values ('111111111-1', 'Carolina', 'Torres', 12345678, 'Av Brasil 147');
insert into dueno values ('222222222-2', 'Maria', 'Fuentes', 23242528, 'Av Providencia 4580');
insert into dueno values ('333333333-3', 'Juana', 'Cornejo', 24681012, 'Av Apoquindo 6207');

insert into clinica values ('AB1001', 'Avenida Providencia 1205', 222222222);
insert into clinica values ('AB1002', 'Avenida Manuel Montt 756', 333333333);
insert into clinica values ('AB1003', 'Avenida Irarrazabal 11550', 444444444);

insert into VETERINARIO values ('12345678-5', 'Pedro', 'Cirujano', 'Diaz', 'AB1001');
insert into VETERINARIO values ('12345678-6', 'Juan', 'Cirujano', 'Fuentes', 'AB1002');
insert into VETERINARIO values ('12345678-7', 'Diego', 'Cirujano', 'Hernandez', 'AB1003');

insert into MASCOTA values ('ABC123', 'Barnie', 'Dinosaurio', 200, 120, 'Indeterminado', '111111111-1', '12345678-5');
insert into MASCOTA values ('ABC124', 'Juanito', 'Gato', 5, 10, 'Masculino', '222222222-2', '12345678-6');
insert into MASCOTA values ('ABC125', 'Ruffo', 'Perro', 20, 5, 'Masculino', '333333333-3', '12345678-7');
