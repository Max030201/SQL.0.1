-- Session #1
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- Session #2
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;


-- Session #1
SELECT SUM(rating) FROM pizzeria;
-- Session #2
INSERT into pizzeria values (10,'Kazan pizza', 5);
COMMIT;


-- Session #1
SELECT SUM(rating) FROM pizzeria;
COMMIT;
SELECT SUM(rating) FROM pizzeria;
-- Session #2
SELECT SUM(rating) FROM pizzeria;