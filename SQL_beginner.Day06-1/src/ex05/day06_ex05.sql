COMMENT ON TABLE person_discounts IS 'Таблица со скидками для клиентов';
COMMENT ON COLUMN person_discounts.id IS 'Уникальный идентификатор';
COMMENT ON COLUMN person_discounts.person_id IS 'Идентификатор клиента';
COMMENT ON COLUMN person_discounts.pizzeria_id IS 'Идентификатор пиццерии';
COMMENT ON COLUMN person_discounts.discount IS 'Скидка клиента';