-- 1 Listar todos los proyectos que actualmente estén en ejecución o vigentes
select  distinct(p.codproyecto) as CodProyecto, p.nomproyecto as ProyectoActual, a.fecinicio, a.fectermino
from proyecto p
inner join asignacion a on a.codproyecto = p.codproyecto
where sysdate between a.fecinicio and a.fectermino;

-- 2  Consultar las zonas que poseen empleados
select DISTINCT(zona) as Zonas_Empleados from empleado;

-- 3 Consulta de datos de empleados Run	Apellidos, Nombres	Email Puntaje Sueldo. Ordenar alfabéticamente por apellido.
select rut||'-'||dv as Run, apellidos as Apellidos, nombres as Nombres, email as email, puntaje as puntaje,
to_char(sueldo, '$999,999,999') as Sueldo
from empleado 
order by apellidos asc;

--4 Consulta de empleados por a)	Zona b)	Puntaje  c)	Nombre completo y d)	Sueldo de los empleados.  
-- Ordene las filas por zona.
select zona as Zona, puntaje as Puntaje, nombres||' '||apellidos as NombreCompleto, 
to_char(sueldo, '$999,999,999') as SueldoEmpleados from empleado order by zona asc;

--5 Consulta de los rut de las empresas clientes que tengan algún vínculo con los empleados del centro de investigación. 
select DISTINCT(c.rut)||'-'||c.dv as Rut_Empresa_Cliente_Con_Vinculo_Empleado
from empresa c 
inner join empleado e on e.rutempresa = c.rut;

--6 Consulta de datos básicos de todos los empleados vinculados a las diversas 
-- empresas a)	Rut Empresa b)	Apellidos c)	Nombres d)	Zona e)	Puntaje f)	Sueldo
select (c.rut)||'-'||c.dv as Rut_Empresa, e.apellidos as Apellidos, e.nombres as Nombres, 
e.zona  as Zona, e.puntaje as Puntaje, to_char(e.sueldo, '$999,999,999') as Sueldo
from empresa c 
inner join empleado e on e.rutempresa = c.rut;

----------------------------------------------
--- Script creacion de tablas
DROP TABLE asignacion;
DROP TABLE proyecto;
DROP TABLE empleado;
DROP TABLE empresa;

CREATE TABLE empresa ( 
  rut NUMBER NOT NULL,
  dv VARCHAR2(1) NOT NULL,
  razonsocial VARCHAR2(50) NOT NULL,
  CONSTRAINT empresa_pk PRIMARY KEY (rut)   
);

CREATE TABLE empleado ( 
  rut NUMBER NOT NULL,
  dv CHAR(1) NOT NULL,
  nombres VARCHAR2(20) NOT NULL,
  apellidos VARCHAR2(20) NOT NULL,
  rutempresa NUMBER NOT NULL,
  numproyectos NUMBER NULL,
  puntaje NUMBER NULL,
  sueldo NUMBER NOT NULL,
  email VARCHAR2(30),
  zona VARCHAR2(12),
  fecingreso DATE,
  fecnac DATE,
  numcargas NUMBER(3),
  numinterno VARCHAR2(6), 
  CONSTRAINT pk_empleado PRIMARY KEY (rut),
  CONSTRAINT ak_empleado_numero UNIQUE (numinterno), 
  CONSTRAINT ak_empleado_email UNIQUE (email)
); 

CREATE TABLE proyecto  (
   codproyecto NUMBER NOT NULL,
   nomproyecto VARCHAR2(55) NOT NULL,
   CONSTRAINT pk_proyecto PRIMARY KEY (codproyecto)
);

CREATE TABLE asignacion  (
   idasignacion NUMBER NOT NULL,
   rut NUMBER NOT NULL,
   codproyecto NUMBER NOT NULL,
   fecinicio DATE,
   fectermino DATE,
   horas NUMBER,
   CONSTRAINT pk_asignacion PRIMARY KEY (idasignacion)
);

