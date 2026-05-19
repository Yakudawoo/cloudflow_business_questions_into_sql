-- WITH
--  user_uploads AS (
    SELECT
        u.user_id,
        u.country,
        COUNT(*) AS upload_count
    FROM CloudFlow.users u
    JOIN CloudFlow.activity_logs a
        ON u.user_id = a.user_id
    WHERE a.event_name = 'upload_file'
    GROUP BY u.user_id, u.country
    ORDER BY country DESC
-- ),
-- ranked_uploaders AS (
    -- SELECT
    --     *,
    --     RANK() OVER (
    --         PARTITION BY country
    --         ORDER BY upload_count DESC
    --     ) AS country_rank
    -- FROM user_uploads
-- )

-- SELECT
--     user_id,
--     country,
--     upload_count,
--     country_rank
-- FROM ranked_uploaders
-- WHERE country_rank <= 3
-- ORDER BY country, country_rank;
