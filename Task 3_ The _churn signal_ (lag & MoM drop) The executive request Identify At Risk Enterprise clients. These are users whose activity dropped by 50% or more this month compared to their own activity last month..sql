-- WITH monthly_activity AS (
    SELECT
        u.user_id,
        DATE_TRUNC(DATE(a.event_timestamp), MONTH) AS activity_month,
        COUNT(*) AS monthly_events
    FROM CloudFlow.users u
    JOIN CloudFlow.activity_logs a
        ON u.user_id = a.user_id
    WHERE u.plan_tier = 'Enterprise'
    GROUP BY u.user_id, activity_month
-- ),
-- activity_with_lag AS (
--     SELECT
--         user_id,
--         activity_month,
--         monthly_events,
--         LAG(monthly_events) OVER (
--             PARTITION BY user_id
--             ORDER BY activity_month
--         ) AS previous_month_events
--     FROM monthly_activity
-- )

-- SELECT
--     user_id,
--     activity_month,
--     monthly_events,
--     previous_month_events,
--     SAFE_DIVIDE(
--         monthly_events - previous_month_events,
--         previous_month_events
--     ) AS activity_change_ratio
-- FROM activity_with_lag
-- WHERE previous_month_events IS NOT NULL
--   AND SAFE_DIVIDE(
--         monthly_events - previous_month_events,
--         previous_month_events
--       ) <= -0.5
-- ORDER BY activity_month, user_id;
