CREATE OR REPLACE FUNCTION fnc_trg_person_delete_audit()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO person_audit (created, type_event, row_id, name, age, gender, address)
  VALUES (CURRENT_TIMESTAMP, 'D', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_person_delete_audit
AFTER DELETE ON person
FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_delete_audit();

DELETE FROM person WHERE id = 10;

SELECT * FROM person_audit WHERE row_id = 10 AND type_event = 'D';



-- 1. Создание функции fnc_trg_person_delete_audit:
--  CREATE OR REPLACE FUNCTION fnc_trg_person_delete_audit(): Создает или заменяет функцию с именем fnc_trg_person_delete_audit. OR REPLACE позволяет перезаписывать функцию, если она уже существует.
--  RETURNS TRIGGER: Указывает, что функция возвращает значение типа TRIGGER. Это стандартно для функций триггеров.
--  AS $$ ... $$ LANGUAGE plpgsql;: Определяет тело функции на языке PL/pgSQL. $$ — разделители для многострочного определения функции.
--  BEGIN ... END;: Блок кода функции.
--  INSERT INTO person_audit (created, type_event, row_id, name, age, gender, address) VALUES (CURRENT_TIMESTAMP, 'D', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);: Вставляет запись в таблицу person_audit. CURRENT_TIMESTAMP записывает время удаления, 'D' указывает на тип события (Delete), а OLD содержит данные удаленной строки. Важно, что OLD доступна только в триггерах AFTER DELETE.
--  RETURN OLD;: Возвращает OLD, содержащий информацию об удаленной записи. Хотя в данном случае OLD не используется внутри функции после вставки, его возврат может быть полезен в более сложных сценариях, и это стандартная практика для функций триггеров AFTER DELETE.

-- 2. Создание триггера trg_person_delete_audit:
--  CREATE TRIGGER trg_person_delete_audit: Создает триггер с именем trg_person_delete_audit.
--  AFTER DELETE ON person: Триггер срабатывает после каждого удаления строки из таблицы person.
--  FOR EACH ROW: Триггер выполняется для каждой удаленной строки.
--  EXECUTE FUNCTION fnc_trg_person_delete_audit();: Вызывает функцию fnc_trg_person_delete_audit для обработки удаленной строки.