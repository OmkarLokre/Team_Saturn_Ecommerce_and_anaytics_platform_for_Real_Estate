CREATE DATABASE case_study;
USE case_study;

-- Exp 3 --
CREATE TABLE property(
 reg_ID INT PRIMARY KEY,
 location VARCHAR (225),
 size INT ,
 price INT,
 Property_Listing_Date_Time DATETIME
 );
Drop database case_study;
 -- Exp 3 --
CREATE TABLE  user(
user_ID INT PRIMARY KEY,
 name VARCHAR ( 225),
 contact_no INT ,
 email_ID VARCHAR (225),
 property_ID  INT,
 FOREIGN KEY ( property_ID) REFERENCES property(reg_ID)
 ON DELETE CASCADE
 );
 -- Exp 3 --
CREATE TABLE NOC (
 NOC_ID INT PRIMARY KEY,
 property_ID  INT,
 status VARCHAR (10),
 NOC_DATE datetime,
 FOREIGN KEY ( property_ID) REFERENCES property(reg_ID)
 ON DELETE CASCADE
 );
 -- Exp 3 --
 CREATE TABLE type(
 type_ID INT PRIMARY KEY,
 property_ID  INT,
 porperty_type VARCHAR (50),
 FOREIGN KEY ( property_ID) REFERENCES property(reg_ID)
 ON DELETE CASCADE
 );
 -- Exp 3 --
ALTER TABLE property MODIFY price BIGINT;
INSERT INTO property (reg_ID,location,size,price) VALUES
(1001, "Thane", 1200,4300000),
(1002, "Andheri", 750 ,30000000),
(1003, "Dadar" , 800 ,20000000),
(1004, "Bandra" , 1000 ,9000000),
(1005, "Colaba", 900 ,12000000);

-- Exp 3 --
SELECT * FROM property;
ALTER TABLE user MODIFY contact_no VARCHAR(10);

ALTER TABLE property MODIFY price BIGINT;
INSERT INTO property (reg_ID,location,size,price) VALUES
(1001, "Thane", 1200,4300000),
(1002, "Andheri", 750 ,30000000),
(1003, "Dadar" , 800 ,20000000),
(1004, "Bandra" , 1000 ,9000000),
(1005, "Colaba", 900 ,12000000);

INSERT INTO user(user_ID,name,contact_no,email_ID,property_ID) VALUES
(19, "Anish", "9555555555", "abc@gmail.com",NULL),
(51, "Malavika", "9444444444", "def@gmail.com",1002),
(65, "Omkar", "9666666666", "ghi@gmail.com",NULL),
(54, "Sarthak", "9888888888", "jkl@gmail.com",1001),
(52, "Soham", "9222222222", "mno@gmail.com",1003);
 
SELECT * FROM property;

ALTER TABLE user MODIFY contact_no VARCHAR(10);
INSERT INTO user(user_ID,name,contact_no,email_ID,property_ID) VALUES
(19, "Anish", "9555555555", "abc@gmail.com",NULL),
(51, "Malavika", "9444444444", "def@gmail.com",1002),
(65, "Omkar", "9666666666", "ghi@gmail.com",NULL),
(54, "Sarthak", "9888888888", "jkl@gmail.com",1001),
(52, "Soham", "9222222222", "mno@gmail.com",1003);

SELECT * FROM user;

INSERT INTO NOC(NOC_ID,property_ID,status) VALUES
(0001,1001,"Yes"),
(000,1002,"Yes"),
(0003,1003,"Yes"),
(0004,1004,"No"),
(0005,1005,"No");

SELECT * FROM NOC;

ALTER TABLE type RENAME COLUMN porperty_type TO property_type;

INSERT INTO type(type_ID,property_ID,property_type) VALUES
(1,1001,"residential"),
(2,1002,"residential"),
(3,1003,"residential"),
(4,1004,"commercial"),
(5,1005,"residential");

-- EXP 5 

show privileges;

-- Create role 'user_table_user'
create role 'user_table_user';

-- Create user 'Soham' and assign the default role 'user_table_user'
create user 'Soham' identified by "Soham@123" default role 'user_table_user';
create user 'iufbh' identified by "ejh@123" default role 'user_table_user';

