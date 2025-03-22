use creditscoredb;

# 1. Problem: Identify Customers with High-Risk Credit Scores
SELECT c.customer_id, c.first_name, c.last_name, cs.credit_score, cs.risk_level
FROM Customers c
JOIN Credit_Scores cs ON c.customer_id = cs.customer_id
WHERE cs.risk_level = 'High';

# 2. Problem: List All Approved Loan Applications
SELECT la.application_id, c.first_name, c.last_name, la.requested_amount, la.application_date
FROM Loan_Applications la
JOIN Customers c ON la.customer_id = c.customer_id
WHERE la.application_status = 'Approved';

# 3. Problem: Find Customers with Late Payments
SELECT c.customer_id, c.first_name, c.last_name, ph.payment_amount, ph.payment_date, ph.payment_status
FROM Payment_History ph
JOIN Loan_History lh ON ph.loan_id = lh.loan_id
JOIN Customers c ON lh.customer_id = c.customer_id
WHERE ph.payment_status = 'Late';

#4. Problem: Calculate Total Loan Amount for Each Customer

SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    SUM(lh.loan_amount) AS total_loan_amount
FROM 
    Loan_History lh
JOIN 
    Customers c ON lh.customer_id = c.customer_id
GROUP BY 
    c.customer_id
ORDER BY 
    total_loan_amount DESC; -- Order by highest loan amount first
    
#5. Problem: List All Loans with Collateral Value less Than Loan Amount

    SELECT lh.loan_id, lh.loan_amount, col.collateral_value
FROM Loan_History lh
JOIN Collateral col ON lh.loan_id = col.loan_id
WHERE col.collateral_value < lh.loan_amount;

# 6. Problem: Find Customers with Missed Payments
SELECT c.customer_id, c.first_name, c.last_name, ph.payment_amount, ph.payment_date, ph.payment_status
FROM Payment_History ph
JOIN Loan_History lh ON ph.loan_id = lh.loan_id
JOIN Customers c ON lh.customer_id = c.customer_id
WHERE ph.payment_status = 'Missed';

# 7. Problem: Calculate Average Credit Score by Employment Status
SELECT c.employment_status, AVG(cs.credit_score) AS average_credit_score
FROM Customers c
JOIN Credit_Scores cs ON c.customer_id = cs.customer_id
GROUP BY c.employment_status;

# 8.Problem: Find Customers with Loans Exceeding Their Annual Income
SELECT c.customer_id, c.first_name, c.last_name, c.annual_income, SUM(lh.loan_amount) AS total_loan_amount
FROM Loan_History lh
JOIN Customers c ON lh.customer_id = c.customer_id
GROUP BY c.customer_id
HAVING SUM(lh.loan_amount) > c.annual_income;

# 9. Problem: Find Customers whose Loan is not active 

SELECT c.customer_id, c.first_name, c.last_name, lh.loan_type, lh.loan_amount, lh.loan_status
FROM Loan_History lh
JOIN Customers c ON lh.customer_id = c.customer_id
WHERE lh.loan_status = 'closed';


#10. Problem: Identify Customers with High Annual Income and Low Credit Scores
SELECT c.customer_id, c.first_name, c.last_name, c.annual_income, cs.credit_score
FROM Customers c
JOIN Credit_Scores cs ON c.customer_id = cs.customer_id
WHERE c.annual_income > 1000000 AND cs.credit_score < 600;

use creditscoredb;
#11 Problem: Find Customers Who Had a Loan Application Rejected but Later Got a Loan
SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM Customers c
JOIN Loan_Applications la ON c.customer_id = la.customer_id
JOIN Loan_History lh ON c.customer_id = lh.customer_id
WHERE la.application_status = 'Rejected';


#12. Problem:Find the Month with the Highest Loan Approvals
SELECT MONTH(application_date) AS loan_month, 
       COUNT(application_id) AS approved_loans
FROM Loan_Applications
WHERE application_status = 'Approved'
GROUP BY loan_month
ORDER BY approved_loans DESC
LIMIT 1;

#13. Problem: Detect Customers Who Have Loans with High Interest Rates and Low Credit Scores

SELECT c.customer_id, c.first_name, c.last_name, cs.credit_score, lh.interest_rate
FROM Customers c
JOIN Credit_Scores cs ON c.customer_id = cs.customer_id
JOIN Loan_History lh ON c.customer_id = lh.customer_id
WHERE cs.credit_score < 600 AND lh.interest_rate > (SELECT AVG(interest_rate) FROM Loan_History);


#14. Problem: Find Customers Who Have Taken the Highest Number of Loans
SELECT c.customer_id, c.first_name, c.last_name, COUNT(lh.loan_id) AS total_loans
FROM Customers c
JOIN Loan_History lh ON c.customer_id = lh.customer_id
GROUP BY c.customer_id
ORDER BY total_loans DESC
LIMIT 5;

#15. Problem: Find the Average Loan Amount for Each Loan Type

SELECT loan_type, ROUND(AVG(loan_amount), 2) AS avg_loan_amount
FROM Loan_History
GROUP BY loan_type;


#16. Problem: Get the Top 3 Customers with the Highest Total Payments

SELECT c.customer_id, c.first_name, c.last_name, SUM(ph.payment_amount) AS total_paid
FROM Customers c
JOIN Loan_History lh ON c.customer_id = lh.customer_id
JOIN Payment_History ph ON lh.loan_id = ph.loan_id
GROUP BY c.customer_id
ORDER BY total_paid DESC
LIMIT 3;

#17. Problem: Find the Total Penalty Collected by the Bank

SELECT SUM(penalty_amount) AS total_penalty_collected
FROM Late_Payment_Penalty;


#18. Problem: Find the Most Common Loan Type
SELECT loan_type, COUNT(*) AS loan_count
FROM Loan_History
GROUP BY loan_type
ORDER BY loan_count DESC
LIMIT 1;















