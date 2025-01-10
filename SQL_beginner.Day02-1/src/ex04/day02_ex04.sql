SELECT pizza_name, pizzeria.name AS pizzeria_name, price
FROM menu
JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
WHERE pizza_name IN ('pepperoni pizza', 'mushroom pizza')
ORDER BY pizza_name, pizzeria_name;