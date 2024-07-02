use flat_management;
select * from users;
create database flat_management;
CREATE TABLE users_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone_no VARCHAR(15) NOT NULL,
    aadhaar_number CHAR(12) NOT NULL,
    photo BLOB NOT NULL,
    family_members INT NOT NULL,
    advance_amount DECIMAL(10, 2) NOT NULL,
    advance_status ENUM('yes', 'no') NOT NULL,
    rent_amount DECIMAL(10, 2) NOT NULL,
    rent_amount_status ENUM('paid', 'not paid') NOT NULL,
    eb_bill DECIMAL(10, 2) NOT NULL,
    eb_bill_status ENUM('yes', 'no') NOT NULL,
    date_of_joining DATE NOT NULL,
    date_of_ending DATE,
    delete_user BOOLEAN DEFAULT FALSE,
    users_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
);
alter table users add column role ENUM('admin', 'user') ;
CREATE TABLE visitor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    visitor_name VARCHAR(255),
    in_time TIME,
    out_time TIME,
    in_date DATE,
    out_date DATE,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
CREATE TABLE complain (
    id INT AUTO_INCREMENT PRIMARY KEY,
    complain_type VARCHAR(255),
    comments TEXT,
    complain_date DATE,
    complain_status ENUM('finished', 'not_finished'),
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE Messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    message TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Employee (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL
);

CREATE TABLE Task (
    id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    status VARCHAR(50) NOT NULL,
    employee_id INT,
    FOREIGN KEY (employee_id) REFERENCES Employee(id)
);
CREATE TABLE flat_management.visitors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    visitor_name VARCHAR(255),
    in_time VARCHAR(25),
    out_time VARCHAR(25),
    in_date VARCHAR(25),
    out_date VARCHAR(25),
    flat_floor INT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    payment_date DATE NOT NULL,
    FOREIGN KEY (id) REFERENCES flat_management.users(id) ON DELETE CASCADE
);
DELIMITER //

DELIMITER //

CREATE PROCEDURE user_payments (IN p_user_id INT, OUT p_has_paid BOOLEAN)
BEGIN
    SET @start_date = DATE_FORMAT(NOW(), '%Y-%m-01');
    SET @end_date = LAST_DAY(NOW());
    
    SELECT COUNT(*) > 1 INTO p_has_paid
    FROM user_payments
    WHERE user_id = p_user_id AND payment_date BETWEEN @start_date AND @end_date;
END //

DELIMITER ;

SET @p_user_id = 1;  -- Replace with an actual user ID
SET @p_has_paid = FALSE;
CALL user_payments(@p_user_id, @p_has_paid);