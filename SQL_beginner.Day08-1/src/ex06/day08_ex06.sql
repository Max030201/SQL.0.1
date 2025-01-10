-- Session #1
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- Session #2
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;


-- Session #1
SELECT SUM(rating) FROM pizzeria;
-- Session #2
INSERT into pizzeria values (11,'Kazan pizza 2', 4);
COMMIT;


-- Session #1
SELECT SUM(rating) FROM pizzeria;
COMMIT;
SELECT SUM(rating) FROM pizzeria;
-- Session #2
SELECT SUM(rating) FROM pizzeria;