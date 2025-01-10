SELECT person_order.order_date, CONCAT(pi.name || ' (age:' || pi.age || ')') AS person_information
FROM person_order 
NATURAL JOIN (SELECT person.id AS person_id, person.name, person.age FROM person) pi
ORDER BY order_date ASC, person_information ASC;