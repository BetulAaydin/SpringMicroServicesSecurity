DROP TABLE IF EXISTS authorities;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS account_transactions;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS cards;
DROP TABLE IF EXISTS contact_messages;
DROP TABLE IF EXISTS notice_details;
DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS customer;

CREATE TABLE customer (
                          customer_id SERIAL PRIMARY KEY,
                          name VARCHAR(100) NOT NULL,
                          email VARCHAR(100) NOT NULL,
                          mobile_number VARCHAR(20) NOT NULL,
                          pwd VARCHAR(500) NOT NULL,
                          role VARCHAR(100) NOT NULL,
                          create_dt DATE DEFAULT NULL
);

INSERT INTO customer (name, email, mobile_number, pwd, role, create_dt)
VALUES ('Happy', 'happy@example.com', '5334122365', '{bcrypt}$2a$12$88.f6upbBvy0okEa7OfHFuorV29qeK.sVbB9VQ6J6dWM1bW6Qef8m', 'admin', CURRENT_DATE);

CREATE TABLE accounts (
                          customer_id INT NOT NULL,
                          account_number INT PRIMARY KEY,
                          account_type VARCHAR(100) NOT NULL,
                          branch_address VARCHAR(200) NOT NULL,
                          create_dt DATE DEFAULT NULL,
                          FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);

INSERT INTO accounts (customer_id, account_number, account_type, branch_address, create_dt)
VALUES (1, 1865764534, 'Savings', '123 Main Street, New York', CURRENT_DATE);

CREATE TABLE account_transactions (
                                      transaction_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                      account_number INT NOT NULL,
                                      customer_id INT NOT NULL,
                                      transaction_dt DATE NOT NULL,
                                      transaction_summary VARCHAR(200) NOT NULL,
                                      transaction_type VARCHAR(100) NOT NULL,
                                      transaction_amt INT NOT NULL,
                                      closing_balance INT NOT NULL,
                                      create_dt DATE DEFAULT NULL,
                                      FOREIGN KEY (account_number) REFERENCES accounts(account_number) ON DELETE CASCADE,
                                      FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);

INSERT INTO account_transactions (account_number, customer_id, transaction_dt, transaction_summary, transaction_type, transaction_amt, closing_balance, create_dt)
VALUES (1865764534, 1, CURRENT_DATE - INTERVAL '7 days', 'Coffee Shop', 'Withdrawal', 30, 34500, CURRENT_DATE - INTERVAL '7 days');

CREATE TABLE loans (
                       loan_number SERIAL PRIMARY KEY,
                       customer_id INT NOT NULL,
                       start_dt DATE NOT NULL,
                       loan_type VARCHAR(100) NOT NULL,
                       total_loan INT NOT NULL,
                       amount_paid INT NOT NULL,
                       outstanding_amount INT NOT NULL,
                       create_dt DATE DEFAULT NULL,
                       FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);

INSERT INTO loans (customer_id, start_dt, loan_type, total_loan, amount_paid, outstanding_amount, create_dt)
VALUES (1, '2020-10-13', 'Home', 200000, 50000, 150000, '2020-10-13');

CREATE TABLE cards (
                       card_id SERIAL PRIMARY KEY,
                       card_number VARCHAR(100) NOT NULL,
                       customer_id INT NOT NULL,
                       card_type VARCHAR(100) NOT NULL,
                       total_limit INT NOT NULL,
                       amount_used INT NOT NULL,
                       available_amount INT NOT NULL,
                       create_dt DATE DEFAULT NULL,
                       FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);

INSERT INTO cards (card_number, customer_id, card_type, total_limit, amount_used, available_amount, create_dt)
VALUES ('4565XXXX4656', 1, 'Credit', 10000, 500, 9500, CURRENT_DATE);

CREATE TABLE notice_details (
                                notice_id SERIAL PRIMARY KEY,
                                notice_summary VARCHAR(200) NOT NULL,
                                notice_details VARCHAR(500) NOT NULL,
                                notic_beg_dt DATE NOT NULL,
                                notic_end_dt DATE DEFAULT NULL,
                                create_dt DATE DEFAULT NULL,
                                update_dt DATE DEFAULT NULL
);

INSERT INTO notice_details (notice_summary, notice_details, notic_beg_dt, notic_end_dt, create_dt, update_dt)
VALUES ('Home Loan Interest rates reduced', 'Home loan interest rates are reduced as per the government guidelines.', CURRENT_DATE - INTERVAL '30 days', CURRENT_DATE + INTERVAL '30 days', CURRENT_DATE, NULL);

CREATE TABLE contact_messages (
                                  contact_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                  contact_name VARCHAR(50) NOT NULL,
                                  contact_email VARCHAR(100) NOT NULL,
                                  subject VARCHAR(500) NOT NULL,
                                  message VARCHAR(2000) NOT NULL,
                                  create_dt DATE DEFAULT NULL
);

CREATE TABLE authorities (
                             id SERIAL PRIMARY KEY,
                             customer_id INT NOT NULL,
                             name VARCHAR(50) NOT NULL,
                             FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

INSERT INTO authorities (customer_id, name)
VALUES (1, 'ROLE_USER'), (1, 'ROLE_ADMIN');
