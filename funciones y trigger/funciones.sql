------ funcion modificar las notas del G1 bases de datos (2) por 10, año y periodo. Calificacion = 0.

create or replace function modificar_notas (grupo_ varchar, curso_ varchar, anio_ integer, periodo_ integer) returns real
language plpgsql
as
$$
declare
	modificar real;
	idGrupo integer;
begin
	select count(ins.id) into modificar
	from inscripcion ins join grupo gru on (ins.id_grupo = gru.id) join curso cur on (gru.id_curso = cur.id)
	where gru.nombre = grupo_ and cur.nombre = curso_ and gru.anio = anio_ and gru.periodo = periodo_;

	select gru.id into idGrupo
	from grupo gru join curso cur on (gru.id_curso = cur.id)
	where cur.nombre = curso_ and gru.nombre = grupo_ and gru.periodo = periodo_ and gru.anio = anio_;
		
	update inscripcion
	set calificacion = 90
	where id_grupo = idGrupo;
	
	return modificar;
end;
$$

select modificar_notas('G1', 'Manejo de Bases de Datos', 2020, 2)


create or replace function modificar_notas (grupo_ varchar, curso_ varchar, anio_ integer, periodo_ integer) returns real
language plpgsql
as
$$
declare
	modificar real;
begin
	select count(ins.id) into modificar
	from inscripcion ins join grupo gru on (ins.id_grupo = gru.id) join curso cur on (gru.id_curso = cur.id)
	where gru.nombre = grupo_ and cur.nombre = curso_ and gru.anio = anio_ and gru.periodo = periodo_;
		
	update inscripcion
	set calificacion = 35
	where id_grupo = 
	(
		select gru.id
		from grupo gru join curso cur on (gru.id_curso = cur.id)
		where cur.nombre = curso_ and gru.nombre = grupo_ and gru.periodo = periodo_ and gru.anio = anio_
	) and calificacion = 0;	
	return modificar;
end;
$$

select modificar_notas('G1', 'Manejo de Bases de Datos', 2020, 2)
