CREATE OR REPLACE FUNCTION func_minimum(arr NUMERIC[])
RETURNS NUMERIC AS $$
DECLARE
  min_value NUMERIC := arr[1];
  num NUMERIC;
BEGIN
  FOREACH num IN ARRAY arr LOOP
    IF num < min_value THEN
      min_value := num;
    END IF;
  END LOOP;
  RETURN min_value;
END;
$$ LANGUAGE plpgsql;



SELECT func_minimum(VARIADIC ARRAY[10.0, -1.0, 5.0, 4.4]);

SELECT func_minimum(ARRAY[10.0, -1.0, 5.0, 4.4]);



-- 1. Создание или замена функции func_minimum:
--   CREATE OR REPLACE FUNCTION func_minimum(arr NUMERIC[]): Эта строка объявляет функцию с именем func_minimum. CREATE OR REPLACE указывает, что если функция уже существует, она будет заменена. arr NUMERIC[] объявляет параметр функции — массив arr типа NUMERIC.
--   RETURNS NUMERIC: Эта строка указывает, что функция возвращает значение типа NUMERIC.
--   AS $$ ... $$ LANGUAGE plpgsql;: Этот блок определяет тело функции, написанное на языке PL/pgSQL. $$ — разделители для многострочного определения функции.
--   DECLARE: Это ключевое слово, которое начинает блок объявления переменных.
--   min_value NUMERIC := arr[1];: Эта строка объявляет переменную min_value типа NUMERIC и инициализирует ее первым элементом массива arr. Это предположение, что массив не пуст.
--   num NUMERIC;: Эта строка объявляет переменную num типа NUMERIC. Эта переменная будет использоваться для хранения текущего элемента массива в цикле.
--   BEGIN ... END;: Этот блок содержит основной код функции.
--   FOREACH num IN ARRAY arr LOOP ... END LOOP;: Это цикл FOREACH, который перебирает каждый элемент массива arr. В каждой итерации цикла текущий элемент массива записывается в переменную num.
--   IF num < min_value THEN min_value := num; END IF;: Эта строка проверяет, меньше ли текущий элемент num текущего минимального значения min_value. Если да, то min_value обновляется значением num.
--   RETURN min_value;: После того, как цикл переберет все элементы массива, функция возвращает значение переменной min_value, которая теперь содержит минимальное значение из массива.
--   LANGUAGE plpgsql;: Эта строка указывает, что функция написана на языке PL/pgSQL.