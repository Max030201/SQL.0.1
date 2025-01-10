DROP TRIGGER IF EXISTS trg_person_insert_audit ON person;
DROP TRIGGER IF EXISTS trg_person_update_audit ON person;
DROP TRIGGER IF EXISTS trg_person_delete_audit ON person;

DROP FUNCTION IF EXISTS fnc_trg_person_insert_audit;
DROP FUNCTION IF EXISTS fnc_trg_person_update_audit;
DROP FUNCTION IF EXISTS fnc_trg_person_delete_audit;

TRUNCATE TABLE person_audit;

CREATE OR REPLACE FUNCTION fnc_trg_person_audit()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO person_audit (created, type_event, row_id, name, age, gender, address)
    VALUES (CURRENT_TIMESTAMP, 'I', NEW.id, NEW.name, NEW.age, NEW.gender, NEW.address);
  ELSIF TG_OP = 'UPDATE' THEN
    INSERT INTO person_audit (created, type_event, row_id, name, age, gender, address)
    VALUES (CURRENT_TIMESTAMP, 'U', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
  ELSIF TG_OP = 'DELETE' THEN
    INSERT INTO person_audit (created, type_event, row_id, name, age, gender, address)
    VALUES (CURRENT_TIMESTAMP, 'D', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_person_audit
AFTER INSERT OR UPDATE OR DELETE ON person
FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_audit();

INSERT INTO person (id, name, age, gender, address) VALUES (10, 'Damir', 22, 'male', 'Irkutsk');
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;
DELETE FROM person WHERE id = 10;

SELECT * FROM person_audit;



-- 1. Создание функции fnc_trg_person_audit:
--   CREATE OR REPLACE FUNCTION fnc_trg_person_audit(): Создает или заменяет функцию с именем fnc_trg_person_audit. OR REPLACE позволяет перезаписать функцию, если она уже существует.
--   RETURNS TRIGGER: Указывает, что функция возвращает значение типа TRIGGER.
--   AS $$ ... $$ LANGUAGE plpgsql;: Определяет тело функции на языке PL/pgSQL.
--   BEGIN ... END;: Блок кода функции.
--   IF TG_OP = 'INSERT' THEN ... ELSIF TG_OP = 'UPDATE' THEN ... ELSIF TG_OP = 'DELETE' THEN ... END IF;: Это условный оператор, который определяет, какой тип операции был выполнен (TG_OP — специальная переменная, содержащая тип операции: ‘INSERT’, ‘UPDATE’ или ‘DELETE’). В зависимости от типа операции выполняется соответствующий INSERT в таблицу person_audit.
--   INSERT INTO person_audit ... VALUES ...;: Вставляет данные в таблицу person_audit. NEW используется для данных новой строки (при вставке), OLD — для данных старой строки (при обновлении и удалении). CURRENT_TIMESTAMP записывает время операции.
--   RETURN NULL;: Возвращает NULL. В этом случае возвращаемое значение не используется, но его возврат необходим по соглашению для функций триггеров.

-- 2. Создание триггера trg_person_audit:
--   CREATE TRIGGER trg_person_audit: Создает триггер с именем trg_person_audit.
--   AFTER INSERT OR UPDATE OR DELETE ON person: Триггер срабатывает после каждой вставки, обновления или удаления строки в таблице person.
--   FOR EACH ROW: Триггер выполняется для каждой затронутой строки.
--   EXECUTE FUNCTION fnc_trg_person_audit();: Вызывает функцию fnc_trg_person_audit для обработки операции.