INSERT INTO person_order (id, person_id, menu_id, order_date)
SELECT (idMax.idMax + id) AS id,
       person.id AS person_id,
       men.idPizza AS menu_id,
       '2022-02-25' AS order_date 
FROM person, (SELECT MAX(id) AS idMax FROM person_order) AS idMax,
             (SELECT id AS idPizza FROM menu WHERE pizza_name = 'greek pizza') AS men;