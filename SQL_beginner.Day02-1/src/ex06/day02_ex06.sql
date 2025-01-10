SELECT pizza_name, pizzeria.name AS pizzeria_name
FROM menu
JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
JOIN person_order ON menu.id = person_order.menu_id
JOIN person ON person_order.person_id = person.id
WHERE person.name IN ('Denis', 'Anna')
ORDER BY pizza_name, pizzeria_name;