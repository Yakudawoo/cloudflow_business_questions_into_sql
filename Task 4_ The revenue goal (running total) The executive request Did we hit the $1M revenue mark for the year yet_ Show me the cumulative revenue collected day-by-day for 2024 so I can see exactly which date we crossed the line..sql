-- WITH daily_revenue AS (
    SELECT
        DATE(paid_date) AS revenue_date,
        SUM(amount) AS daily_amount
    FROM CloudFlow.invoices
    WHERE status = 'paid'
      AND paid_date IS NOT NULL
      AND EXTRACT(YEAR FROM paid_date) = 2024
    GROUP BY revenue_date
    ORDER BY revenue_date ASC
-- )

-- SELECT
--     revenue_date,
--     daily_amount,
--     SUM(daily_amount) OVER (
--         ORDER BY revenue_date
--     ) AS cumulative_revenue
-- FROM daily_revenue
-- ORDER BY revenue_date;
