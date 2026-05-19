/* =================================================================================
  CloudFlow Data Setup (BigQuery Edition)
  
  Fix applied: Added `CloudFlow.` prefix to all table references.
 =================================================================================
*/

-- 1. Create the Dataset (Schema)
CREATE SCHEMA IF NOT EXISTS CloudFlow;

-- 2. Clean up existing tables if they exist (Qualified names)
DROP TABLE IF EXISTS CloudFlow.invoices;
DROP TABLE IF EXISTS CloudFlow.activity_logs;
DROP TABLE IF EXISTS CloudFlow.users;

-- 3. Create Tables
-- Note: BigQuery supports PK/FK syntax for information, but does not enforce them.

CREATE TABLE CloudFlow.users (
    user_id INT64, -- BigQuery prefers INT64 over INT
    signup_date DATE,
    country STRING, -- BigQuery uses STRING, not VARCHAR
    plan_tier STRING,
    PRIMARY KEY (user_id) NOT ENFORCED
);

CREATE TABLE CloudFlow.activity_logs (
    log_id INT64,
    user_id INT64,
    event_name STRING,
    event_timestamp TIMESTAMP,
    PRIMARY KEY (log_id) NOT ENFORCED,
    FOREIGN KEY (user_id) REFERENCES CloudFlow.users(user_id) NOT ENFORCED
);

CREATE TABLE CloudFlow.invoices (
    invoice_id INT64,
    user_id INT64,
    amount NUMERIC, -- BigQuery prefers NUMERIC for money
    status STRING,
    due_date DATE,
    paid_date DATE,
    PRIMARY KEY (invoice_id) NOT ENFORCED,
    FOREIGN KEY (user_id) REFERENCES CloudFlow.users(user_id) NOT ENFORCED
);

/* =================================================================================
  Data Population
 =================================================================================
*/

-- A. Populate Users
INSERT INTO CloudFlow.users (user_id, signup_date, country, plan_tier) VALUES
(1, '2022-01-15', 'US', 'Enterprise'),
(2, '2022-03-10', 'FR', 'Pro'),
(3, '2022-05-20', 'JP', 'Free'),
(4, '2023-01-05', 'US', 'Enterprise'), 
(5, '2023-02-14', 'FR', 'Enterprise'),
(6, '2023-06-01', 'JP', 'Pro'),
(7, '2023-08-10', 'US', 'Pro'),
(8, '2023-09-12', 'FR', 'Free'),
(9, '2023-10-01', 'US', 'Free'),
(10, '2023-11-05', 'JP', 'Enterprise');

-- B. Populate Activity Logs
INSERT INTO CloudFlow.activity_logs (log_id, user_id, event_name, event_timestamp) VALUES
(101, 1, 'login', '2023-10-01 08:30:00'), (102, 2, 'login', '2023-10-01 09:00:00'),
(103, 1, 'upload_file', '2023-10-02 10:00:00'), (104, 3, 'login', '2023-10-02 11:00:00'),
(105, 5, 'share_link', '2023-10-03 14:00:00'), (106, 2, 'login', '2023-10-03 15:00:00'),
(107, 1, 'login', '2023-10-04 09:00:00'), (108, 4, 'login', '2023-10-04 09:30:00'),
(109, 6, 'download_file', '2023-10-05 10:00:00'), (110, 7, 'upload_file', '2023-10-05 11:00:00'),
(201, 2, 'upload_file', '2023-11-01 10:00:00'),
(202, 2, 'upload_file', '2023-11-01 11:00:00'),
(203, 2, 'upload_file', '2023-11-02 12:00:00'),
(204, 5, 'upload_file', '2023-11-03 09:00:00'),
(205, 5, 'upload_file', '2023-11-03 09:30:00'),
(206, 8, 'upload_file', '2023-11-04 10:00:00'),
(207, 10, 'upload_file', '2023-11-05 08:00:00'),
(208, 10, 'upload_file', '2023-11-05 09:00:00'),
(209, 10, 'upload_file', '2023-11-05 10:00:00'),
(210, 10, 'upload_file', '2023-11-05 11:00:00'),
(211, 6, 'upload_file', '2023-11-06 12:00:00'),
(301, 4, 'upload_file', '2023-10-10 09:00:00'),
(302, 4, 'share_link', '2023-10-12 10:00:00'),
(303, 4, 'login', '2023-10-15 11:00:00'),
(304, 4, 'download_file', '2023-10-20 14:00:00'), 
(305, 4, 'login', '2023-11-05 09:00:00'); 

-- C. Populate Invoices
INSERT INTO CloudFlow.invoices (invoice_id, user_id, amount, status, due_date, paid_date) VALUES
(1, 1, 5000.00, 'paid', '2024-01-01', '2024-01-02'),
(2, 4, 150000.00, 'paid', '2024-01-05', '2024-01-05'),
(3, 5, 200000.00, 'paid', '2024-01-10', '2024-01-12'),
(4, 10, 500000.00, 'paid', '2024-01-20', '2024-01-25'),
(5, 2, 2000.00, 'unpaid', '2024-02-01', NULL),
(6, 1, 250000.00, 'paid', '2024-02-15', '2024-02-15');