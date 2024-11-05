-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-11-05 14:17:13.729
## CREACIÓN DE BASE DE DATOS dbGamarraMarket
CREATE DATABASE dbGamarraMarket;
USE dbGamarraMarket;
-- tables
-- Table: cliente
CREATE TABLE cliente (
    id int NOT NULL,
    tipo_documento char(3) NOT NULL,
    numero_documento char(15) NOT NULL,
    nombre varchar(60) NOT NULL,
    apellido varchar(90) NOT NULL,
    email varchar(80) NULL,
    celular char(9) NULL,
    fecha_nacimiento date NOT NULL,
    activo bool NOT NULL,
    CONSTRAINT cliente_pk PRIMARY KEY (id)
);

-- Table: prenda
CREATE TABLE prenda (
    id int NOT NULL,
    descripcion varchar(90) NOT NULL,
    marca varchar(60) NOT NULL,
    cantidad int NOT NULL,
    talla varchar(10) NOT NULL,
    precio decimal(8,2) NOT NULL,
    activo bool NOT NULL,
    CONSTRAINT prenda_pk PRIMARY KEY (id)
);

-- Table: vendedor
CREATE TABLE vendedor (
    id int NOT NULL,
    tipo_documento char(3) NOT NULL,
    numero_documento char(15) NOT NULL,
    nombre varchar(60) NOT NULL,
    apellido varchar(90) NOT NULL,
    salario decimal(8,2) NOT NULL,
    celular char(9) NULL,
    email varchar(80) NULL,
    activo bool NOT NULL,
    CONSTRAINT vendedor_pk PRIMARY KEY (id)
);

-- Table: venta
CREATE TABLE venta (
    id int NOT NULL,
    fecha_hora timestamp NOT NULL,
    activo bool NOT NULL,
    cliente_id int NOT NULL,
    vendedor_id int NOT NULL,
    CONSTRAINT venta_pk PRIMARY KEY (id)
);

-- Table: venta_detalle
CREATE TABLE venta_detalle (
    id int NOT NULL,
    cantidad int NOT NULL,
    venta_id int NOT NULL,
    prenda_id int NOT NULL,
    CONSTRAINT venta_detalle_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: venta_cliente (table: venta)
ALTER TABLE venta ADD CONSTRAINT venta_cliente FOREIGN KEY venta_cliente (cliente_id)
    REFERENCES cliente (id);

-- Reference: venta_detalle_prenda (table: venta_detalle)
ALTER TABLE venta_detalle ADD CONSTRAINT venta_detalle_prenda FOREIGN KEY venta_detalle_prenda (prenda_id)
    REFERENCES prenda (id);

-- Reference: venta_detalle_venta (table: venta_detalle)
ALTER TABLE venta_detalle ADD CONSTRAINT venta_detalle_venta FOREIGN KEY venta_detalle_venta (venta_id)
    REFERENCES venta (id);

-- Reference: venta_vendedor (table: venta)
ALTER TABLE venta ADD CONSTRAINT venta_vendedor FOREIGN KEY venta_vendedor (vendedor_id)
    REFERENCES vendedor (id);

-- End of file.


create table cliente
(
id int,
tipo_documento char(3),
numero_documento char(9),
nombres varchar(60),
apellidos varchar(90),
email varchar(80),
celular char(9),
fecha_nacimiento date,
activo bool,
CONSTRAINT cliente_pk PRIMARY KEY (id)
);

SHOW COLUMNS IN cliente;

SHOW tables;

/*agregar columna*/
ALTER TABLE cliente
       add column estado_civil char(1);
       
/*eliminamos columna*/
ALTER TABLE cliente
DROP COLUMN fecha_nacimiento;
       
/*eliminamos tabla*/
DROP TABLE cliente;

alter table venta
add constraint venta_cliente foreign key (cliente_id)
references cliente(id)
on update cascade
on delete cascade
;

select
i.constraint_name, k.table_name, k.column_name,
kreferenced_table_name, k.referenced_column_name
from
information_schema.table_constraints i 
left join information_schema.key_column_usage k
on i.contraint_name = k.contraint_name
where i.contraint_type = 'foreign key'
and i.table_schema = database();

alter table venta
drop constraint venta_cliente;
