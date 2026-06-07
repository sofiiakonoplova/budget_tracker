USE Budget_db;

INSERT  INTO accounts VALUES(1, 'Card'); 
INSERT  INTO accounts VALUES(2, 'Cash'); 

INSERT  INTO categories VALUES(1, 'Salary', 'Income'); 
INSERT  INTO categories VALUES(2, 'Refund', 'Income'); 
INSERT  INTO categories VALUES(3, 'Other', 'Income'); 
INSERT  INTO categories VALUES(4, 'Food', 'Expense'); 
INSERT  INTO categories VALUES(5, 'Rent', 'Expense'); 
INSERT  INTO categories VALUES(6, 'Health', 'Expense'); 
INSERT  INTO categories VALUES(7, 'Utility bills', 'Expense'); 
INSERT  INTO categories VALUES(8, 'Phone', 'Expense'); 
INSERT  INTO categories VALUES(9, 'Entertainment', 'Expense'); 
INSERT  INTO categories VALUES(10, 'Shopping', 'Expense'); 
INSERT  INTO categories VALUES(11, 'Transportation', 'Expense'); 
INSERT  INTO categories VALUES(12, 'Travel', 'Expense'); 
INSERT  INTO categories VALUES(13, 'Gifts', 'Expense'); 

INSERT  INTO transactions VALUES(1, 'Expense', 1, 200, 1, '2026-02-01'); 

SELECT tr.transaction_id, tr.transaction_type, accounts.account_name, tr.amount, categories.category_name, tr.created_at from transactions tr
join accounts on tr.account_id = accounts.account_id 
join categories on tr.category_id = categories.category_id;

DESCRIBE transactions;

SELECT * FROM categories;

CREATE TABLE budgets (
    budget_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    month_year VARCHAR(7) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    UNIQUE(category_id, month_year),
	FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

select * from budgets;





