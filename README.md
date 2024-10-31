# EVALUACIÓN MODULO 2 #

## Extracción de datos en SQL ##

Este proyecto de extracción de datos en SQL está diseñado para realizar análisis trabajando con la base de datos **Sakila** que simula una tienda de alquiler de películas.

## Requisitos Previos

**Base de datos SQL**: Utilizaremos la base de datos Sakila para todas las consultas SQL. Esta base de datos contiene tablas como film (películas), actor (actores), customer (clientes), rental (alquileres), category (categorías) y más. Estas tablas permiten analizar datos en el contexto de una tienda de alquiler de películas.


## Estructura del Proyecto

Los ejercicios incluyen una variedad de consultas SQL, tales como:

- Selección de datos específicos (Ej.: películas, actores, categorías)
- Filtrado de datos (Ej.: películas con ciertas clasificaciones)
- Agregación y conteo de datos (Ej.: recuento de películas por categoría)
- Uso de subconsultas y subconsultas correlacionadas
- Joins y self-joins para relacionar múltiples tablas
- Uso de Common Table Expressions (CTEs) para organizar y simplificar consultas complejas

## Ejemplo de consulta

Esta consulta obtiene los nombres de los actores que han participado en películas con una duración mayor a 120 minutos:

`SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
    f.title AS film_title
FROM 
    actor AS a
JOIN 
    film_actor AS fa ON a.actor_id = fa.actor_id
JOIN 
    film AS f ON fa.film_id = f.film_id
WHERE 
    f.length > 120
ORDER BY 
    actor_name, film_title;`

## Descripción de la Consulta

**SELECT**:

Se selecciona el nombre completo del actor concatenando first_name y last_name, y se asigna un alias actor_name.
También se selecciona el title de la película y se asigna un alias film_title.

**FROM**:

Se utiliza la tabla actor como la tabla principal.

**JOIN**:

Se hace un JOIN con la tabla film_actor para relacionar los actores con las películas en las que han participado.
Luego, se hace otro JOIN con la tabla film para acceder a la información de las películas.

**WHERE**:

Se filtra para incluir solo aquellas películas cuya duración (length) sea mayor a 120 minutos.

**ORDER BY**:

Se ordena el resultado por el nombre del actor y el título de la película.
Esta consulta es más sencilla y directa, mostrando cómo combinar tablas y aplicar filtros básicos.


## Instalación y Configuración

**Clona el repositorio**:
   ```bash
   git clone https://github.com/Adalab/bda-modulo-2-evaluacion-final-maria99ariza.git
   cd bda-modulo-2-evaluacion-final-maria99ariza