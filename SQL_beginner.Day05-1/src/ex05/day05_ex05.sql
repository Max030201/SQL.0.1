CREATE UNIQUE INDEX idx_person_order_order_date ON person_order (person_id, menu_id)
WHERE order_date = '2022-01-01';
SET enable_seqscan TO OFF;
EXPLAIN ANALYZE
SELECT person_id, menu_id
FROM person_order
WHERE order_date = '2022-01-01';

-- "Index Only Scan using idx_person_order_order_date on person_order  (cost=0.13..12.21 rows=5 width=16) (actual time=0.164..0.167 rows=5 loops=1)"
-- "  Heap Fetches: 5"
-- "Planning Time: 2.414 ms"
-- "Execution Time: 0.186 ms"