-- WITH daily_dau AS (
    SELECT
        DATE(event_timestamp) AS activity_date,
        COUNT(DISTINCT user_id) AS dau
    FROM CloudFlow.activity_logs
    WHERE DATE(event_timestamp) BETWEEN '2023-10-01' AND '2023-12-31'
    GROUP BY activity_date
    ORDER BY activity_date DESC
-- )

-- SELECT
--     activity_date,
--     dau,
--     AVG(dau) OVER (
--         ORDER BY activity_date
--         ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
--     ) AS dau_7d_rolling_avg
-- FROM daily_dau
-- ORDER BY activity_date;
