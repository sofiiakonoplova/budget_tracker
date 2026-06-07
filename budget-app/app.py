from flask import Flask, render_template, request, redirect
import mysql.connector
from datetime import date, datetime
import os
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password=os.getenv("DB_PASSWORD"),
    database="Budget_db"
)

@app.route("/")
def index():    
    month = request.args.get("month")
    if not month:
        month = datetime.today().strftime("%Y-%m")

    selected = datetime.strptime(month, "%Y-%m")

    # previous month
    if selected.month == 1:
        prev_month = f"{selected.year-1}-12"
    else:
        prev_month = f"{selected.year}-{selected.month-1:02d}"

    # next month
    if selected.month == 12:
        next_month = f"{selected.year+1}-01"
    else:
        next_month = f"{selected.year}-{selected.month+1:02d}"
    cursor = db.cursor(dictionary=True)
   
    query = """
    SELECT 
        tr.transaction_id,
        tr.transaction_type,
        a.account_name,
        tr.amount,
        c.category_name,
        tr.created_at
    FROM transactions tr
    JOIN accounts a ON tr.account_id = a.account_id
    JOIN categories c ON tr.category_id = c.category_id
    WHERE DATE_FORMAT(tr.created_at, '%Y-%m') = %s
    ORDER BY tr.created_at DESC
    """
    cursor.execute(query, (month,))
    data = cursor.fetchall()

    cursor.execute("SELECT * FROM categories")
    categories = cursor.fetchall()

    cursor.execute("""
        SELECT *
        FROM categories
        WHERE transaction_type='Expense'
        """)
    expense_categories = cursor.fetchall()

    cursor.execute("""
    SELECT
        c.category_name,
        b.amount AS budget_amount,
        IFNULL(SUM(t.amount),0) AS spent,
        ROUND(IFNULL(SUM(t.amount),0) / b.amount * 100,1) AS percent_used
    FROM budgets b
    JOIN categories c
    ON b.category_id = c.category_id
    LEFT JOIN transactions t
    ON t.category_id = b.category_id
    AND t.transaction_type='Expense'
    AND DATE_FORMAT(t.created_at,'%Y-%m') = b.month_year
    WHERE b.month_year = %s
    GROUP BY c.category_name, b.amount
    """, (month,))
    budgets = cursor.fetchall()


    return render_template("index.html", transactions=data, categories=categories, expense_categories=expense_categories, budgets=budgets, month=month, prev_month=prev_month,
        next_month=next_month, today=date.today())

@app.route("/add", methods=["POST"])
def add():
    transaction_type = request.form["transaction_type"]
    account_id = request.form["account_id"]
    amount = request.form["amount"]
    category_id = request.form["category_id"]
    created_at = request.form["created_at"]

    cursor = db.cursor()
    sql = """
    INSERT INTO transactions(transaction_type, account_id, amount, category_id, created_at)
    VALUES (%s,%s,%s,%s,%s)
    """
    cursor.execute(sql, (transaction_type, account_id, amount, category_id, created_at))
    db.commit()

    return redirect("/")

@app.route("/delete/<int:id>")
def delete(id):
    cursor = db.cursor()

    sql = "DELETE FROM transactions WHERE transaction_id = %s"
    cursor.execute(sql, (id,))
    db.commit()

    return redirect("/")

@app.route("/set_budget", methods=["POST"])
def set_budget():

    category_id = request.form["category_id"]
    amount = request.form["amount"]
    month = request.form["month"]

    cursor = db.cursor()

    sql = """
    INSERT INTO budgets(category_id, month_year, amount)
    VALUES (%s,%s,%s)

    ON DUPLICATE KEY UPDATE
    amount = VALUES(amount)
    """

    cursor.execute(sql, (category_id, month, amount))
    db.commit()

    return redirect(f"/?month={month}")

if __name__ == "__main__":
    app.run(debug=True)