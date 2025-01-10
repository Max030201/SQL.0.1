CREATE INDEX idx_person_name ON person (UPPER(name));
SET enable_seqscan TO OFF;
EXPLAIN ANALYZE
SELECT *
FROM person
WHERE UPPER(name) = 'DENIS';

-- "Index Scan using idx_person_name on person  (cost=0.14..8.15 rows=1 width=33) (actual time=0.057..0.059 rows=1 loops=1)"
-- "  Index Cond: (upper((name)::text) = 'DENIS'::text)"
-- "Planning Time: 0.205 ms"
-- "Execution Time: 0.098 ms"