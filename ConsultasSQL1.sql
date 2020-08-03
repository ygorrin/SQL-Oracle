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

