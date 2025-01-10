insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29');
insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');

CREATE FUNCTION fnc_find_rate_to_usd(pcurrency_id bigint, pdate timestamp)
    RETURNS numeric AS $$
    DECLARE
    rate numeric;
    BEGIN
        SELECT rate_to_usd INTO rate FROM
        (WITH t1 AS (
            SELECT * FROM currency
            WHERE updated < pdate AND pcurrency_id = id
            ORDER BY updated DESC
            LIMIT 1
        ), t2 AS (
            SELECT * FROM currency
            WHERE updated > pdate AND pcurrency_id = id
            ORDER BY updated
            LIMIT 1
        )
        SELECT * FROM t1
        UNION ALL
        (SELECT * FROM t2)
        ORDER BY updated
        LIMIT 1);
        RETURN rate;
    END;
$$ LANGUAGE plpgsql;


SELECT * FROM (
SELECT
    COALESCE("user".name, 'not defined') AS name
    , COALESCE("user".lastname, 'not defined') AS lastname
    , c.name AS currency_name
    , money * fnc_find_rate_to_usd(currency_id, balance.updated) AS currency_in_usd
FROM balance
    LEFT JOIN "user" on "user".id = balance.user_id
    JOIN 
    (SELECT DISTINCT name, id from currency) c
    ON c.id = balance.currency_id
) WHERE currency_name IS NOT NULL
ORDER BY name DESC, lastname, currency_name;