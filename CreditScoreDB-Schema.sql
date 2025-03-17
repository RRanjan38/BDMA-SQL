CREATE DATABASE CreditScoreDB;
USE CreditScoreDB;

-- 1️⃣ Customers Table (Independent)
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    contact_number VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    employment_status VARCHAR(50) NOT NULL,
    annual_income DECIMAL(10,2) NOT NULL
);

-- 2️⃣ Credit Scores (Depends on Customers)
CREATE TABLE Credit_Scores (
    score_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    credit_score INT CHECK (credit_score BETWEEN 300 AND 850) NOT NULL,
    evaluation_date DATE NOT NULL,
    risk_level VARCHAR(20) CHECK (risk_level IN ('Low', 'Medium', 'High')) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 3️⃣ Credit Inquiries (Depends on Customers)
CREATE TABLE Credit_Inquiries (
    inquiry_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    inquiry_type VARCHAR(10) CHECK (inquiry_type IN ('Hard', 'Soft')) NOT NULL,
    requesting_institution VARCHAR(100) NOT NULL,
    inquiry_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 4️⃣ Loan Applications (Depends on Customers)
CREATE TABLE Loan_Applications (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    requested_amount DECIMAL(15,2) NOT NULL,
    application_date DATE NOT NULL,
    application_status VARCHAR(20) CHECK (application_status IN ('Pending', 'Approved', 'Rejected')) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 5️⃣ Loan History (Depends on Customers)
CREATE TABLE Loan_History (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    loan_type VARCHAR(50) NOT NULL,
    loan_amount DECIMAL(15,2) NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL,
    loan_term INT CHECK (loan_term > 0) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    loan_status VARCHAR(20) CHECK (loan_status IN ('Active', 'Closed', 'Defaulted')) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 6️⃣ Collateral (Depends on Loan_History)
CREATE TABLE Collateral (
    collateral_id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT NOT NULL,
    collateral_type VARCHAR(50) NOT NULL,
    collateral_value DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (loan_id) REFERENCES Loan_History(loan_id)
);

-- 7️⃣ Payment History (Depends on Loan_History)
CREATE TABLE Payment_History (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT NOT NULL,
    payment_amount DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_status VARCHAR(20) CHECK (payment_status IN ('On Time', 'Late', 'Missed')) NOT NULL,
    FOREIGN KEY (loan_id) REFERENCES Loan_History(loan_id)
);

-- 8️⃣ Late Payment Penalty (Depends on Payment_History)
CREATE TABLE Late_Payment_Penalty (
    penalty_id INT PRIMARY KEY AUTO_INCREMENT,
    payment_id INT NOT NULL,
    penalty_amount DECIMAL(10,2) NOT NULL,
    penalty_date DATE NOT NULL,
    FOREIGN KEY (payment_id) REFERENCES Payment_History(payment_id)
);

-- Set different AUTO_INCREMENT starting values to avoid conflicts
ALTER TABLE Customers AUTO_INCREMENT = 1000;
ALTER TABLE Credit_Scores AUTO_INCREMENT = 2000;
ALTER TABLE Credit_Inquiries AUTO_INCREMENT = 5000;
ALTER TABLE Loan_Applications AUTO_INCREMENT = 7000;
ALTER TABLE Loan_History AUTO_INCREMENT = 3000;
ALTER TABLE Collateral AUTO_INCREMENT = 8000;
ALTER TABLE Payment_History AUTO_INCREMENT = 4000;
ALTER TABLE Late_Payment_Penalty AUTO_INCREMENT = 6000;
