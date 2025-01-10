WITH pvp AS (
  SELECT pizzeria.name, gender FROM person_visits
  JOIN person ON person_id = person.id
  JOIN pizzeria ON pizzeria_id = pizzeria.id),
  pv_male AS (
    SELECT name 
    FROM pvp 
    WHERE gender = 'male'),
  pv_female AS (
    SELECT name 
    FROM pvp 
    WHERE gender = 'female')
SELECT name AS pizzeria_name
FROM (
    (SELECT * FROM pv_male EXCEPT ALL SELECT * FROM pv_female)
    UNION ALL
    (SELECT * FROM pv_female EXCEPT ALL SELECT * FROM pv_male)
     ) AS uall
ORDER BY pizzeria_name;
