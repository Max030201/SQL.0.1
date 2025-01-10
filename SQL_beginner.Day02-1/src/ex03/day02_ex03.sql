WITH visit AS (
  SELECT person_visits.visit_date 
  FROM person_visits 
  WHERE (person_visits.person_id = 1 OR person_visits.person_id = 2)), 
  date AS (
    SELECT generate_series.date AS missing_date 
    FROM generate_series(date '2022-01-01', date '2022-01-10', interval '1 day'))
SELECT date.missing_date
FROM date 
LEFT JOIN visit ON visit.visit_date = date.missing_date
WHERE visit_date IS NULL;