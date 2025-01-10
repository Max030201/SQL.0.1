SELECT person_id, COUNT (*) AS quantity_of_visits 
FROM person_visits 
GROUP BY person_id 
ORDER BY quantity_of_visits DESC, person_id;