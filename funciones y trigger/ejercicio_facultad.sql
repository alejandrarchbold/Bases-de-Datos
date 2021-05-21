-- 1) Agregar atributo boolean "mayor_edad" a estudiante, por defecto: false.
-- 2) Funcion contar_mayores_edad(nombre de facultad) ¿Cuántos estudiantes son mayores de edad de X facultad?

alter table estudiante add column "mayoria_edad" boolean not null default false
  
create or replace function contar_mayores_edad(nombre_facultad varchar) returns integer
language plpgsql
as
$$
declare
	fecha18 date;
	anio18 integer;
	mes integer;
	dia integer;
	cuenta integer;
	id_dep integer;
begin
	anio18 = extract(year from current_date) - 18;
	mes = extract(month from current_date);
	dia = extract(day from current_date);
	fecha18 = make_date(anio18, mes, dia);
	
	select count(fac.id) into cuenta
	from estudiante est join departamento dep on (est.id_departamento = dep.id) join facultad fac on (dep.id_facultad = fac.id) 
	where est.fecha_nacimiento <= fecha18 and fac.nombre = nombre_facultad;
	
	select dep.id into id_dep
	from estudiante est join departamento dep on (est.id_departamento = dep.id) join facultad fac on (dep.id_facultad = fac.id)
	where fac.nombre = nombre_facultad;
	
	update estudiante
	set mayoria_edad = true
	where id_departamento = id_dep and fecha_nacimiento <= fecha18;
	
	return cuenta;
end
$$

--- Cambiar un estudiante.
update estudiante
set fecha_nacimiento = '2003-05-24'
where apellido = 'Davila Rivera'

--- Para comprobar
update estudiante
set mayoria_edad = false


select contar_mayores_edad('Administracion')

  