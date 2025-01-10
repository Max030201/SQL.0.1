WITH MaleVisits AS (
  SELECT pizzeria.name
  FROM person_order 
  JOIN menu ON menu.id = person_order.menu_id 
  JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
  JOIN person ON person_order.person_id = person.id 
  WHERE person.gender = 'male'),
FemaleVisits AS (
  SELECT pizzeria.name
  FROM person_order 
  JOIN menu ON menu.id = person_order.menu_id 
  JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
  JOIN person ON person_order.person_id = person.id 
  WHERE person.gender = 'female'),
excFemale AS (
  SELECT * FROM FemaleVisits 
  EXCEPT 
  SELECT * FROM MaleVisits), 
excMale AS (
  SELECT * FROM MaleVisits 
  EXCEPT 
  SELECT * FROM FemaleVisits) 
SELECT name AS pizzeria_name FROM excFemale 
UNION  
SELECT name FROM excMale;