SELECT
  (SELECT name FROM person WHERE person.id = person_order.person_id),
  (SELECT CASE 
   WHEN name = 'Denis' THEN true 
   ELSE false END AS check_name
   FROM person 
   WHERE person.id = person_order.person_id)
FROM person_order
WHERE (menu_id = 13 OR menu_id = 14 OR menu_id = 18) AND order_date = '2022-01-07';