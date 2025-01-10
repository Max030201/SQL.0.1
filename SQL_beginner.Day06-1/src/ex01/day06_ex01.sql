WITH personal_discounts AS (
  SELECT person_id, pizzeria_id, 
	  CASE 
      WHEN (count(pizzeria_id) = 1) THEN 10.5 
      WHEN (count(pizzeria_id) = 2) THEN 22 
      ELSE 30 
	  END AS discount
  FROM person_order
  JOIN menu ON menu_id = menu.id
  GROUP BY person_id, pizzeria_id
  ORDER BY person_id, pizzeria_id
)
INSERT INTO person_discounts (id, person_id, pizzeria_id, discount)
SELECT ROW_NUMBER() OVER () id, personal_discounts.person_id, personal_discounts.pizzeria_id, discount
FROM personal_discounts