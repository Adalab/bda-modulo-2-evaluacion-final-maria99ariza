USE sakila;

 -- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
 
 SELECT DISTINCT title
	FROM film;
    
-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
/* query de comprobación
SELECT title, rating
	FROM film
    WHERE rating = "PG-13"; */
    
SELECT title
	FROM film
    WHERE rating = "PG-13";
    
--  3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.

SELECT title, description
	FROM film
    WHERE description LIKE '%amazing%';
    
 -- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
    
/* query de comprobación
SELECT title, length
	FROM film
    WHERE length > 120; */
    
SELECT title
	FROM film
    WHERE length > 120;
    
 -- 5. Recupera los nombres de todos los actores.
 
 SELECT first_name
	FROM actor;
    
-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.

SELECT first_name, last_name
	FROM actor
    WHERE last_name IN ('Gibson');
    
 -- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20. (ambos incluídos, supongo)
 
 /* query de comprobación
  SELECT first_name, actor_id
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20; */
    
 SELECT first_name
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20;
    
--  8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.

/* query de comprobación
SELECT title, rating
	FROM film
    WHERE rating NOT IN ('PG-13', 'R'); */
    
SELECT title
	FROM film
    WHERE rating NOT IN ('PG-13', 'R');
    
-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con
-- el recuento.
 
SELECT rating, COUNT(rating) as counting
	FROM film
    GROUP BY rating;
    
-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y
--  apellido junto con la cantidad de películas alquiladas.

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) as counting
	FROM rental as r
    INNER JOIN customer as c
		USING (customer_id)
	GROUP BY c.customer_id;
    
-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento 
-- de alquileres

SELECT c.name as category, COUNT(r.rental_id) as counting
	FROM rental as r
    INNER JOIN inventory
		USING (inventory_id)
	INNER JOIN film_category
		USING (film_id)
	INNER JOIN category as c
		USING (category_id)
	GROUP BY c.name;
    
--  12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la
-- clasificación junto con el promedio de duración.
 
SELECT rating, ROUND(AVG(length)) as 'average length'  -- round to int
	FROM film
    GROUP BY rating;
    
-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".

SELECT first_name, last_name
	FROM actor
    INNER JOIN film_actor
		USING (actor_id)
	INNER JOIN film
		USING (film_id)
	WHERE title = "Indian Love";

--  14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
/* query de comprobación
SELECT title, description
	FROM film
    WHERE description LIKE '%dog%' OR '%cat%';*/
    
SELECT title
	FROM film
    WHERE description LIKE '%dog%' OR '%cat%';
    
-- 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.

SELECT a.first_name, a.last_name, fa.film_id
	FROM actor as a
    LEFT JOIN film_actor as fa
		ON a.actor_id = fa.actor_id
	WHERE film_id IS NULL;  -- Si la lista está vacía, no hay ningún valor nulo y, por lo tanto, 
                            -- todos los actores aparecen en alguna película

-- RESPUESTA: No, todos los actores aparecen en, al menos, una película.

--  16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
	-- Excluyente o no, da igual porque todas las pelis son del año 2006
SELECT title
	FROM film
    WHERE release_year BETWEEN 2005 AND 2010;
    
-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".

SELECT title
	FROM film
	INNER JOIN film_category
		USING (film_id)
	INNER JOIN category
		USING (category_id)
	WHERE name = 'Family';
    
-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
/* querie de comprobación
WITH actors AS (SELECT COUNT(film_id) as counting, actor_id 
						FROM film_actor
                        GROUP BY actor_id
							HAVING counting > 10
				)
SELECT a.first_name, a.last_name, act.counting
	FROM actor as a
    INNER JOIN actors as act
		ON a.actor_id = act.actor_id; */
        
WITH actors AS (SELECT COUNT(film_id) as counting, actor_id -- Seleccionamos los ids de los actores con más de 10 pelis
						FROM film_actor
                        GROUP BY actor_id
							HAVING counting > 10
				)
SELECT a.first_name, a.last_name  -- Le damos nombre a los ids seleccionados en la CTE
	FROM actor as a
    INNER JOIN actors as act
		ON a.actor_id = act.actor_id;

--  19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.
/* querie de comprobación
SELECT title, rating, length
	FROM film
    WHERE rating = 'R' AND length > 120; */

SELECT title
	FROM film
    WHERE rating = 'R' AND length > 120;
    
--  20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el
-- nombre de la categoría junto con el promedio de duración.

