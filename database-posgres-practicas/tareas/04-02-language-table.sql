

-- Tarea con countryLanguage

-- Crear la tabla de language

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS language_code_seq;


-- Table Definition
CREATE TABLE "public"."language" (
    "code" int4 NOT NULL DEFAULT 	nextval('language_code_seq'::regclass),
    "name" text NOT NULL,
    PRIMARY KEY ("code")
);

-- Crear una columna en countrylanguage
ALTER TABLE countrylanguage
ADD COLUMN languagecode varchar(3);


-- Empezar con el select para confirmar lo que vamos a actualizar
select "language" ,
( select name from "language" b where a."language" = b."name"  )
from countrylanguage a;

select "language" ,
( select code from "language" b where a."language" = b."name"  )
from countrylanguage a;


-- Actualizar todos los registros

--NOTA: primero hacemos un select para ver datos necesarios
SELECT DISTINCT cl.language
FROM "public".countrylanguage cl
order by cl.language asc;

--NOTA: agregamos el insert junto a los datos seleccionados
insert into public.language(name)
SELECT DISTINCT cl.language
FROM "public".countrylanguage cl
order by cl.language asc ;

-- Cambiar tipo de dato en countrylanguage - languagecode por int4
alter table countrylanguage 
	alter column languagecode type int4 using languagecode::integer;


-- Crear el forening key y constraints de no nulo el language_code
ALTER TABLE countrylanguage
ADD CONSTRAINT fk_languagecode_code_language
FOREIGN KEY (languagecode) REFERENCES language(code);

update countrylanguage cl
set languagecode = (select l.code  from "language" l where l."name"  = cl."language"  );

ALTER TABLE countrylanguage
ALTER COLUMN languagecode SET NOT NULL;


-- Revisar lo creado


select * from public.countrylanguage;
--logrado