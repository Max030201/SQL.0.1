SELECT generate_series.date AS missing_date
FROM generate_series(date '2022-01-01', date '2022-01-10', interval '1 day')
LEFT JOIN person_visits ON person_visits.visit_date = generate_series.date AND (person_visits.person_id = 1 OR person_visits.person_id = 2)
WHERE person_visits.visit_date IS NULL;