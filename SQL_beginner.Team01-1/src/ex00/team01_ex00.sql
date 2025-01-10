WITH balanc_gr AS (
       SELECT b.user_id,
              b.type,
              b.currency_id,
              SUM(b.money) volume
       FROM balance b
       GROUP BY
              b.user_id,
              b.type,
              b.currency_id
), last_upd_cur AS (
       SELECT DISTINCT ON (name) 
              id,
              name,
              rate_to_usd,
              updated
       FROM currency
       ORDER BY name, updated DESC
) SELECT 
              COALESCE(u.name, 'not defined') name,
              COALESCE(u.lastname, 'not defined') lastname,
              bg.type type,
              bg.volume,
              COALESCE(luc.name, 'not defined') AS currency_name,
              COALESCE(luc.rate_to_usd, 1) last_rate_to_usd,
              bg.volume * COALESCE(luc.rate_to_usd, 1) AS total_volume_in_usd
FROM balanc_gr bg
       LEFT JOIN last_upd_cur luc ON bg.currency_id = luc.id
       LEFT JOIN "user" u ON bg.user_id = u.id
ORDER BY name DESC, lastname, type;



-- 1. CTE balanc_gr:
--   WITH balanc_gr AS (...): Объявляет CTE с именем balanc_gr. CTE — это временная именованная выборка данных, которая доступна только в пределах этого запроса.
--   SELECT b.user_id, b.type, b.currency_id, SUM(b.money) volume: Выбирает user_id, type, currency_id, и суммирует значения money под именем volume.
--   FROM balance b: Указывает, что данные берутся из таблицы balance.
--   GROUP BY b.user_id, b.type, b.currency_id: Группирует результаты по user_id, type, и currency_id, чтобы посчитать сумму money для каждой комбинации этих полей.
-- 2. CTE last_upd_cur:
--   last_upd_cur AS (...): Объявляет второй CTE с именем last_upd_cur.
--   SELECT DISTINCT ON (name) id, name, rate_to_usd, updated: Выбирает уникальные записи по полю name, оставляя только ту запись, у которой значение поля updated максимальное (последняя запись по времени обновления).
--   FROM currency: Указывает, что данные берутся из таблицы currency.
--   ORDER BY name, updated DESC: Сортирует результаты по name (по возрастанию) и updated (по убыванию). DISTINCT ON (name) работает в комбинации с ORDER BY, выбирая первую строку для каждого уникального значения name после сортировки.
-- 3. Основной запрос:
--   SELECT ...: Выбирает значения столбцов. COALESCE заменяет NULL значения на заданное значение (‘not defined’ для имени и фамилии, 1 для rate_to_usd).
--   FROM balanc_gr bg: Начинает запрос с CTE balanc_gr.
--   LEFT JOIN last_upd_cur luc ON bg.currency_id = luc.id: Выполняет левое соединение с CTE last_upd_cur по currency_id.
--   LEFT JOIN "user" u ON bg.user_id = u.id: Выполняет левое соединение с таблицей "user" по user_id. Обратите внимание на кавычки вокруг "user", так как user — зарезервированное слово в SQL.
--   ORDER BY name DESC, lastname, type;: Сортирует результаты по name (по убыванию), lastname, и type.

-- В итоге: Запрос агрегирует данные о балансе пользователей по типу и валюте, используя balanc_gr. Затем он получает последнюю информацию о валютах из таблицы currency с помощью last_upd_cur, избегая дубликатов. Наконец, он объединяет эти данные с информацией о пользователях, обрабатывая возможные NULL значения с помощью COALESCE, и выводит отсортированный результат, показывающий баланс каждого пользователя в каждой валюте, преобразованный в USD.