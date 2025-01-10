CREATE INDEX idx_person_order_multi ON person_order (person_id, menu_id);
SET enable_seqscan = OFF;
EXPLAIN ANALYSE
SELECT person_id, menu_id,order_date
FROM person_order
WHERE person_id = 8 AND menu_id = 19;

-- "Index Scan using idx_person_order_multi on person_order  (cost=0.14..8.16 rows=1 width=20) (actual time=0.131..0.131 rows=0 loops=1)"
-- "  Index Cond: ((person_id = 8) AND (menu_id = 19))"
-- "Planning Time: 2.714 ms"
-- "Execution Time: 0.174 ms"