SELECT c.name as category, ROUND(AVG(f.length)) as average  -- round to int
	FROM film as f
	INNER JOIN film_category
		USING (film_id)
	INNER JOIN category as c
		USING (category_id)
	GROUP BY c.name
		HAVING average > 120;
        
-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la
-- cantidad de películas en las que han actuado.

WITH actors AS (SELECT COUNT(film_id) as counting, actor_id
						FROM film_actor
                        GROUP BY actor_id
							HAVING counting >= 5
				)
SELECT a.first_name, a.last_name, act.counting
	FROM actor as a
    INNER JOIN actors as act
		ON a.actor_id = act.actor_id;
        
-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para
-- encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.

/* querie de comprobación
SELECT rental_id, DATEDIFF(return_date, rental_date) as difference
	FROM rental
    WHERE DATEDIFF(return_date, rental_date) > 5 */
    
/* Se podría realizar dos subconsultas:
SELECT title
	FROM film
    WHERE film_id IN (SELECT film_id
							FROM inventory
                            WHERE inventory_id IN (SELECT inventory_id
										FROM rental
										WHERE DATEDIFF(return_date, rental_date) > 5
									)
						);

Pero en este caso, el ejercicio sólo nos pide una: */
    
SELECT DISTINCT title  -- En este caso, tenemos que usar el DISTINCT, porque al usar INNER JOIN los títulos se repiten
	FROM film as f
    INNER JOIN inventory as i
		ON f.film_id = i.film_id
		WHERE inventory_id IN (SELECT inventory_id
									FROM rental
									WHERE DATEDIFF(return_date, rental_date) > 5
								);
                                
--  23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror".
-- Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego
-- exclúyelos de la lista de actores.
/* Se podrían realizar varias subconsultas:
SELECT first_name, last_name
	FROM actor
    WHERE actor_id NOT IN (SELECT actor_id 
							FROM film_actor
							WHERE film_id IN (SELECT film_id
													FROM film_category
													WHERE category_id IN (SELECT category_id
																			FROM category
																			WHERE name = 'Horror'
																			)
												)
						)
Pero en este caso, el ejercicio sólo nos pide una: */
                        
SELECT first_name, last_name
	FROM actor
    WHERE actor_id NOT IN (SELECT actor_id    
							FROM film_actor		
							INNER JOIN film_category
								USING (film_id)
							INNER JOIN category
								USING (category_id)
							WHERE name = 'Horror'
							);
-- En lugar de buscar de tabla en tabla, las unimos para sólo tener que buscar en una.
                            
--  24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la
-- tabla film.
-- Con una CTE, seleccionamos los títulos que pertenecen a la categoría 'Comedy':
WITH comedias AS (SELECT title
						FROM film
						WHERE film_id IN (SELECT film_id
												FROM film_category
												INNER JOIN category
													USING (category_id)
												WHERE name = 'Comedy'
												)
				)
-- De esos títulos seleccionados, filtramos por los que tienen una duración mayor a 180 minutos.
SELECT f.title
	FROM film as f
    JOIN comedias as c 
		ON f.title = c.title
    WHERE f.length > 180;
    
--  25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe
-- mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.

/* Querie de comprobación
SELECT A.actor_id AS 'ACTOR 1', B.actor_id AS 'ACTOR 2', COUNT(A.film_id) AS 'FILMS'
	FROM film_actor AS A
	JOIN film_actor AS B
		ON A.film_id = B.film_id
	WHERE A.actor_id <> B.actor_id  -- Aplica a distinguir un actor de sí mismo
	GROUP BY A.actor_id, B.actor_id;
    
Con esta query obtenemos el id de los actores y el número de películas que comparten.
Ahora, hay que añadir los nombres de los actores:
*/

SELECT CONCAT(a1.first_name, ' ', a1.last_name) AS 'ACTOR 1', CONCAT(a2.first_name, ' ', a2.last_name) AS 'ACTOR 2', COUNT(fa1.film_id) AS 'FILMS'
	FROM film_actor as fa1
    INNER JOIN film_actor as fa2
		ON fa1.film_id = fa2.film_id
	INNER JOIN actor as a1
		ON a1.actor_id = fa1.actor_id
	INNER JOIN actor as a2
		ON a2.actor_id = fa2.actor_id
	WHERE fa1.actor_id <> fa2.actor_id
    GROUP BY a1.actor_id, a2.actor_id;
-- A la query anterior, le hemos unido la tabla actor dos veces, una para cada actor de cada columna de actores.
-- Así hemos conseguido relacionar los ids con los nombres de los actores. 