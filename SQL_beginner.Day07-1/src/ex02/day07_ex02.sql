WITH visits AS (
  SELECT pizzeria.name, COUNT(pizzeria.name), 'visit' AS action_type 
  FROM person_visits 
  JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id 
  GROUP BY pizzeria.name 
  ORDER BY count DESC 
  LIMIT 3 
), orders AS ( 
  SELECT pizzeria.name, COUNT(pizzeria.name), 'order' AS action_type 
  FROM person_order 
  JOIN menu ON person_order.menu_id = menu.id 
  JOIN pizzeria ON menu.pizzeria_id = pizzeria.id 
  GROUP BY pizzeria.name 
  ORDER BY count DESC 
  LIMIT 3 
) 
SELECT name, count, action_type 
FROM visits 
UNION ALL 
SELECT name, count, action_type 
FROM orders 
ORDER BY action_type ASC, count DESC;