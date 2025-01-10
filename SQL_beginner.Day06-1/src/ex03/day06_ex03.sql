CREATE UNIQUE INDEX idx_person_discounts_unique ON person_discounts(person_id, pizzeria_id);

SET enable_seqscan = OFF;
EXPLAIN ANALYZE 
SELECT person_id FROM person_discounts;
-- "Index Only Scan using idx_person_discounts_unique on person_discounts  (cost=0.14..12.36 rows=15 width=8) (actual time=0.017..0.022 rows=15 loops=1)"
-- "  Heap Fetches: 15"
-- "Planning Time: 0.073 ms"
-- "Execution Time: 0.036 ms"