ALTER TABLE empleado
   ADD CONSTRAINT empresa_empleado_fk1 FOREIGN KEY (rutempresa)
   REFERENCES empresa (rut);
   
ALTER TABLE asignacion
   ADD CONSTRAINT empleado_asignafk1 FOREIGN KEY (rut)
   REFERENCES empleado (rut);

ALTER TABLE asignacion
   ADD CONSTRAINT proyecto_asignafk2 FOREIGN KEY (codproyecto)
   REFERENCES proyecto (codproyecto); 
    
/* Inserta datos en la tabla Empresa */

INSERT INTO empresa VALUES (90147888,'6','Almacenes Torre Eiffel');
INSERT INTO empresa VALUES (92024905,'2','Net-Tel');
INSERT INTO empresa VALUES (92436124,'7','Comunicaciones Bruce Lee');
INSERT INTO empresa VALUES (93350895,'1','Farmacias Oriente, donde lo que paga no se siente');
INSERT INTO empresa VALUES (93741395,'3','Luchezzi');
INSERT INTO empresa VALUES (96874487,'8','NesWatt S.A.');
INSERT INTO empresa VALUES (97923132,'2','Hotel Paraíso');
INSERT INTO empresa VALUES (97948160,'2','Panaderia Rebeca');
INSERT INTO empresa VALUES (98484732,'K','Supermercado Redil');
INSERT INTO empresa VALUES (98691599,'3','CenterHome Camidos');

/* Inserta datos en la tabla Empleado*/

