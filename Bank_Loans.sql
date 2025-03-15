-- All rows
SELECT * FROM Bank_loan

-- Month to Date Loan Applications
SELECT COUNT(id) AS Total_loan_applications_current_month FROM Bank_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Previous Month to Date Loan Applications
SELECT COUNT(id) AS Total_loan_applications_previous_month FROM Bank_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- Total Amount Funded by Bank Loans
SELECT SUM(loan_amount) AS Total_amount_funded FROM Bank_loan

-- Total Amount Received by Banks from Loans
SELECT SUM(total_payment) AS Total_amount_received FROM Bank_loan

-- Average Interest Rate on Bank Loans
SELECT ROUND(AVG(int_rate) * 100, 2) AS Average_interest_rate FROM Bank_loan

-- Good loan applications
SELECT COUNT(id) AS Good_loan_applications FROM Bank_loan WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Good loan percentages
SELECT ((COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100) / COUNT(id)) AS Loan_percentage_paid FROM Bank_loan

-- Good loan funded amount
SELECT SUM(total_payment) AS Good_loan_funded_amount FROM Bank_loan WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Bad loan percentage
SELECT (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / COUNT(id) AS Bad_Loan_Percentage FROM Bank_loan

-- Bad loan applications made
SELECT COUNT(id) AS Bad_Loan_Applications FROM Bank_loan WHERE loan_status = 'Charged Off'

-- Bad loan funded amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM Bank_loan WHERE loan_status = 'Charged Off'
 
 -- Bad loan amount received
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM Bank_loan WHERE loan_status = 'Charged Off'

-- Loan Status
SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        Bank_loan
    GROUP BY
        loan_status

SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM Bank_loan
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status

--PART B. BANK LOAN REPORT

-- Month wise loan amount
SELECT 
	MONTH(issue_date) AS Month_Number, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

-- Loan details by the state
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan
GROUP BY address_state
ORDER BY address_state

-- Loan application details based on terms
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan
GROUP BY term
ORDER BY term

-- Loan taken by working professionals and their working exp. 
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan
GROUP BY emp_length
ORDER BY emp_length

-- Reason for taking the loan
SELECT 
	purpose AS Purpose, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan
GROUP BY purpose
ORDER BY purpose

-- Home Ownership (Whether loan applications own a home)
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan
GROUP BY home_ownership
ORDER BY home_ownership