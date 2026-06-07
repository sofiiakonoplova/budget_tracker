SELECT *
FROM (
    SELECT 
        DATE_FORMAT(t.created_at,'%Y-%m') AS month,
        c.category_name,
        t.amount,
        RANK() OVER (
            PARTITION BY DATE_FORMAT(t.created_at,'%Y-%m')
            ORDER BY amount DESC
        ) AS rnk
    FROM transactions t
	JOIN categories c ON t.category_id = c.category_id
    WHERE t.transaction_type = 'Expense'
		AND {{ month }}
) x
WHERE rnk <= 3;