-- Grant all privileges on a specific table (let's assume it's named 'user_table') to the role 'user_table_user'
grant all privileges on user.* to user_table_user;

-- Revoke the DELETE privilege on the 'user_table' table from the user 'Soham'
REVOKE DELETE ON user_table FROM Soham;

-- Create role 'property_table_user'
CREATE ROLE property_table_user;

-- Create user 'Sarthak' and assign the default role 'property_table_user'
CREATE USER 'Sarthak' IDENTIFIED BY "Sarthak@123" DEFAULT ROLE 'property_table_user';

-- Grant all privileges on a specific table (let's assume it's named 'property') to the role 'property_table_user'
GRANT DELETE, UPDATE, INSERT, SELECT, ALTER ON property.* TO property_table_user;

-- Create role 'type_table_user'
CREATE ROLE 'type_table_user';

-- Create user 'Omkar' and assign the default role 'type_table_user'
CREATE USER 'Anish' IDENTIFIED BY "Anish@123" DEFAULT ROLE 'type_table_user';

-- Granting previleges
GRANT DELETE, UPDATE, INSERT, SELECT, ALTER ON type.* TO type_table_user;
REVOKE DELETE ON type.* FROM type_table_user;

-- COMMIT AND ROLLBACK --
SET AUTOCOMMIT= OFF;
COMMIT;
SET SQL_SAFE_UPDATES=0;
DELETE FROM user;
SELECT * FROM user;
ROLLBACK;

-- ROLLBACK TO A GIVEN SAVEPOINT--
INSERT INTO user VALUE
(53, "Prathamesh", "9666666666", "pqr@gmail.com",NULL);
SAVEPOINT Prathamesh;
DELETE FROM user WHERE user_id=53;
ROLLBACK  TO Prathamesh;  -- ROLLBACK to a particular savepoint--

ROLLBACK;  -- ROLLBACK TO ORIGINAL COMMIT--

-- ------------------------------------------------ 

-- EXP 6:

-- Insert data into property table
INSERT INTO property (reg_ID, location, size, price, Property_Listing_Date_Time) VALUES
(1001, "Thane", 1200, 4300000, "2009-07-15 09:25:13"),
(1002, "Andheri", 750, 30000000, "2011-03-28 14:55:45"),
(1003, "Dadar", 800, 20000000, "2014-09-09 17:30:00"),
(1004, "Bandra", 1000, 9000000, "2016-11-05 08:45:23"),
(1005, "Colaba", 900, 12000000, "2016-11-05 08:45:00");

-- Insert data into NOC table
INSERT IGNORE INTO NOC (NOC_ID, property_ID, status, NOC_DATE) VALUES
(1, 1001, "Yes", "2008-11-11"),
(2, 1002, "Yes", "2012-04-23"),
(3, 1003, "Yes", "2016-12-02"),
(4, 1004, "No", NULL),
(5, 1005, "No", NULL);

-- Selecting date with basic method
SELECT NOC_DATE FROM NOC;

-- Selecting various components like DAY, MONTH, and YEAR from the DATE
SELECT property_ID, DAY(NOC_DATE) AS ASSIGN_DAY FROM NOC;
SELECT property_ID, MONTH(NOC_DATE) AS ASSIGN_MONTH FROM NOC;
SELECT property_ID, YEAR(NOC_DATE) AS ASSIGN_YEAR FROM NOC;

-- Displaying property table to verify dataA
SELECT * FROM property;

Select Property_Listing_Date_Time from property;

-- Selecting various components like Hours, minutes, and Seconds from the DATE
select reg_ID ,HOUR(Property_Listing_Date_Time) as HOURS from property;
select reg_ID ,MONTH(Property_Listing_Date_Time) as MONTHS from property;
select reg_ID ,SECOND(Property_Listing_Date_Time) as SECONDS from property;

-- Experiment with arithmetic operations and set commands

-- First set MODE TO SAFE TO 0:
SET SQL_SAFE_UPDATES = 0;



-- Add 3 to the size of all properties

