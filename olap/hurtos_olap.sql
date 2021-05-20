select count(*) from hurtos

select municipio, edad, count(hurto_id)
from hurtos
group by cube(municipio, edad)
order by municipio asc, edad asc

select departamento, edad, count(hurto_id)
from hurtos
group by cube(departamento, edad)
order by departamento asc, edad asc

select departamento, sexo, count(hurto_id)
from hurtos
group by cube(departamento, sexo)
order by departamento asc, sexo asc

select sexo, departamento, count(hurto_id)
from hurtos
group by rollup(sexo, departamento)
order by sexo asc, departamento asc

--delete from hurtos where departamento = '-' --limpiar datos

select sexo, departamento, count(hurto_id)
from hurtos
group by grouping sets(sexo, departamento)
order by sexo asc, departamento asc

select sexo, estado_civil, departamento, count(hurto_id)
from hurtos
group by grouping sets(sexo, estado_civil, departamento)
order by sexo asc, estado_civil asc, departamento asc