INSERT INTO empleado VALUES (6057969,'6','Elena','Miranda',98484732,4,431,950843,'e.miranda','Centro',to_date('12/01/02','DD/MM/RR'),to_date('17/11/60','DD/MM/RR'),1,'EM0001');
INSERT INTO empleado VALUES (6269943,'8','Rachael','Parsons',98484732,5,343,1445178,'r.parsons','Centro',to_date('14/02/94','DD/MM/RR'),to_date('15/02/71','DD/MM/RR'),0,'EM0002');
INSERT INTO empleado VALUES (6275202,'0','Sheryl','Richards',98484732,9,494,898739,'s.richards','Centro',to_date('25/02/91','DD/MM/RR'),to_date('31/12/75','DD/MM/RR'),5,'EM0003');
INSERT INTO empleado VALUES (6419034,'9','Marci','Frost',98484732,2,494,670765,'m.frost','Sur',to_date('29/10/04','DD/MM/RR'),to_date('06/08/81','DD/MM/RR'),6,'EM0004');
INSERT INTO empleado VALUES (6502066,'1','Timothy','Petty',98484732,5,353,1930422,'t.petty','Centro',to_date('27/04/94','DD/MM/RR'),to_date('24/02/52','DD/MM/RR'),3,'EM0005');
INSERT INTO empleado VALUES (6506702,'K','Leonard','Wilcox',98484732,4,334,335111,'l.wilcox','Centro',to_date('16/05/88','DD/MM/RR'),to_date('06/06/66','DD/MM/RR'),6,'EM0006');
INSERT INTO empleado VALUES (6694138,'K','Leonard','Chambers',98484732,1,421,614416,'l.chambers','Sur',to_date('18/02/97','DD/MM/RR'),to_date('02/06/52','DD/MM/RR'),0,'EM0007');
INSERT INTO empleado VALUES (6756480,'2','Marcie','Phelps',98484732,2,382,1383221,'m.phelps','Centro',to_date('08/06/89','DD/MM/RR'),to_date('02/07/59','DD/MM/RR'),6,'EM0008');
INSERT INTO empleado VALUES (6946767,'8','Seth','Carney',98484732,7,158,1026447,'s.carney','Centro',to_date('22/03/10','DD/MM/RR'),to_date('07/03/54','DD/MM/RR'),3,'EM0009');
INSERT INTO empleado VALUES (7005434,'0','Melissa','Walton',98484732,5,363,847075,'m.walton','Sur',to_date('13/10/86','DD/MM/RR'),to_date('21/11/51','DD/MM/RR'),5,'EM0010');
INSERT INTO empleado VALUES (7034898,'2','Carmen','Friedman',98691599,9,494,1681925,'c.friedman','Poniente',to_date('23/02/99','DD/MM/RR'),to_date('04/01/85','DD/MM/RR'),5,'EM0011');
INSERT INTO empleado VALUES (7150191,'9','Travis','Gamble',98484732,6,173,1408071,'t.gamble','Centro',to_date('05/02/99','DD/MM/RR'),to_date('01/07/69','DD/MM/RR'),2,'EM0012');
INSERT INTO empleado VALUES (7168526,'9','Lewis','Villanueva',92436124,10,126,562049,'l.villanueva','Centro',to_date('07/04/89','DD/MM/RR'),to_date('27/11/81','DD/MM/RR'),2,'EM0013');
INSERT INTO empleado VALUES (7284220,'2','Latasha','Gordon',98484732,6,454,1307600,'l.gordon','Sur',to_date('19/09/84','DD/MM/RR'),to_date('17/06/59','DD/MM/RR'),5,'EM0014');
INSERT INTO empleado VALUES (7380283,'5','Marla','Mc Intyre',98484732,2,152,1346264,'m.mc intyre','Norte',to_date('16/07/06','DD/MM/RR'),to_date('03/01/78','DD/MM/RR'),3,'EM0015');
INSERT INTO empleado VALUES (7503210,'4','Alisa','Cruz',98691599,4,308,1869282,'a.cruz','Centro',to_date('24/08/96','DD/MM/RR'),to_date('24/10/71','DD/MM/RR'),4,'EM0016');
INSERT INTO empleado VALUES (7560327,'1','Dewayne','Rubio',98484732,9,494,1156358,'d.rubio','Centro',to_date('09/11/88','DD/MM/RR'),to_date('19/11/75','DD/MM/RR'),3,'EM0017');
INSERT INTO empleado VALUES (7744083,'0','Rochelle','Marquez',93350895,10,136,569319,'r.marquez','Centro',to_date('29/10/85','DD/MM/RR'),to_date('08/09/64','DD/MM/RR'),4,'EM0018');
INSERT INTO empleado VALUES (7860078,'9','Chris','Pittman',98484732,9,494,614938,'c.pittman','Sur',to_date('10/03/86','DD/MM/RR'),to_date('27/12/66','DD/MM/RR'),0,'EM0019');
INSERT INTO empleado VALUES (7873889,'0','Darius','Pineda',98484732,2,421,1209473,'d.pineda','Centro',to_date('05/08/83','DD/MM/RR'),to_date('26/10/58','DD/MM/RR'),5,'EM0020');
INSERT INTO empleado VALUES (7909083,'2','Teri','Harris',97923132,7,388,1585532,'t.harris','Centro',to_date('10/10/05','DD/MM/RR'),to_date('19/06/81','DD/MM/RR'),3,'EM0021');
INSERT INTO empleado VALUES (7981132,'6','Shauna','Key',97923132,5,175,795164,'s.key','Centro',to_date('16/01/94','DD/MM/RR'),to_date('01/08/83','DD/MM/RR'),6,'EM0022');
INSERT INTO empleado VALUES (8052875,'7','Luke','Shepherd',98484732,8,494,1846733,'l.shepherd','Sur',to_date('25/12/10','DD/MM/RR'),to_date('17/12/53','DD/MM/RR'),5,'EM0024');
INSERT INTO empleado VALUES (8226222,'4','Kris','Marquez',96874487,1,494,992859,'k.marquez','Sur',to_date('16/04/01','DD/MM/RR'),to_date('13/06/83','DD/MM/RR'),1,'EM0026');
INSERT INTO empleado VALUES (8267282,'9','Armando','Roman',97923132,3,494,408304,'a.roman','Centro',to_date('31/03/98','DD/MM/RR'),to_date('04/04/74','DD/MM/RR'),2,'EM0028');
INSERT INTO empleado VALUES (8283331,'3','Trevor','Livingston',96874487,8,296,832934,'t.livingston','Norte',to_date('26/08/09','DD/MM/RR'),to_date('14/09/61','DD/MM/RR'),0,'EM0030');
INSERT INTO empleado VALUES (8317567,'0','Courtney','Boyle',97923132,8,61,1367941,'c.boyle','Poniente',to_date('26/06/90','DD/MM/RR'),to_date('14/12/81','DD/MM/RR'),6,'EM0032');
INSERT INTO empleado VALUES (8424780,'5','Jamie','Callahan',92436124,7,494,341899,'j.callahan','Norte',to_date('29/09/94','DD/MM/RR'),to_date('01/11/63','DD/MM/RR'),6,'EM0034');
INSERT INTO empleado VALUES (8430817,'4','Oscar','Clay',98484732,2,499,1450677,'o.clay','Centro',to_date('08/05/87','DD/MM/RR'),to_date('31/03/79','DD/MM/RR'),3,'EM0035');
INSERT INTO empleado VALUES (8562067,'5','Ramon','Mckay',98484732,2,494,1818838,'r.mckay','Centro',to_date('01/10/03','DD/MM/RR'),to_date('25/01/78','DD/MM/RR'),6,'EM0037');
INSERT INTO empleado VALUES (8629897,'K','Edward','Dominguez',98484732,6,171,750934,'e.dominguez','Centro',to_date('28/06/03','DD/MM/RR'),to_date('04/01/51','DD/MM/RR'),6,'EM0039');
INSERT INTO empleado VALUES (8827284,'4','Geoffrey','Richardson',98484732,2,200,613252,'g.richardson','Poniente',to_date('03/01/80','DD/MM/RR'),to_date('20/04/77','DD/MM/RR'),3,'EM0041');
INSERT INTO empleado VALUES (9026650,'3','Karen','Tate',98484732,1,494,749126,'k.tate','Sur',to_date('19/07/82','DD/MM/RR'),to_date('22/10/76','DD/MM/RR'),6,'EM0043');
INSERT INTO empleado VALUES (9087132,'1','Jimmie','Lyons',98484732,6,494,1392359,'j.lyons','Centro',to_date('22/06/83','DD/MM/RR'),to_date('19/03/55','DD/MM/RR'),5,'EM0045');