-- ARITHMETIC AND SET PROPERTIES
UPDATE property SET size = size + 3;

-- Multiply the price of all properties by 1.05 (increase by 5%)
UPDATE property SET price = price * 1.05;

-- Subtract 10 days from the Property_Listing_Date_Time of all properties
UPDATE property SET Property_Listing_Date_Time = DATE_SUB(Property_Listing_Date_Time, INTERVAL 10 DAY);

-- Set the status of NOC for property with reg_ID = 1001 to 'Approved'
UPDATE NOC SET status = 'Approved' WHERE property_ID = 1001;

-- Set the contact_no of user with user_ID = 19 to '9876543210'
UPDATE user SET contact_no = '9876543210' WHERE user_ID = 19;

-- EXP 7

SELECT * FROM property;
SELECT location FROM property GROUP BY location;
SELECT location, COUNT(location) FROM property GROUP BY location; -- LOCATION BASED COUNT
SELECT location, AVG(price) FROM property GROUP BY location; -- LOCATION BASED AVG PRICE
SELECT location, AVG(size) FROM property GROUP BY location; -- LOCATION BASED AVG SIZE
SELECT location, MIN(price) FROM property GROUP BY location; -- LOCATION BASED MIN PRICE
SELECT location, MIN(size) FROM property GROUP BY location; -- LOCATION BASED MIN SIZE
SELECT location, MAX(price) FROM property GROUP BY location; -- LOCATION BASED MAX PRICE
SELECT location, MAX(size) FROM property GROUP BY location; -- LOCATION BASED MAX SIZE
SELECT location, SUM(price) FROM property GROUP BY location; -- LOCATION BASED PRICE SUM
SELECT location, SUM(size) FROM property GROUP BY location; -- LOCATION BASED SIZE SUM
SELECT location, COUNT(location) FROM property GROUP BY location HAVING COUNT(location)>1;

-- EXP 8

SELECT * 
FROM property
INNER JOIN user ON property.reg_ID = user.property_ID;

SELECT * 
FROM property
LEFT JOIN NOC ON property.reg_ID < NOC.property_ID;

-- Self Join

SELECT p1.reg_ID, p1.location, p2.location AS neighbor_location
FROM property p1
INNER JOIN property p2 ON p1.size = p2.size AND p1.reg_ID != p2.reg_ID;
 
 -- Self join
CREATE TABLE user_property (
    user_ID INT PRIMARY KEY,
    name VARCHAR(225),
    contact_no VARCHAR(10),
    property_ID INT,
    size INT,
    FOREIGN KEY (property_ID) REFERENCES property(reg_ID) ON DELETE CASCADE
);

-- EXP 9

SELECT * FROM user;
CREATE VIEW user_view AS SELECT name,email_ID,property_ID FROM user;
SELECT * FROM user_view;
ALTER VIEW user_view AS SELECT name,contact_no,email_ID FROM user;
SELECT * FROM user_view;

SELECT * FROM type;
CREATE VIEW type_view AS SELECT property_ID,property_type FROM type;
SELECT * FROM type_view;    

drop database case_study;

--  EXP 10:


-- EXP 10 --

-- TRIGGER ON PROPERTY TABLE--
DELIMITER //
CREATE TRIGGER check_location_trigger
BEFORE INSERT ON property
FOR EACH ROW
BEGIN
IF NEW.location="America" THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT= 'Please add a property within our country';
    END IF;
END//

DELIMITER ;

INSERT INTO property (reg_ID,location,size,price,Property_Listing_Date_Time) VALUES
(1006,"America",1200,4300000,"2009-07-15 09:25:13");

-- TRIGGER ON USER TABLE--
DELIMITER //
CREATE TRIGGER user_bi
BEFORE INSERT ON user
FOR EACH ROW
BEGIN
IF INSTR(NEW.email_ID,'@')=0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT= 'Email ID must contain "@" symbol';
    END IF;
END//

DELIMITER ;

INSERT IGNORE INTO user (user_ID,name,contact_no,email_ID,property_ID) VALUES
(19,"Anish","9555555555","abcgmail.com",NULL);