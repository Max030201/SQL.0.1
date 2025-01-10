CREATE UNIQUE INDEX idx_menu_unique ON menu(pizzeria_id, pizza_name);
SET enable_seqscan = OFF;
EXPLAIN ANALYZE
SELECT * FROM menu 
WHERE pizza_name = 'cheese pizza' AND pizzeria_id = 1;

-- "Index Scan using idx_menu_unique on menu  (cost=0.14..8.16 rows=1 width=35) (actual time=0.076..0.077 rows=1 loops=1)"
-- "  Index Cond: ((pizzeria_id = 1) AND ((pizza_name)::text = 'cheese pizza'::text))"
-- "Planning Time: 2.980 ms"
-- "Execution Time: 0.125 ms"