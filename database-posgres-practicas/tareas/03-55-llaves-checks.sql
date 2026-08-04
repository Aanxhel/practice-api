-- 1. Crear una llave primaria en city (id)
alter table city
add primary key (id);

-- 2. Crear un check en population, para que no soporte negativos
alter table city add check(
	population  >= 0
);


-- 2.5 me equiboque y cree una constrain sin querer
alter table city 
    drop constraint "city_population_check1";


-- 3. Crear una llave primaria compuesta en "countrylanguage"
-- los campos a usar como llave compuesta son countrycode y language
ALTER TABLE countrylanguage 
ADD PRIMARY KEY (countrycode, language);

-- 4. Crear check en percentage, 
-- Para que no permita negativos ni números superiores a 100

alter table countrylanguage add check(
	(percentage >= 0) and (percentage <= 100)
);
