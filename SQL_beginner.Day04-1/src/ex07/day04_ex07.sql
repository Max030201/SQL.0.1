INSERT INTO person_visits (id, person_id, pizzeria_id, visit_date)
VALUES (
  (SELECT MAX(id) FROM person_visits) + 1,
  (SELECT id FROM person WHERE name = 'Dmitriy'),
  (SELECT id FROM pizzeria WHERE name = 'Pizza Hut'), '2022-01-08');

SELECT *
FROM mv_dmitriy_visits_and_eats;

REFRESH MATERIALIZED VIEW mv_dmitriy_visits_and_eats;

SELECT *
FROM mv_dmitriy_visits_and_eats