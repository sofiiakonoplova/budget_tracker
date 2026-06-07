SELECT 
    c.category_name,
    SUM(t.amount) AS total_spent
FROM transactions t
JOIN categories c
    ON t.category_id = c.category_id
WHERE c.transaction_type = 'Expense'
	AND {{month_year}}
GROUP BY c.category_name
ORDER BY total_spent DESC;