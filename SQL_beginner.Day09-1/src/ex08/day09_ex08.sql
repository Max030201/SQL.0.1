CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop INTEGER DEFAULT 10)
RETURNS TABLE(fibonacci INTEGER) AS $$
DECLARE
  a INTEGER := 0;
  b INTEGER := 1;
  next INTEGER;
BEGIN
  IF a < pstop THEN
    fibonacci := a;
    RETURN NEXT;
  END IF;
  LOOP
    next := a + b;
    EXIT WHEN next >= pstop;
    fibonacci := next;
    RETURN NEXT;
    a := b;
    b := next;
  END LOOP;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM fnc_fibonacci(100);
SELECT * FROM fnc_fibonacci();



-- 1. Создание функции fnc_fibonacci:
--   CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop INTEGER DEFAULT 10): Эта строка создает или заменяет функцию с именем fnc_fibonacci. Она принимает один параметр: pstop — целое число, которое определяет верхнюю границу последовательности Фибоначчи (по умолчанию 10).
--   RETURNS TABLE(fibonacci INTEGER): Эта строка указывает, что функция возвращает таблицу с одним столбцом fibonacci типа INTEGER.
--   AS $$ ... $$ LANGUAGE plpgsql;: Этот блок содержит тело функции, написанное на языке PL/pgSQL. $$ — разделители для многострочного определения функции.
--   DECLARE: Ключевое слово, которое начинается блок объявления переменных.
--   a INTEGER := 0; b INTEGER := 1; next INTEGER;: Эти строки объявляют три переменные целого типа: a и b инициализируются начальными значениями последовательности Фибоначчи (0 и 1), а next будет хранить следующее число в последовательности.
--   BEGIN ... END;: Блок кода функции.
--   IF a < pstop THEN fibonacci := a; RETURN NEXT; END IF;: Это условное выражение. Если a (первое число Фибоначчи) меньше pstop, то значение a записывается в fibonacci, и выполняется RETURN NEXT, возвращая первое значение последовательности.
--   LOOP ... END LOOP;: Цикл LOOP, который генерирует остальные числа Фибоначчи.
--   next := a + b;: Вычисляет следующее число Фибоначчи.
--   EXIT WHEN next >= pstop;: Прерывает цикл, если следующее число Фибоначчи больше или равно pstop.
--   fibonacci := next; RETURN NEXT;: Записывает вычисленное число в fibonacci и возвращает его с помощью RETURN NEXT. RETURN NEXT — важная конструкция в функциях, возвращающих таблицы: она возвращает текущую строку результата и продолжает выполнение цикла.
--   a := b; b := next;: Обновляет значения a и b для следующей итерации цикла.
--   LANGUAGE plpgsql;: Указывает, что функция написана на языке PL/pgSQL.