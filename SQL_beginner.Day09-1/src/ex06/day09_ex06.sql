CREATE OR REPLACE FUNCTION fnc_person_visits_and_eats_on_date(
  pperson VARCHAR DEFAULT 'Dmitriy',
  pprice NUMERIC DEFAULT 500,
  pdate DATE DEFAULT '2022-01-08'
)
RETURNS TABLE(pizzeria_name VARCHAR) AS $$
BEGIN
  RETURN QUERY
  SELECT DISTINCT pizzeria.name
  FROM person_visits
  JOIN person ON person_visits.person_id = person.id
  JOIN menu ON person_visits.pizzeria_id = menu.pizzeria_id
  JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
  WHERE person.name = pperson
  AND menu.price < pprice
  AND person_visits.visit_date = pdate;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM fnc_person_visits_and_eats_on_date(pprice := 800);

SELECT * FROM fnc_person_visits_and_eats_on_date(pperson := 'Anna', pprice := 1300, pdate := '2022-01-01');



-- 1. Создание функции fnc_person_visits_and_eats_on_date:
--   CREATE OR REPLACE FUNCTION fnc_person_visits_and_eats_on_date(...): Создает или заменяет функцию с именем fnc_person_visits_and_eats_on_date. Она принимает три параметра:
--   pperson VARCHAR DEFAULT 'Dmitriy': Имя человека (по умолчанию ‘Dmitriy’).
--   pprice NUMERIC DEFAULT 500: Максимальная цена (по умолчанию 500).
--   pdate DATE DEFAULT '2022-01-08': Дата посещения (по умолчанию ’2022-01-08’).
--   RETURNS TABLE(pizzeria_name VARCHAR): Функция возвращает таблицу с одним столбцом pizzeria_name типа VARCHAR.
--   AS $$ ... $$ LANGUAGE plpgsql;: Определяет тело функции на языке PL/pgSQL.
--   BEGIN ... END;: Блок кода функции.
--   RETURN QUERY ...;: Эта конструкция используется для возврата результата запроса SQL.
--   SELECT DISTINCT pizzeria.name ...: Запрос SQL, который выбирает уникальные имена пиццерий (pizzeria.name).
--   FROM person_visits JOIN person ON person_visits.person_id = person.id JOIN menu ON person_visits.pizzeria_id = menu.pizzeria_id JOIN pizzeria ON pizzeria.id = menu.pizzeria_id: Это серия JOIN‘ов, которые объединяют четыре таблицы: person_visits, person, menu, и pizzeria для получения необходимой информации.
--   WHERE person.name = pperson AND menu.price < pprice AND person_visits.visit_date = pdate;: Условия фильтрации, которые отбирают записи, соответствующие заданным параметрам функции.
--   $$ LANGUAGE plpgsql;: Указывает, что функция написана на языке PL/pgSQL.
