SELECT 
    DATE_FORMAT(created_at,'%Y-%m') AS month,

	SUM(CASE 
        WHEN transaction_type = 'Income' THEN amount 
        ELSE 0 
    END) AS income_total,
	
    SUM(CASE 
        WHEN transaction_type = 'Expense' THEN amount 
        ELSE 0 
    END) AS expense_total

FROM transactions
GROUP BY month
ORDER BY month;