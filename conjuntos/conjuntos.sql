select pro.nombre, pro.apellido, dep.nombre
from profesor pro join departamento dep on (pro.id_departamento = dep.id)
where dep.nombre = 'MACC' or dep.nombre = 'Economía'

select pro.nombre, pro.apellido, dep.nombre
from profesor pro join departamento dep on (pro.id_departamento = dep.id)
where dep.nombre = 'MACC'
union
select pro.nombre, pro.apellido, dep.nombre
from profesor pro join departamento dep on (pro.id_departamento = dep.id)
where dep.nombre = 'Economía'

-- Cantidad de estudiantes que han aprobado y que no han aprobado
select count(ins.calificacion)
from inscripcion ins
where ins.calificacion >= 30
union
select count(ins.calificacion)
from inscripcion ins
where ins.calificacion < 30

-- ¿Cuántos estudiantes tienen calificacion entre los rangos 00 - 10, 11 - 20, 21 - 30, 31 - 40, 41 - 50?
select count(ins.calificacion)
from inscripcion ins
where ins.calificacion between  00 and 10
union all
select count(ins.calificacion)
from inscripcion ins
where ins.calificacion between  11 and 20
union all
select count(ins.calificacion)
from inscripcion ins
where ins.calificacion between  21 and 30
union all
select count(ins.calificacion)
from inscripcion ins
where ins.calificacion between  31 and 40
union all
select count(ins.calificacion)
from inscripcion ins
where ins.calificacion between  41 and 50

-- Estudiantes (nombre y apellido) que hayan cursado programacion y bases de datos.
select est.nombre, est.apellido
from estudiante est join inscripcion ins on (est.codigo = ins.codigo_estudiante) join grupo gru on (ins.id_grupo = gru.id) join curso cur on (gru.id_curso = cur.id)
where cur.nombre = 'Programacion de Computadores'
intersect
select est.nombre, est.apellido
from estudiante est join inscripcion ins on (est.codigo = ins.codigo_estudiante) join grupo gru on (ins.id_grupo = gru.id) join curso cur on (gru.id_curso = cur.id)
where cur.nombre = 'Manejo de Bases de Datos'

--Estudiantes que ven Bases de Datos sin el prerequisito

select est.nombre, est.apellido
from estudiante est join inscripcion ins on (est.codigo = ins.codigo_estudiante) join grupo gru on (ins.id_grupo = gru.id) join curso cur on (gru.id_curso = cur.id)
where gru.anio= 2021 and cur.nombre = 'Manejo de Bases de Datos'
except
select est.nombre, est.apellido
from estudiante est join inscripcion ins on (est.codigo = ins.codigo_estudiante) join grupo gru on (ins.id_grupo = gru.id) join curso cur on (gru.id_curso = cur.id)
where cur.nombre = 'Programacion de Computadores'

--------
select fac.nombre, dep.nombre
from facultad fac join departamento dep on (fac.id = dep.id_facultad)
--------
select fac.nombre as facultad, dep.nombre as departamento
from facultad fac left join departamento dep on (fac.id = dep.id_facultad)
where fac.nombre = 'Escuela de Medicina'

----- Facultad que tiene nulos. Subconsultas.
select nom_facultad
from (  select fac.nombre as nom_facultad, dep.nombre as nom_departamento
		from facultad fac left join departamento dep on (fac.id = dep.id_facultad)
	 ) as resultado
where nom_departamento is null

--- Consultar profesores del depto MACC que nunca han dictado Bases de Datos

---los que si dictan
select distinct nom_profesores, ape_apellido
from (  select pro.nombre as nom_profesores, pro.apellido as ape_apellido, cur.nombre as nom_curso
		from departamento dep join profesor pro on (dep.id = pro.id_departamento) left join grupo gru on (pro.id = gru.id_profesor)
	  	join curso cur on (cur.id = gru.id_curso)
	 ) as resultado
where nom_curso = 'Manejo de Bases de Datos'

---los que no
select nom_profesor, ape_apellido
from 
	(	select distinct nom_profesor, ape_apellido, nom_curso
		from ( 
			select pro.id as id_profesor, pro.nombre as nom_profesor, pro.apellido as ape_apellido
			from departamento dep join profesor pro on (dep.id = pro.id_departamento)
			where dep.nombre = 'MACC'
			) as profesores
		left join
			(
			select cur.nombre as nom_curso, gru.nombre as nom_grupo, gru.id_profesor as id_profesor_grupo
			from grupo gru join curso cur on (cur.id = gru.id_curso)
			where cur.nombre = 'Manejo de Bases de Datos'
			) as grupos
			on (profesores.id_profesor = grupos.id_profesor_grupo)
	) as profesores_BD
where nom_curso is  null

--- Estudiante que han obtenido calificacion superior al promedio

select est.nombre as nombre_estudiante, gru.nombre as nom_grupo, cur.nombre as nom_curso, ins.calificacion
from estudiante est join inscripcion ins on (est.codigo = ins.codigo_estudiante) join grupo gru on (ins.id_grupo = gru.id)
join curso cur on (gru.id_curso = cur.id)
where ins.calificacion > 
(	select round(avg(ins.calificacion),2)
	from inscripcion ins
	where ins.calificacion >= 30
)



