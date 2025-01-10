SELECT person.name, COUNT(*) AS count_of_visits 
FROM person_visits 
JOIN person ON person_visits.person_id = person.id 
GROUP BY 1 
ORDER BY 2 DESC, 1 LIMIT 4;