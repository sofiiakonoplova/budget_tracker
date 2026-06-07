SELECT 
    c.category_name,
    b.amount budget,
    COALESCE(SUM(t.amount),0) spent
FROM budgets b
JOIN categories c ON b.category_id=c.category_id
LEFT JOIN transactions t
    ON t.category_id=b.category_id
   AND DATE_FORMAT(t.created_at,'%Y-%m')=b.month_year
WHERE b.month_year={{month_year}}
GROUP BY c.category_name,b.amount;