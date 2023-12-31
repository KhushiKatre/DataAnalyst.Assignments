show databases;
use classicmodels;
show tables;
-- ----------------------------------------------------------------------------------------------------------------------------
#assignment day3


# 1)
desc customers;
select customerNumber,customerName,state,creditLimit from customers  where (state is not null and creditLimit between 50000 and 100000) order by creditLimit desc;


# 2)
desc products;
select  distinct productLine from products where productLine like '%Cars';


-- ----------------------------------------------------------------------------------------------------------------------
#assignment day4


# 1)
SET SQL_SAFE_UPDATES = 0;
update orders set comments ='-' where comments is null;
select orderNumber,status,comments from orders where status = 'shipped';


# 2)
ALTER TABLE employees DROP COLUMN jobAbb;
alter table employees add jobAbb varchar(5);
select * from employees;
update  employees set jobAbb = 'P' where jobTitle='President';
update  employees set jobAbb = 'SM' where jobTitle like'Sale% Manager%';
update  employees set jobAbb = 'SR' where jobTitle='Sales Rep';
update  employees set jobAbb = 'VP' where jobTitle like '%VP%';
select employeeNumber,firstName,jobTitle,jobAbb from employees;


-- ----------------------------------------------------------------------------------------------------------------------------------
# assignment day5


# 1)
describe payments;
select year(paymentDate) as year ,min(amount) as min_amount from payments group by year(paymentDate);


# 2) 
ALTER TABLE payments DROP COLUMN total_orders;
ALTER TABLE payments add total_orders int(5);

 select* from payments;
SELECT 
    YEAR(paymentDate) AS Year,
    CASE
        WHEN MONTH(paymentDate) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN MONTH(paymentDate) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN MONTH(paymentDate) BETWEEN 7 AND 9 THEN 'Q3'
        ELSE 'Q4'
    END AS Quarter,
    COUNT(DISTINCT customerNumber) AS Unique_Customers,
    count(amount) AS Total_Orders
FROM  payments GROUP BY Year,Quarter ORDER BY Year,Quarter;


#3)
SELECT 
    EXTRACT(MONTH FROM paymentDate) AS month, 
    FLOOR(SUM(amount) / 1000) + 'K' AS formatted_amount
FROM 
    payments
WHERE 
    amount BETWEEN 50000 AND 100000
GROUP BY 
    month
ORDER BY 
    SUM(amount) DESC;



-- -------------------------------------------------------------------------------------------------------------------------------------    
#assignment day 6


#1)
drop table journey;
create table journey
(
bus_id integer(5) not null,
bus_name varchar(25) not null,
source_station varchar(25) not null,
destination varchar(25) not null,
email varchar(30) primary key
);
describe journey;


#2)
drop table vendor;
create table vendor
(
vendor_id integer(5) not null primary key,
name varchar(25) not null,
email varchar(30) not null,
country varchar(25)
);
SELECT 
    country,
    CASE
        WHEN country is null THEN 'N/A' else country
    END 
    from vendor;
    


#3)
drop table movies;
create table movies
(
movie_id integer(5) not null primary key,
name varchar(25) not null,
release_year date ,
cast varchar(25) not null,
gender varchar(2) ,
no_of_shows numeric(5)
);
SELECT 
    release_year,
    CASE
        WHEN release_year is null THEN '-' else release_year
    END 
    from movies;
    
    

# 4)
create table product
(
product_id integer(5) not null primary key,
product_name varchar(25) not null unique,
description varchar(100),
supplier_id integer(5) ,
foreign key (supplier_id) references supplier(supplier_id) 
);
create table supplier
(
supplier_id integer(5) not null primary key,
supplier_name varchar(25) ,
dlocation varchar(20)
);
create table stock
(
stock_id integer(5) not null primary key,
balance_stock varchar(25) ,
product_id integer(5),
foreign key (product_id) references product(product_id) 
);


-- ----------------------------------------------------------------------------------------------------------------------------
# day7


# 1)
SELECT e.employeeNumber, CONCAT(e.firstName, ' ', e.lastName) AS 'Sales Person', COUNT(DISTINCT c.customerNumber) AS 'Unique Customers' 
FROM Employees e JOIN Customers c ON e.lastName = c.contactLastName GROUP BY e.employeeNumber, 'Sales Person'
ORDER BY 'Unique Customers' DESC;


# 2)
SELECT Customers.customerNumber, Customers.customerName, Products.productCode,products.productName,
 SUM(Orderdetails.quantityOrdered)  AS quantityOrdered, products.quantityInStock as totalInventory,
 (products.quantityInStock -quantityOrdered) as qty_left
FROM Customers JOIN Orders ON Customers.customerNumber = Orders.customerNumber 
JOIN Orderdetails ON Orders.orderNumber = Orderdetails.orderNumber JOIN
Products ON Orderdetails.productCode = Products.productCode 
GROUP BY Customers.customerNumber, Customers.customerName, Products.productCode 
ORDER BY Customers.customerNumber;


# 3)
create table laptops
(name varchar(25));
create table colors
(color varchar(25));

insert into laptops values('hp'),('asus'),('acer'),('dell'),('lenovo');
insert into colors values('pink'),('blue'),('black'),('silver'),('white');

select * from laptops cross join  colors;


# 4) 
create table project(
employeeID numeric,
name varchar(25),
gender varchar(1),
managerID numeric
);
INSERT INTO Project VALUES(1, 'Pranaya', 'M', 3);
INSERT INTO Project VALUES(2, 'Priyanka', 'F', 1);
INSERT INTO Project VALUES(3, 'Preety', 'F', NULL);
INSERT INTO Project VALUES(4, 'Anurag', 'M', 1);
INSERT INTO Project VALUES(5, 'Sambit', 'M', 1);
INSERT INTO Project VALUES(6, 'Rajesh', 'M', 3);
INSERT INTO Project VALUES(7, 'Hina', 'F', 3);
 

