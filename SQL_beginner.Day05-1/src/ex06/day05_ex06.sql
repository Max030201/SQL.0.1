-- EXPLAIN ANALYZE
-- SELECT
--     m.pizza_name AS pizza_name,
--     max(rating) OVER (PARTITION BY rating ORDER BY rating ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS k
-- FROM  menu m
-- INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
-- ORDER BY 1,2;

-- BEFORE
-- "Sort  (cost=18.83..18.88 rows=19 width=53) (actual time=0.353..0.356 rows=19 loops=1)"
-- "  Sort Key: m.pizza_name, (max(pz.rating) OVER (?))"
-- "  Sort Method: quicksort  Memory: 25kB"
-- "  ->  WindowAgg  (cost=18.09..18.43 rows=19 width=53) (actual time=0.265..0.290 rows=19 loops=1)"
-- "        ->  Sort  (cost=18.05..18.10 rows=19 width=21) (actual time=0.251..0.253 rows=19 loops=1)"
-- "              Sort Key: pz.rating"
-- "              Sort Method: quicksort  Memory: 25kB"
-- "              ->  Nested Loop  (cost=0.28..17.65 rows=19 width=21) (actual time=0.187..0.226 rows=19 loops=1)"
-- "                    ->  Index Only Scan using idx_menu_unique on menu m  (cost=0.14..12.42 rows=19 width=22) (actual time=0.166..0.178 rows=19 loops=1)"
-- "                          Heap Fetches: 19"
-- "                    ->  Memoize  (cost=0.14..0.79 rows=1 width=15) (actual time=0.002..0.002 rows=1 loops=19)"
-- "                          Cache Key: m.pizzeria_id"
-- "                          Cache Mode: logical"
-- "                          Hits: 13  Misses: 6  Evictions: 0  Overflows: 0  Memory Usage: 1kB"
-- "                          ->  Index Scan using pizzeria_pkey on pizzeria pz  (cost=0.13..0.78 rows=1 width=15) (actual time=0.003..0.003 rows=1 loops=6)"
-- "                                Index Cond: (id = m.pizzeria_id)"
-- "Planning Time: 1.680 ms"
-- "Execution Time: 0.432 ms"

CREATE INDEX idx_1 ON menu(pizzeria_id, pizza_name); -- или так: CREATE INDEX idx_1 ON pizzeria(rating); - оба вариата уменьшают время выполнения запроса

-- EXPLAIN ANALYZE
-- SELECT
--     m.pizza_name AS pizza_name,
--     max(rating) OVER (PARTITION BY rating ORDER BY rating ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS k
-- FROM  menu m
-- INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
-- ORDER BY 1,2;

-- AFTER
-- "Sort  (cost=18.83..18.88 rows=19 width=53) (actual time=0.328..0.331 rows=19 loops=1)"
-- "  Sort Key: m.pizza_name, (max(pz.rating) OVER (?))"
-- "  Sort Method: quicksort  Memory: 25kB"
-- "  ->  WindowAgg  (cost=18.09..18.43 rows=19 width=53) (actual time=0.260..0.280 rows=19 loops=1)"
-- "        ->  Sort  (cost=18.05..18.10 rows=19 width=21) (actual time=0.249..0.250 rows=19 loops=1)"
-- "              Sort Key: pz.rating"
-- "              Sort Method: quicksort  Memory: 25kB"
-- "              ->  Nested Loop  (cost=0.28..17.65 rows=19 width=21) (actual time=0.200..0.232 rows=19 loops=1)"
-- "                    ->  Index Only Scan using idx_1 on menu m  (cost=0.14..12.42 rows=19 width=22) (actual time=0.183..0.193 rows=19 loops=1)"
-- "                          Heap Fetches: 19"
-- "                    ->  Memoize  (cost=0.14..0.79 rows=1 width=15) (actual time=0.001..0.002 rows=1 loops=19)"
-- "                          Cache Key: m.pizzeria_id"
-- "                          Cache Mode: logical"
-- "                          Hits: 13  Misses: 6  Evictions: 0  Overflows: 0  Memory Usage: 1kB"
-- "                          ->  Index Scan using pizzeria_pkey on pizzeria pz  (cost=0.13..0.78 rows=1 width=15) (actual time=0.002..0.002 rows=1 loops=6)"
-- "                                Index Cond: (id = m.pizzeria_id)"
-- "Planning Time: 3.444 ms"
-- "Execution Time: 0.391 ms"



-- EXPLAIN ANALYZE
-- SELECT
--     m.pizza_name AS pizza_name,
--     max(rating) OVER (PARTITION BY rating ORDER BY rating ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS k
-- FROM  menu m
-- INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
-- ORDER BY 1,2;

-- BEFORE
-- "Sort  (cost=18.83..18.88 rows=19 width=53) (actual time=0.337..0.340 rows=19 loops=1)"
-- "  Sort Key: m.pizza_name, (max(pz.rating) OVER (?))"
-- "  Sort Method: quicksort  Memory: 25kB"
-- "  ->  WindowAgg  (cost=18.09..18.43 rows=19 width=53) (actual time=0.253..0.278 rows=19 loops=1)"
-- "        ->  Sort  (cost=18.05..18.10 rows=19 width=21) (actual time=0.240..0.242 rows=19 loops=1)"
-- "              Sort Key: pz.rating"
-- "              Sort Method: quicksort  Memory: 25kB"
-- "              ->  Nested Loop  (cost=0.28..17.65 rows=19 width=21) (actual time=0.175..0.220 rows=19 loops=1)"
-- "                    ->  Index Only Scan using idx_menu_unique on menu m  (cost=0.14..12.42 rows=19 width=22) (actual time=0.155..0.167 rows=19 loops=1)"
-- "                          Heap Fetches: 19"
-- "                    ->  Memoize  (cost=0.14..0.79 rows=1 width=15) (actual time=0.002..0.002 rows=1 loops=19)"
-- "                          Cache Key: m.pizzeria_id"
-- "                          Cache Mode: logical"
-- "                          Hits: 13  Misses: 6  Evictions: 0  Overflows: 0  Memory Usage: 1kB"
-- "                          ->  Index Scan using pizzeria_pkey on pizzeria pz  (cost=0.13..0.78 rows=1 width=15) (actual time=0.003..0.003 rows=1 loops=6)"
-- "                                Index Cond: (id = m.pizzeria_id)"
-- "Planning Time: 2.042 ms"
-- "Execution Time: 0.584 ms"


-- CREATE INDEX idx_1 ON pizzeria(rating);


-- EXPLAIN ANALYZE
-- SELECT
--     m.pizza_name AS pizza_name,
--     max(rating) OVER (PARTITION BY rating ORDER BY rating ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS k
-- FROM  menu m
-- INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
-- ORDER BY 1,2;

-- AFTER
-- "Sort  (cost=18.83..18.88 rows=19 width=53) (actual time=0.137..0.139 rows=19 loops=1)"
-- "  Sort Key: m.pizza_name, (max(pz.rating) OVER (?))"
-- "  Sort Method: quicksort  Memory: 25kB"
-- "  ->  WindowAgg  (cost=18.09..18.43 rows=19 width=53) (actual time=0.074..0.093 rows=19 loops=1)"
-- "        ->  Sort  (cost=18.05..18.10 rows=19 width=21) (actual time=0.064..0.066 rows=19 loops=1)"
-- "              Sort Key: pz.rating"
-- "              Sort Method: quicksort  Memory: 25kB"
-- "              ->  Nested Loop  (cost=0.28..17.65 rows=19 width=21) (actual time=0.020..0.048 rows=19 loops=1)"
-- "                    ->  Index Only Scan using idx_menu_unique on menu m  (cost=0.14..12.42 rows=19 width=22) (actual time=0.008..0.016 rows=19 loops=1)"
-- "                          Heap Fetches: 19"
-- "                    ->  Memoize  (cost=0.14..0.79 rows=1 width=15) (actual time=0.001..0.001 rows=1 loops=19)"
-- "                          Cache Key: m.pizzeria_id"
-- "                          Cache Mode: logical"
-- "                          Hits: 13  Misses: 6  Evictions: 0  Overflows: 0  Memory Usage: 1kB"
-- "                          ->  Index Scan using pizzeria_pkey on pizzeria pz  (cost=0.13..0.78 rows=1 width=15) (actual time=0.002..0.002 rows=1 loops=6)"
-- "                                Index Cond: (id = m.pizzeria_id)"
-- "Planning Time: 3.213 ms"
-- "Execution Time: 0.189 ms"