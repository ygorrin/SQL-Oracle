-- 1.- Creación de tablas

create table cliente 
(rut varchar2 (10) not null,
nombre varchar2 (25) not null,
apellido varchar2 (25) not null,
fecha_nacimiento date,
constraint pk_cliente primary key (rut));

create table automovil 
(patente varchar2 (6) not null,
marca varchar2 (25) not null,
modelo varchar2 (25) not null,
rut_dueno varchar2 (10) not null,
constraint pk_automovil primary key (patente),
constraint fk_cliente_rut foreign key (rut_dueno) references cliente (rut));

create table servicios
(cod_servicio number(5) not null,
nombre_servicio varchar2(25) not null,
precio number(8) not null,
constraint pk_cod_servicio primary key(cod_servicio));

create table boleta
(nro_boleta number(5) not null,
rut_cliente  varchar2(10) not null,
fecha date  not null,
total number(8) not null,
constraint pk_nro_boleta primary key (nro_boleta),
constraint fk_rut  foreign key (rut_cliente) references cliente (rut));

create table detalle_boleta
(nro_boleta number (5) not null,
cod_servicio number (5) not null,
precio_cobrado number (8) not null,
constraint pk_cod_servicio_detalle primary key (cod_servicio),
constraint fk_nro_boleta foreign key (nro_boleta) references boleta (nro_boleta));


-- 2.- Creacion de secuencias

create sequence seq_nro_boleta
increment by 1
start with 100;

create sequence seq_cod_servicio
increment by 5
start with 10;

-- 3.- Insertar datos:

insert into cliente values ('11111111-1', 'Yamila', 'Gorrin', TO_DATE ('21-08-1995', 'DDMMYYYY'));
insert into cliente values ('22222222-k', 'Eliesca', 'Hidalgo', TO_DATE ('17-09-1990', 'DDMMYYYY'));
insert into cliente values ('33333333-5', 'Cesar', 'Rivas', TO_DATE ('22-02-1985', 'DDMMYYYY'));

insert into automovil values ('ABCD12', 'Hyundai', 'Accent', '22222222-k');
insert into automovil values ('EFGH34', 'Subarú', 'XXV', '33333333-5');
insert into automovil values ('IJKL56', 'Ferrari', 'MiFerrari', '11111111-1');
insert into automovil values ('MNOP34', 'Toyota', 'Camri', '33333333-5');

insert into servicios values (seq_cod_servicio.NextVal, 'Lavado', 10000);
insert into servicios values (seq_cod_servicio.NextVal, 'Pulido', 15000);
insert into servicios values (seq_cod_servicio.NextVal, 'Aspirado', 8000);
insert into servicios values (seq_cod_servicio.NextVal, 'Lavado+Pulido', 20000);
insert into servicios values (seq_cod_servicio.NextVal, 'Lavado+Pulido+Aspirado', 30000);

insert into boleta values (seq_nro_boleta.NextVal, '11111111-1', to_date ('10-08-2020', 'DDMMYYYY'), 20000);
insert into boleta values (seq_nro_boleta.NextVal, '33333333-5', to_date ('11-08-2020', 'DDMMYYYY'), 30000);

insert into detalle_boleta values (101, 25, 20000);
insert into detalle_boleta values (102, 30, 30000);


-- 4.- Modificación para 1 cliente y 2 servicios.

update cliente set nombre = 'Nicolas' where rut = '33333333-5';
update servicios set nombre_servicio = 'Full Lav+Pul+Asp' where cod_servicio= 30;
update servicios set precio = 21000 where cod_servicio= 25;

--5.	Eliminación de boletas y su detalle.

alter table boleta drop constraint fk_rut;
alter table detalle_boleta drop constraint fk_nro_boleta;
delete boleta;
delete detalle_boleta;

--6.	Truncado de datos para clientes, automóvil y servicio.

truncate table servicios;
alter table automovil drop constraint fk_cliente_rut;
truncate table automovil;
truncate table cliente;