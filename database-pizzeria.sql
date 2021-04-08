-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.3
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: pizzeria | type: DATABASE --
-- DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria;
-- ddl-end --


-- object: public.chef | type: TABLE --
-- DROP TABLE IF EXISTS public.chef CASCADE;
CREATE TABLE public.chef (
	id serial NOT NULL,
	nombre varchar(45) NOT NULL,
	apellido varchar(45) NOT NULL,
	CONSTRAINT chef_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.chef OWNER TO postgres;
-- ddl-end --

-- object: public.pizza | type: TABLE --
-- DROP TABLE IF EXISTS public.pizza CASCADE;
CREATE TABLE public.pizza (
	id serial NOT NULL,
	nombre varchar(45) NOT NULL,
	CONSTRAINT pizza_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.pizza OWNER TO postgres;
-- ddl-end --

-- object: public.pizza_chef | type: TABLE --
-- DROP TABLE IF EXISTS public.pizza_chef CASCADE;
CREATE TABLE public.pizza_chef (
	id serial NOT NULL,
	dia date NOT NULL,
	hora time NOT NULL,
	id_chef integer,
	id_pizza integer,
	CONSTRAINT pizza_chef_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.pizza_chef OWNER TO postgres;
-- ddl-end --

-- object: chef_fk | type: CONSTRAINT --
-- ALTER TABLE public.pizza_chef DROP CONSTRAINT IF EXISTS chef_fk CASCADE;
ALTER TABLE public.pizza_chef ADD CONSTRAINT chef_fk FOREIGN KEY (id_chef)
REFERENCES public.chef (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: pizza_fk | type: CONSTRAINT --
-- ALTER TABLE public.pizza_chef DROP CONSTRAINT IF EXISTS pizza_fk CASCADE;
ALTER TABLE public.pizza_chef ADD CONSTRAINT pizza_fk FOREIGN KEY (id_pizza)
REFERENCES public.pizza (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.cliente | type: TABLE --
-- DROP TABLE IF EXISTS public.cliente CASCADE;
CREATE TABLE public.cliente (
	id serial NOT NULL,
	nombre varchar(45) NOT NULL,
	apellido varchar(45) NOT NULL,
	CONSTRAINT cliente_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.cliente OWNER TO postgres;
-- ddl-end --

-- object: public.direccion | type: TABLE --
-- DROP TABLE IF EXISTS public.direccion CASCADE;
CREATE TABLE public.direccion (
	id serial NOT NULL,
	informacion varchar(45) NOT NULL,
	CONSTRAINT direccion_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.direccion OWNER TO postgres;
-- ddl-end --

-- object: public.cliente_direccion | type: TABLE --
-- DROP TABLE IF EXISTS public.cliente_direccion CASCADE;
CREATE TABLE public.cliente_direccion (
	id_cliente integer NOT NULL,
	id_direccion integer NOT NULL,
	CONSTRAINT cliente_direccion_pk PRIMARY KEY (id_cliente,id_direccion)

);
-- ddl-end --
ALTER TABLE public.cliente_direccion OWNER TO postgres;
-- ddl-end --

-- object: cliente_fk | type: CONSTRAINT --
-- ALTER TABLE public.cliente_direccion DROP CONSTRAINT IF EXISTS cliente_fk CASCADE;
ALTER TABLE public.cliente_direccion ADD CONSTRAINT cliente_fk FOREIGN KEY (id_cliente)
REFERENCES public.cliente (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: direccion_fk | type: CONSTRAINT --
-- ALTER TABLE public.cliente_direccion DROP CONSTRAINT IF EXISTS direccion_fk CASCADE;
ALTER TABLE public.cliente_direccion ADD CONSTRAINT direccion_fk FOREIGN KEY (id_direccion)
REFERENCES public.direccion (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.pedido | type: TABLE --
-- DROP TABLE IF EXISTS public.pedido CASCADE;
CREATE TABLE public.pedido (
	numero serial NOT NULL,
	valor integer NOT NULL,
	fecha date NOT NULL,
	hora time NOT NULL,
	id_cliente integer,
	id_domiciliario integer,
	CONSTRAINT pedido_pk PRIMARY KEY (numero)

);
-- ddl-end --
ALTER TABLE public.pedido OWNER TO postgres;
-- ddl-end --

-- object: cliente_fk | type: CONSTRAINT --
-- ALTER TABLE public.pedido DROP CONSTRAINT IF EXISTS cliente_fk CASCADE;
ALTER TABLE public.pedido ADD CONSTRAINT cliente_fk FOREIGN KEY (id_cliente)
REFERENCES public.cliente (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.domiciliario | type: TABLE --
-- DROP TABLE IF EXISTS public.domiciliario CASCADE;
CREATE TABLE public.domiciliario (
	id serial NOT NULL,
	nombre varchar(45) NOT NULL,
	apellido varchar(45) NOT NULL,
	CONSTRAINT domiciliario_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.domiciliario OWNER TO postgres;
-- ddl-end --

-- object: domiciliario_fk | type: CONSTRAINT --
-- ALTER TABLE public.pedido DROP CONSTRAINT IF EXISTS domiciliario_fk CASCADE;
ALTER TABLE public.pedido ADD CONSTRAINT domiciliario_fk FOREIGN KEY (id_domiciliario)
REFERENCES public.domiciliario (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.tamano | type: TABLE --
-- DROP TABLE IF EXISTS public.tamano CASCADE;
CREATE TABLE public.tamano (
	id serial NOT NULL,
	nombre varchar(45) NOT NULL,
	precio integer NOT NULL,
	CONSTRAINT tamano_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.tamano OWNER TO postgres;
-- ddl-end --

-- object: public.pedido_pizza | type: TABLE --
-- DROP TABLE IF EXISTS public.pedido_pizza CASCADE;
CREATE TABLE public.pedido_pizza (
	id serial NOT NULL,
	cantidad integer NOT NULL,
	numero_pedido integer,
	id_tamano integer,
	id_pizza integer,
	CONSTRAINT pedido_pizza_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.pedido_pizza OWNER TO postgres;
-- ddl-end --

-- object: pedido_fk | type: CONSTRAINT --
-- ALTER TABLE public.pedido_pizza DROP CONSTRAINT IF EXISTS pedido_fk CASCADE;
ALTER TABLE public.pedido_pizza ADD CONSTRAINT pedido_fk FOREIGN KEY (numero_pedido)
REFERENCES public.pedido (numero) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: tamano_fk | type: CONSTRAINT --
-- ALTER TABLE public.pedido_pizza DROP CONSTRAINT IF EXISTS tamano_fk CASCADE;
ALTER TABLE public.pedido_pizza ADD CONSTRAINT tamano_fk FOREIGN KEY (id_tamano)
REFERENCES public.tamano (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: pizza_fk | type: CONSTRAINT --
-- ALTER TABLE public.pedido_pizza DROP CONSTRAINT IF EXISTS pizza_fk CASCADE;
ALTER TABLE public.pedido_pizza ADD CONSTRAINT pizza_fk FOREIGN KEY (id_pizza)
REFERENCES public.pizza (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


