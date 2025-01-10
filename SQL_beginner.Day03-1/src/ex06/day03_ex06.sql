SELECT m.pizza_name, pz.name AS pizzeria_name_1, pz2.name AS pizzeria_name_2, m.price  
FROM menu m 
JOIN menu m2 ON m2.pizza_name = m.pizza_name AND m2.id < m.id 
JOIN pizzeria pz ON m.pizzeria_id = pz.id
JOIN pizzeria pz2 ON m2.pizzeria_id = pz2.id
WHERE m.price = m2.price
ORDER BY 1, 2, 3, 4;