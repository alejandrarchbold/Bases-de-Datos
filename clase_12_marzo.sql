update estudiante
set mayoria_edad = true


create or replace function func_mayor_edad() returns trigger
language plpgsql 
as
$$
declare
	fecha18 date;
	anio18 int;
	mes int;
	dia int;	
begin 
	if new.fecha_nacimiento <> old.fecha_nacimiento then
		anio18 = extract(year from current_date) - 18;
		mes = extract(month from current_date);
		dia = extract(day from current_date);
		fecha18 = make_date(anio18, mes, dia);
		if new.fecha_nacimiento < fecha18 then 
			update estudiante set mayoria_edad = 'true' 
			where codigo = new.codigo;
		else 
			update estudiante set mayoria_edad = 'false' 
			where codigo = new.codigo;
		end if;
	end if;
	return new;
end;
$$

create trigger trigger_mayor_edad
after update on estudiante 
for each row 
	execute procedure func_mayor_edad();


--- Ejercicio, agregar el atributo promedio_ponderado
--- Actualizar promedio -- Modificar la nota, nueva inscripcion
--- la nota cero no se incluye como calificacion

alter table estudiante add column promedio real not null default 0.0
	
select est.nombre, cur.nombre, cur.creditos, cur.id, gru.id, ins.calificacion
from estudiante est join inscripcion ins on (est.codigo = ins.codigo_estudiante) join grupo gru on (ins.id_grupo = gru.id) join curso cur on (gru.id_curso = cur.id)


insert into grupo (id, nombre, anio, periodo, id_curso, id_profesor) values (13, 'G1', 2021, 1, 8, 4)

update inscripcion
set calificacion = 42
where id_grupo = 2 and codigo_estudiante = 3
insert into inscripcion (id, calificacion, codigo_estudiante, id_grupo) values (17, 42, 3, 11)
insert into inscripcion (id, calificacion, codigo_estudiante, id_grupo) values (18, 45, 3, 5)

create or replace function func_calc_promedio() returns trigger
language plpgsql 
as
$$
declare
	creditos_curso int;
	creditos_est int;
	promedio_est real;
	nuevo_promedio real;
begin
	select cur.creditos into creditos_curso
	from curso cur join grupo gru on (cur.id = gru.id_curso)
	where gru.id = new.id_grupo;
	
	select sum(cur.creditos) into creditos_est
	from curso cur join grupo gru on (cur.id = gru.id_curso)
				   join inscripcion ins on (gru.id = ins.id_grupo)
	where ins.codigo_estudiante = new.codigo_estudiante and ins.id_grupo != new.id_grupo and ins.calificacion != 0;
	
	select promedio into promedio_est
	from estudiante
	where codigo = new.codigo_estudiante;
	
	nuevo_promedio = ((promedio_est * creditos_est) + (creditos_curso * new.calificacion))/(creditos_curso + creditos_est);
	
	update estudiante
	set promedio = nuevo_promedio
	where codigo = new.codigo_estudiante;

	return new;
end;
$$

create trigger trigger_calc_promedio
after insert on inscripcion  -------
for each row
execute procedure func_calc_promedio();

update estudiante set promedio = 43.09 where codigo = 3

delete from inscripcion where id = 19

insert into inscripcion
values(19, 49, 3, 13)


create or replace function func_act_promedio() returns trigger
language plpgsql 
as
$$
declare
	creditos_curso int;
	creditos_est int;
	promedio_est real;
	nuevo_promedio real;
	p1 real;
begin
	select cur.creditos into creditos_curso
	from curso cur join grupo gru on (cur.id = gru.id_curso)
	where gru.id = new.id_grupo;
	
	select sum(cur.creditos) into creditos_est
	from curso cur join grupo gru on (cur.id = gru.id_curso)
				   join inscripcion ins on (gru.id = ins.id_grupo)
	where ins.codigo_estudiante = new.codigo_estudiante and ins.calificacion != 0;
	
	select promedio into promedio_est
	from estudiante
	where codigo = new.codigo_estudiante;
	
	p1 = (promedio_est * creditos_est) - (creditos_curso * old.calificacion);
	
	nuevo_promedio = (p1 + (creditos_curso * new.calificacion)) / creditos_est;
	
	update estudiante
	set promedio = nuevo_promedio
	where codigo = new.codigo_estudiante;

	return new;
end;
$$

create trigger trigger_act_promedio
after update on inscripcion  -------
for each row
execute procedure func_act_promedio();

update inscripcion
set calificacion = 46
where id_grupo = 13 and codigo_estudiante = 3




