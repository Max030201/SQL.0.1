CREATE OR REPLACE FUNCTION fnc_trg_person_update_audit()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO person_audit (created, type_event, row_id, name, age, gender, address)
  VALUES (CURRENT_TIMESTAMP, 'U', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_person_update_audit
AFTER UPDATE ON person
FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_update_audit();

UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;

SELECT * FROM person_audit WHERE row_id = 10;



-- 1. Создание функции fnc_trg_person_update_audit:
--   CREATE OR REPLACE FUNCTION fnc_trg_person_update_audit(): Создает или заменяет функцию с именем fnc_trg_person_update_audit. OR REPLACE позволяет пересоздавать функцию, не вызывая ошибки, если она уже существует.
--   RETURNS TRIGGER: Указывает, что функция возвращает значение типа TRIGGER. Это стандартный тип возвращаемого значения для функций, используемых в триггерах.
--   AS $$ ... $$ LANGUAGE plpgsql;: Определяет тело функции, написанное на языке PL/pgSQL. $$ используется как разделитель для определения блока кода.
--   BEGIN ... END;: Блок кода функции.
--   INSERT INTO person_audit (created, type_event, row_id, name, age, gender, address) VALUES (CURRENT_TIMESTAMP, 'U', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);: Вставляет запись в таблицу person_audit. Обратите внимание на использование CURRENT_TIMESTAMP для записи времени обновления, 'U' для обозначения типа события (Update), и OLD для доступа к старым значениям полей записи перед обновлением. OLD — это специальная переменная, доступная внутри функций триггеров AFTER UPDATE, содержащая данные строки до обновления.
--   RETURN NEW;: Возвращает NEW, который содержит информацию о записи после обновления. Это стандартная практика для функций триггеров AFTER UPDATE. Хотя в данном случае NEW не используется внутри функции, его возврат необходим для корректной работы триггера.
--   CREATE TRIGGER trg_person_update_audit: Создает триггер с именем trg_person_update_audit.

-- 2. Создание триггера trg_person_update_audit:
--   AFTER UPDATE ON person: Триггер срабатывает после каждого обновления строки в таблице person.
--   FOR EACH ROW: Триггер выполняется для каждой обновленной строки.
--   EXECUTE FUNCTION fnc_trg_person_update_audit();: Вызывает функцию fnc_trg_person_update_audit для обработки обновленной строки.