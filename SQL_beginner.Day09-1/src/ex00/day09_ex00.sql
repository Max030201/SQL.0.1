CREATE TABLE person_audit (
  created    timestamp with time zone NOT NULL DEFAULT current_timestamp,
  type_event char(1)                  NOT NULL DEFAULT 'I',
  row_id     bigint                   NOT NULL,
  name       varchar,
  age        integer,
  gender     varchar,
  address    varchar,
  constraint ch_type_event check (type_event in ('I', 'D', 'U'))
);

CREATE OR REPLACE FUNCTION fnc_trg_person_insert_audit()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO person_audit(row_id, name, age, gender, address)
  VALUES (NEW.id, NEW.name, NEW.age, NEW.gender, NEW.address);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_person_insert_audit
AFTER INSERT ON person
FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_insert_audit();

INSERT INTO person(id, name, age, gender, address) VALUES (10, 'Damir', 22, 'male', 'Irkutsk');

SELECT * FROM person_audit;



-- 1. Создание таблицы person_audit:
--   CREATE TABLE person_audit: Создает новую таблицу с именем person_audit.
--   created timestamp with time zone NOT NULL DEFAULT current_timestamp: Создает столбец created типа timestamp with time zone, который записывает время и часовой пояс, когда запись была добавлена или изменена в аудиторской таблице. NOT NULL означает, что этот столбец обязательно должен содержать значение. DEFAULT current_timestamp устанавливает значение по умолчанию, равное текущей дате и времени в заданном часовом поясе.
--   type_event char(1) NOT NULL DEFAULT 'I': Создает столбец type_event типа char(1). Это строка длиной 1 символ, который указывает на тип операции (вставка, удаление или обновление). NOT NULL требует значения. DEFAULT 'I' устанавливает значение по умолчанию на ‘I’ (Insert) для новой записи.
--   row_id bigint NOT NULL: Создает столбец row_id типа bigint. Это идентификатор записи в таблице person. NOT NULL означает, что поле обязательно должно быть заполнено.
--   name varchar, age integer, gender varchar, address varchar: Создает столбцы name, age, gender и address с соответствующими типами данных. varchar используется для хранения текстовой информации, integer для целых чисел.
--   constraint ch_type_event check (type_event in ('I', 'D', 'U')): Это важная часть, которая создает ограничение целостности ch_type_event, которое проверяет, что значение в столбце type_event должно быть либо ‘I’ (вставка), ‘D’ (удаление), или ‘U’ (обновление). Это позволяет контролировать и фильтровать данные в аудиторской таблице.

-- 2. Создание функции fnc_trg_person_insert_audit:
--   CREATE OR REPLACE FUNCTION fnc_trg_person_insert_audit(): Создает функцию триггера с именем fnc_trg_person_insert_audit.
--   RETURNS TRIGGER: Функция возвращает объект TRIGGER.
--   AS $$ ... $$ LANGUAGE plpgsql;: Определяет тело функции на языке PL/pgSQL.
--   BEGIN ... END;: Определяет блок кода.
--   INSERT INTO person_audit(row_id, name, age, gender, address) VALUES (NEW.id, NEW.name, NEW.age, NEW.gender, NEW.address);: Вставляет данные из новой записи в таблицу person_audit. NEW - специальная переменная, которая содержит данные из вставляемой записи. NEW.id, NEW.name и т.д. - это ссылки на поля в новой записи.
--   RETURN NEW;: Возвращает измененную запись NEW. Это необходимо, чтобы изменения NEW отразились в таблице person.

-- 3. Создание триггера trg_person_insert_audit:
--   CREATE TRIGGER trg_person_insert_audit: Создает триггер с именем trg_person_insert_audit.
--   AFTER INSERT ON person: Триггер срабатывает после каждой вставки новой строки в таблицу person.
--   FOR EACH ROW: Триггер выполняется для каждой вставленной строки по отдельности.
--   EXECUTE FUNCTION fnc_trg_person_insert_audit();: Вызывает функцию fnc_trg_person_insert_audit для обработки вставленной строки.