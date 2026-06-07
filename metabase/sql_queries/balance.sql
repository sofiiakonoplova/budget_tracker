SELECT 
    a.account_id,
    a.account_name,

    SUM(CASE 
        WHEN t.transaction_type = 'Income' THEN t.amount 
        ELSE 0 
    END) -

    SUM(CASE 
        WHEN t.transaction_type = 'Expense' THEN t.amount 
        ELSE 0 
    END) AS balance

FROM accounts a
LEFT JOIN transactions t 
    ON t.account_id = a.account_id

GROUP BY 
    a.account_id,
    a.account_name
ORDER BY 
    balance DESC;