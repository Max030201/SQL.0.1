SELECT DISTINCT person_order.order_date AS action_date, (SELECT person.name FROM person WHERE person.id = person_order.person_id) AS person_name
FROM person_order
JOIN person_visits ON person_order.order_date = person_visits.visit_date
ORDER BY action_date ASC, person_name DESC;