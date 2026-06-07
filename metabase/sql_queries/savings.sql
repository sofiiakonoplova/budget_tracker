SELECT 
    SUM(CASE WHEN transaction_type = 'Income' THEN amount ELSE 0 END)
  - SUM(CASE WHEN transaction_type = 'Expense' THEN amount ELSE 0 END)
    AS savings
FROM transactions;