INSERT INTO proyecto VALUES (1, 'Campaña Comercial');
INSERT INTO proyecto VALUES (2, 'Construccion Zona Deportiva para el Personal');
INSERT INTO proyecto VALUES (3, 'Optimización en el tratamiento de residuos');
INSERT INTO proyecto VALUES (4, 'Mantención de equipos de producción');

INSERT INTO asignacion VALUES (1, 6057969, 1, to_date('2015-01-01','YYYY-MM-DD'),
to_date('2015-10-31','YYYY-MM-DD'), 300);
INSERT INTO asignacion VALUES (2, 6057969, 2, to_date('2015-01-01','YYYY-MM-DD'),
to_date('2015-10-31','YYYY-MM-DD'), 100);
INSERT INTO asignacion VALUES (3, 6057969, 3, to_date('2015-01-01','YYYY-MM-DD'),
to_date('2015-10-31','YYYY-MM-DD'), 50);
INSERT INTO asignacion VALUES (4, 6057969, 4, to_date('2015-01-01','YYYY-MM-DD'),
to_date('2015-10-31','YYYY-MM-DD'), 200);
INSERT INTO asignacion VALUES (5, 6269943, 1, to_date('2015-01-01','YYYY-MM-DD'),
to_date('2015-10-31','YYYY-MM-DD'), 80);
INSERT INTO asignacion VALUES (6, 6269943, 2, to_date('2015-01-01','YYYY-MM-DD'),
to_date('2015-10-31','YYYY-MM-DD'), 150);
COMMIT;








