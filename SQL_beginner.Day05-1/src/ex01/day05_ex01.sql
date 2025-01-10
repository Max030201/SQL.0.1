EXPLAIN ANALYZE
SELECT menu.pizza_name, pizzeria.name AS pizzeria_name 
FROM menu 
JOIN pizzeria ON pizzeria.id = menu.pizzeria_id;

-- "Hash Join  (cost=1.43..22.75 rows=19 width=64) (actual time=0.074..0.083 rows=19 loops=1)"
-- "  Hash Cond: (pizzeria.id = menu.pizzeria_id)"
-- "  ->  Seq Scan on pizzeria  (cost=0.00..18.10 rows=810 width=40) (actual time=0.030..0.031 rows=6 loops=1)"
-- "  ->  Hash  (cost=1.19..1.19 rows=19 width=40) (actual time=0.028..0.028 rows=19 loops=1)"
-- "        Buckets: 1024  Batches: 1  Memory Usage: 10kB"
-- "        ->  Seq Scan on menu  (cost=0.00..1.19 rows=19 width=40) (actual time=0.014..0.018 rows=19 loops=1)"
-- "Planning Time: 0.268 ms"
-- "Execution Time: 0.123 ms"

SET enable_seqscan TO OFF;
EXPLAIN ANALYZE
SELECT menu.pizza_name, pizzeria.name AS pizzeria_name
FROM menu
JOIN pizzeria ON pizzeria.id = menu.pizzeria_id;

-- "Nested Loop  (cost=0.29..63.61 rows=19 width=64) (actual rows=19 loops=1)"
-- "  ->  Index Scan using idx_menu_pizzeria_id on menu  (cost=0.14..12.42 rows=19 width=40) (actual rows=19 loops=1)"
-- "  ->  Index Scan using pizzeria_pkey on pizzeria  (cost=0.15..2.69 rows=1 width=40) (actual rows=1 loops=19)"
-- "        Index Cond: (id = menu.pizzeria_id)"
-- "Planning Time: 0.313 ms"
-- "Execution Time: 0.165 ms"

-- SET enable_seqscan TO OFF;  -  отключение последовательного сканирование строк
-- EXPLAIN ANALYZE  -  план исполнение запроса со стороны базы