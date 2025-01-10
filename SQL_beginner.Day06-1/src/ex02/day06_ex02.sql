SELECT person.name, menu.pizza_name, menu.price, CAST(menu.price * (1 - person_discounts.discount / 100) as numeric(18, 0)), pizzeria.name AS pizzeria_name
FROM person_order
JOIN person ON person_order.person_id = person.id
JOIN menu ON person_order.menu_id = menu.id
JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
JOIN person_discounts ON person_discounts.person_id = person.id AND person_discounts.pizzeria_id = pizzeria.id
ORDER BY person.name, menu.pizza_name;