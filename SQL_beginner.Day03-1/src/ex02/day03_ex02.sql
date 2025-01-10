WITH id_not_order AS (
  SELECT id AS menu_id
  FROM menu
  EXCEPT
  SELECT person_order.menu_id
  FROM person_order)
SELECT menu.pizza_name, menu.price, pizzeria.name
FROM id_not_order
JOIN menu ON menu.id = id_not_order.menu_id
JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
ORDER BY pizza_name, price;