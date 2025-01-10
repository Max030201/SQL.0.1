CREATE TABLE paths (
  id int not null primary key,
  point1 varchar(1),
  point2 varchar(1),
  cost int
);

INSERT INTO paths (id, point1, point2, cost) VALUES 
(1, 'a', 'b', 10),
(2, 'b', 'a', 10),
(3, 'a', 'c', 15),
(4, 'c', 'a', 15),
(5, 'a', 'd', 20),
(6, 'd', 'a', 20),
(7, 'b', 'c', 35),
(8, 'c', 'b', 35),
(9, 'b', 'd', 25),
(10, 'd', 'b', 25),
(11, 'c', 'd', 30),
(12, 'd', 'c', 30);

WITH RECURSIVE search_path AS (
  SELECT point1 || ',' || point2 AS text_tour, point1, point2, cost, 1 AS depth 
  FROM paths 
  WHERE point1 = 'a'
  UNION ALL 
  SELECT text_tour || ',' || paths.point2 AS text_tour, paths.point1, paths.point2, paths.cost + search_path.cost, depth + 1
  FROM search_path
  JOIN paths ON search_path.point2 = paths.point1 
  WHERE search_path.text_tour NOT LIKE '%'||paths.point2||'%'
), paths_v_2 AS (
  SELECT * 
  FROM paths 
  WHERE point2 = 'a'
), final AS (
  SELECT paths_v_2.cost + search_path.cost AS total_cost, '{' || search_path.text_tour || ',' || 'a' || '}' AS tour 
  FROM search_path 
  JOIN paths_v_2 ON paths_v_2.point1 = search_path.point2 
  WHERE depth = 3
  ORDER BY 1, 2)
SELECT * 
FROM final 
WHERE total_cost = (SELECT MIN(total_cost) FROM final) 
ORDER BY total_cost, tour;