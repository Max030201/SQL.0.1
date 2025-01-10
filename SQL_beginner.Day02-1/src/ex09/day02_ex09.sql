SELECT name 
FROM person 
JOIN person_order ON person_order.person_id = person.id 
JOIN menu ON menu.id = person_order.menu_id
WHERE person.gender = 'female' and menu.pizza_name = 'pepperoni pizza' 
INTERSECT 
SELECT name 
FROM person 
JOIN person_order ON person_order.person_id = person.id
JOIN menu ON menu.id = person_order.menu_id
WHERE person.gender = 'female' and menu.pizza_name = 'cheese pizza'
ORDER BY name;