create table manager(
employeeName varchar(25),
manager_name varchar(25)
);
insert into manager values('Pranay','managerA'),('Priyanka','managerB'),('Preety','managerC'),('Anurag','managerD'),('Sambit','managerE'),('Rajesh','managerF'),('Hina','managerG');

select manager.manager_name , project.name from manager join project on manager.employeeName=project.name;



-- --------------------------------------------------------------------------------------------------------------------------
# day8

create table facility(
facility_id integer,
name varchar(25),
state varchar(25),
country varchar(25)
);

alter table facility add primary key (facility_id) ;
alter table facility  modify column facility_id int auto_increment;
alter table facility add city varchar(25) not null after name;

describe facility;

-- ---------------------------------------------------------------------------------------------------------------------------------------
#day9

create table university(
id numeric,
name varchar(50)
);


INSERT INTO University
VALUES (1, "       Pune          University     "), 
               (2, "  Mumbai          University     "),
              (3, "     Delhi   University     "),
              (4, "Madras University"),
              (5, "Nagpur University");

select id,replace(name,' ','') as name from university;


-- -------------------------------------------------------------------------------------------------------------------------------
# day10
drop view products_status;
create view products_status as 
select  year(paymentDate) as year,concat(sum(amount),'(',round((amount/sum(amount))*100,2),'%',')') as value from payments group by year;

select*from products_status;


-- ------------------------------------------------------------------------------------------------------------------------------
# day11


# 1)
call GetCustomerLevel(112);


#2)
call Get_country_payments (19/10/2003,'France'); #where year(p.paymentDate)= paymentDate and c.country= country


-- ------------------------------------------------------------------------------------------------------------------------------------
# day12


# 1)
SELECT
 YEAR(OrderDate) AS Year,
 MONTHNAME(OrderDate) AS Month,
 COUNT(*) AS TotalOrders
FROM
 Orders
GROUP BY
 Year,
 Month
ORDER BY
 Year,
 MONTH(OrderDate);

SELECT
 O1.Year,
 O1.Month,
 O1.TotalOrders,
 (O1.TotalOrders - IFNULL(O2.TotalOrders, 0)) / IFNULL(O2.TotalOrders, 1) * 100 AS YoYpercentChange
FROM
 (SELECT
     YEAR(OrderDate) AS Year,
     MONTHNAME(OrderDate) AS Month,
     COUNT(*) AS TotalOrders
   FROM
     Orders
   GROUP BY
     Year,
     Month) AS O1
LEFT JOIN
 (SELECT
     YEAR(OrderDate) AS Year,
     MONTHNAME(OrderDate) AS Month,
     COUNT(*) AS TotalOrders
   FROM
     Orders
   GROUP BY
     Year,
     Month) AS O2
ON
 O1.Year = O2.Year + 1 AND O1.Month = O2.Month
ORDER BY
 O1.Year,
 MONTH(STR_TO_DATE(O1.Month, '%M'));



# 2)
create table emp_udf(
emp_id int AUTO_INCREMENT primary key,
name varchar(25),
DOB date
);
INSERT INTO emp_udf(name, DOB)
VALUES ("Piyush", "1990-03-30"), ("Aman", "1992-08-15"), ("Meena", "1998-07-28"), ("Ketan", "2000-11-21"), ("Sanjay", "1995-05-21");

-- -------------------------------------------------------------------------------------------------------------------------------
# day13


# 1)
SELECT 
    c.customerNumber,
    c.customerName
FROM 
    customers c
WHERE 
    c.customerNumber NOT IN (SELECT o.customerNumber FROM orders o);


# 2)
SELECT COALESCE(c.customerNumber, o.customerNumber) AS customerNumber, 
       COALESCE(c.customerName, '') AS customerName, 
       COUNT(o.orderNumber) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.customerNumber = o.customerNumber
GROUP BY COALESCE(c.customerNumber, o.customerNumber), COALESCE(c.customerName, '')
ORDER BY customerNumber;


# 3)
SELECT orderNumber, quantityOrdered AS secondHighestQuantityOrdered
FROM (
    SELECT 
        orderNumber, 
        quantityOrdered, 
        ROW_NUMBER() OVER (PARTITION BY orderNumber ORDER BY quantityOrdered DESC) as row_num
    FROM Orderdetails
) temp_table
WHERE row_num = 2;

# 4)

SELECT 
    MAX(Total) AS MAX_Total, 
    MIN(Total) AS MIN_Total 
FROM 
    (
        SELECT 
            COUNT(*) AS Total 
        FROM 
            Orderdetails 
        GROUP BY 
            OrderNumber 
    ) AS T;


# 5)
SELECT productLine, COUNT(*) AS productCount FROM products WHERE buyPrice > (SELECT AVG(buyPrice) FROM products) GROUP BY productLine ORDER BY productCount DESC;


-- ----------------------------------------------------------------------------------------------------------------------------------
# day14
CREATE TABLE Emp_EH (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    EmailAddress VARCHAR(50)
);

 call AddEmployee(11,'khushi','khushi@gmail.com');

select * from Emp_EH;


-- -------------------------------------------------------------------------------------------------------------------------------------
# day15
CREATE TABLE Emp_BIT(
    Name VARCHAR(50),
    Occupation VARCHAR(50),
    Working_date DATE,
    Working_hours INT
);

INSERT INTO Emp_BIT VALUES
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', 12),  
('Antonio', 'Business', '2020-10-04', 11);  

SHOW TRIGGERS FROM classicmodels;