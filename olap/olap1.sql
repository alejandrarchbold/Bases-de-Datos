--- CROSSTAB
create extension tablefunc;
select * from crosstab('select estudiante, curso, nota from calificaciones')
as ct(estudiante varchar(45), Programacion numeric(2,1), BD numeric(2,1), Calculo numeric(2,1), Fisica numeric(2,1)); 
-- ajusto la columna curso para ver los nombres de los cursos con sus notas.
-- en una fila puedo tener todos los resultados de las notas del estudiante x.

--- CUBE	
select estudiante, curso, round(avg(nota),2)
from calificaciones
group by cube(estudiante, curso) --cubo de dos dimensiones
order by estudiante asc, curso asc
-- el null que sale con el estudiante, es el promedio de todos los cursos de ese estudiante.
-- los ultimos null son el promedio de las notas de cada materia, es decir, BD tiene un promedio de 3.8 por los 4 estudiantes que cursaron BD.
-- la ultima fila es el promedio de todo.

--- ROLLUP
select estudiante, curso, round(avg(nota),2)
from calificaciones
group by rollup(estudiante, curso)
order by estudiante asc, curso asc
-- la diferencia con el CUBE es que no tengo los promedios de cada materia de todos los estudiantes, solo el promedio total.

--- GROUPING SET
select estudiante, curso, round(avg(nota),2)
from calificaciones
group by grouping sets(estudiante, curso)
order by estudiante asc, curso asc
-- excluye los valores individuales.
-- promedio de cada dimension.



