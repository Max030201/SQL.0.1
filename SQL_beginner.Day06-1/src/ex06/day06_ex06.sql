CREATE SEQUENCE seq_person_discounts START 1;
SELECT SETVAL('seq_person_discounts', (SELECT COUNT(*) FROM person_discounts));
ALTER TABLE person_discounts ALTER COLUMN id SET DEFAULT NEXTVAL('seq_person_discounts');

-- insert into person_discounts (person_id,pizzeria_id,discount)
-- values (4,1,85)

-- select *
-- from person_discounts

-- delete from person_discounts
-- where discount = 85