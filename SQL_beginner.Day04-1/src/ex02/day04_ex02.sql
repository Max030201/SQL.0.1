CREATE VIEW v_generated_dates AS
SELECT generated_date::date
FROM generate_series(date '2022-01-01', date '2022-01-31', '1 day') AS generated_date
ORDER BY generated_date;

SELECT *
FROM v_generated_dates;