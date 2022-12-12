/*
    Title: outlandadventuresSQL.sql
    Team: Silver 
    Author(s): Shayla Bradley, Patrick Ellis, Yawa Hallo, Abigail Klein
    Professor: Professor Sampson
    Date: December 4, 2022
    Description: Outland Adventures database initialization script.
    UPDATED: 12/6/2022
*/

-- drop database user if exists 
DROP USER 'Blythe_Timmerson'@'localhost';
DROP USER 'Jim_Ford'@'localhost';
DROP USER 'John_MacNell'@'localhost';
DROP USER 'D.B._Marland'@'localhost';
DROP USER 'Anita_Gallegos'@'localhost';
DROP USER 'Dimitrios_Stravopolous'@'localhost';
DROP USER 'Mei_Wong'@'localhost';

-- create users for outlandadventures database 
CREATE USER 'Blythe_Timmerson'@'localhost' IDENTIFIED BY 'OutdoorBo$$1';
CREATE USER 'Jim_Ford'@'localhost' IDENTIFIED BY 'outdoor$y007';
CREATE USER 'John_MacNell'@'localhost' IDENTIFIED BY 'TourGuideSupreme68';
CREATE USER 'D.B._Marland'@'localhost' IDENTIFIED BY 'IcanSHOWyouTHEworld';
CREATE USER 'Anita_Gallegos'@'localhost' IDENTIFIED BY 'MarketingMaster1995';
CREATE USER 'Dimitrios_Stravopolous'@'localhost' IDENTIFIED BY 'iLOVEto$HOP';
CREATE USER 'Mei_Wong'@'localhost' IDENTIFIED BY 'designerbyday';

-- grant all privileges to the CEOs on localhost 
GRANT ALL ON outlandadventures.* TO 'Blythe_Timmerson'@'localhost';
GRANT ALL ON outlandadventures.* TO 'Jim_Ford'@'localhost';

-- grant specifc privileges to specific users
GRANT SELECT ON outlandadventures.* TO 'John_MacNell'@'localhost';
GRANT SELECT ON outlandadventures.* TO 'D.B._Marland'@'localhost';
GRANT SELECT ON outlandadventures.* TO 'Dimitrios_Stravopolous'@'localhost';
GRANT SELECT ON outlandadventures.* TO 'Anita_Gallegos'@'localhost';
GRANT SELECT ON outlandadventures.* TO 'Mei_Wong'@'localhost';
GRANT ALL ON outlandadventures.trip_locations TO 'John_MacNell'@'localhost';
GRANT ALL ON outlandadventures.trip_locations TO 'D.B._Marland'@'localhost';
GRANT ALL ON outlandadventures.visa_requirements TO 'John_MacNell'@'localhost';
GRANT ALL ON outlandadventures.visa_requirements TO 'D.B._Marland'@'localhost';
GRANT ALL ON outlandadventures.inoculations TO 'John_MacNell'@'localhost';
GRANT ALL ON outlandadventures.inoculations TO 'D.B._Marland'@'localhost';
GRANT ALL ON outlandadventures.airfare TO 'John_MacNell'@'localhost';
GRANT ALL ON outlandadventures.airfare TO 'D.B._Marland'@'localhost';
GRANT ALL ON outlandadventures.customerBooking TO 'John_MacNell'@'localhost';
GRANT ALL ON outlandadventures.customerBooking TO 'D.B._Marland'@'localhost';
GRANT ALL ON outlandadventures.supplier TO 'Dimitrios_Stravopolous'@'localhost';
GRANT ALL ON outlandadventures.equipmet TO 'Dimitrios_Stravopolous'@'localhost';
GRANT ALL ON outlandadventures.supplyOrder TO 'Dimitrios_Stravopolous'@'localhost';
/* Mei's privileges will be revoked after the completetion of ecommerce site,
if anything is added to database that needs to be uploaded to site, we will grant her privileges again */

-- drop tables if they are present
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS supplier;
DROP TABLE IF EXISTS customerOrder;
DROP TABLE IF EXISTS customerBooking;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS supplyOrder;
DROP TABLE IF EXISTS trip_location;
DROP TABLE IF EXISTS visa_requirements;
DROP TABLE IF EXISTS inoculations;
DROP TABLE IF EXISTS airfare;
SET FOREIGN_KEY_CHECKS = 1;



-- create the department table 
CREATE TABLE department (
	department_id     INT             NOT NULL        AUTO_INCREMENT,
    department_name   VARCHAR(75)     NOT NULL,
     
  PRIMARY KEY(department_id)
); 

-- create the employee table 
CREATE TABLE employee (
    employee_id     	  INT             NOT NULL        AUTO_INCREMENT,
    employee_first_name   VARCHAR(75)     NOT NULL,
    employee_last_name	  VARCHAR(75)	  NOT NULL,
    employee_address	  VARCHAR(75)	  NOT NULL,
    employee_phone		  VARCHAR(75)	  NOT NULL,
    employee_email		  VARCHAR(75)	  NOT NULL,
    department_id		  INT             NOT NULL,  
    
    PRIMARY KEY(employee_id),
    
    CONSTRAINT fk_department
    FOREIGN KEY(department_id)
        REFERENCES department(department_id)
);

-- create the customer table 
CREATE TABLE customer (
    customer_id     	  INT             NOT NULL        AUTO_INCREMENT,
    customer_first_name   VARCHAR(75)     NOT NULL,
    customer_last_name    VARCHAR(75)     NOT NULL,
    customer_phone		  VARCHAR(75)     NOT NULL,
    customer_email		  VARCHAR(75)     NOT NULL,
    customer_address	  VARCHAR(75)     NOT NULL,
     
    PRIMARY KEY(customer_id)
); 

-- create equipment table
CREATE TABLE equipment (
	equipment_id	 		 INT             NOT NULL        AUTO_INCREMENT,
	equipment_name			 VARCHAR(75)     NOT NULL,
    equipment_unit_price     INT             NOT NULL,
	equipment_rent_price     INT             NOT NULL,
    equipment_buy_price   	 INT		     NOT NULL,
    equipment_quantity	     INT     		 NOT NULL,
  
    PRIMARY KEY(equipment_id)
);

-- create the supplier table 
CREATE TABLE supplier (
    supplier_id     	INT             NOT NULL        AUTO_INCREMENT,
    supplier_name   	VARCHAR(75)     NOT NULL,
    supplier_address    VARCHAR(75)     NOT NULL,
    supplier_phone   	VARCHAR(75)     NOT NULL,
    supplier_email   	VARCHAR(75)     NOT NULL,
    supplier_rep_name	VARCHAR(75)     NOT NULL,
     
    PRIMARY KEY(supplier_id)
); 

-- create SupplyOrder table
CREATE TABLE supplyOrder (
	supply_order_id	 		 INT             NOT NULL        AUTO_INCREMENT,
	equipment_id			 INT		     NOT NULL,
    supply_order_quantity  	 INT		     NOT NULL,
    supply_order_date	     DATE			 NOT NULL,
    supplier_id	         	 INT     		 NOT NULL,	
    
    PRIMARY KEY(supply_order_id),
            
	CONSTRAINT fk_equipment	
    FOREIGN KEY(equipment_id)
    	REFERENCES equipment(equipment_id),
    
    CONSTRAINT fk_supplier
    FOREIGN KEY(supplier_id)
    	REFERENCES supplier(supplier_id)
);

-- create CustomerOrder table
CREATE TABLE customerOrder (
	customer_order_id	 	 		INT             NOT NULL        AUTO_INCREMENT,
	customer_id				 		INT		     	NOT NULL,
	equipment_id     		 		INT             NOT NULL,
    customer_equipment_quantity   	INT		        NOT NULL,
    customer_order_date	     		DATE		     NOT NULL,
    rented_or_bought	         	VARCHAR(75)     NOT NULL,	
    
    PRIMARY KEY(customer_order_id),
    
	CONSTRAINT fk_customer
    FOREIGN KEY(customer_id)
        REFERENCES customer(customer_id),
	
    FOREIGN KEY(equipment_id)
    	REFERENCES equipment(equipment_id)
);

-- create the trip_location table 
CREATE TABLE trip_location (
    trip_location_id     INT             NOT NULL        AUTO_INCREMENT,
    trip_location_name   VARCHAR(75)     NOT NULL,
     
    PRIMARY KEY(trip_location_id)
); 


-- create the visa_requirements table 
CREATE TABLE visa_requirements (
    visa_requirements_id     INT            NOT NULL        AUTO_INCREMENT,
    visa_requirements_name   VARCHAR(75)    NOT NULL,
    trip_location_id		 INT			NOT NULL,
     
    PRIMARY KEY(visa_requirements_id),
    
    CONSTRAINT fk_trip_location    
    FOREIGN KEY(trip_location_id)
    	REFERENCES trip_location(trip_location_id)
); 

-- create the inoculations table 
CREATE TABLE inoculations (
    inoculations_id     INT             NOT NULL        AUTO_INCREMENT,
    inoculations_name   VARCHAR(75)     NOT NULL,
    trip_location_id	INT             NOT NULL,
     
    PRIMARY KEY(inoculations_id),
    
    FOREIGN KEY(trip_location_id)
    	REFERENCES trip_location(trip_location_id)
); 

-- create the airfare table 
CREATE TABLE airfare (
    airfare_id          INT             NOT NULL        AUTO_INCREMENT,
	airfare_price	    INT    	 		NOT NULL,
    season              VARCHAR(75)     NOT NULL,
    trip_location_id	INT     		NOT NULL,
     
    PRIMARY KEY(airfare_id),
    
    FOREIGN KEY(trip_location_id)
    	REFERENCES trip_location(trip_location_id)
); 

-- create customer booking table
CREATE TABLE customerBooking (
	customer_booking_id	 INT             NOT NULL        AUTO_INCREMENT,
	customer_id			 INT			 NOT NULL,
	trip_location_id     INT             NOT NULL,
    customer_trip_date   DATE		    NOT NULL,
    airfare_id		     INT     		NOT NULL,
    employee_id	         INT     		NOT NULL,
    
    PRIMARY KEY(customer_booking_id),

    FOREIGN KEY(customer_id)
        REFERENCES customer(customer_id),
	
    FOREIGN KEY(trip_location_id)
    	REFERENCES trip_location(trip_location_id),
    	
    CONSTRAINT fk_airfare
    FOREIGN KEY(airfare_id)
    	REFERENCES airfare(airfare_id),
    	
    CONSTRAINT fk_employee
    FOREIGN KEY(employee_id)
    	REFERENCES employee(employee_id)
    	
);

-- insert to department table Should we replace planning with Guides or keep it as is?
INSERT INTO department(department_name) VALUES('CEO');
INSERT INTO department(department_name) VALUES('Marketing');
INSERT INTO department(department_name) VALUES('Supplier');
INSERT INTO department(department_name) VALUES('IT');
INSERT INTO department(department_name) VALUES('Guides');

-- insert into employee table
INSERT INTO employee(employee_first_name, employee_last_name,employee_address,employee_phone,employee_email,department_id) 
VALUES('Blythe', 'Timmerson', '2333 9th Street Moline', '309 429 0642', 'BlytheTimmerson@gmail.com', (SELECT department_id FROM department WHERE department_name = 'CEO'));

INSERT INTO employee(employee_first_name, employee_last_name,employee_address,employee_phone,employee_email,department_id) 
VALUES('Jim', 'Ford', '4252 11th Street Moline', '309 463 0609', 'JimFord@gmail.com', (SELECT department_id FROM department WHERE department_name = 'CEO'));

INSERT INTO employee(employee_first_name, employee_last_name,employee_address,employee_phone,employee_email,department_id) 
VALUES('John', 'MacNell', '5620 6th Street Moline', '309 565 0609', 'JohnMacNell@gmail.com', (SELECT department_id FROM department WHERE department_name = 'Guides'));

INSERT INTO employee(employee_first_name, employee_last_name,employee_address,employee_phone,employee_email,department_id) 
VALUES('D.B.', 'Marland', '4020 6th Street Moline', '309 222 1709', 'dbMarlandl@gmail.com', (SELECT department_id FROM department WHERE department_name = 'Guides'));

INSERT INTO employee(employee_first_name, employee_last_name,employee_address,employee_phone,employee_email,department_id) 
VALUES('Anita', 'Gallegos', '5110 6th Street Moline', '309 429 1709', 'anitaGallegos@gmail.com', (SELECT department_id FROM department WHERE department_name = 'Marketing'));

INSERT INTO employee(employee_first_name, employee_last_name,employee_address,employee_phone,employee_email,department_id) 
VALUES('Dimitrios', 'Stravopolous', '3695 3rd Street Moline', '309 632 1709', 'dimitriosStravopolous@gmail.com', (SELECT department_id FROM department WHERE department_name = 'Supplier'));

INSERT INTO employee(employee_first_name, employee_last_name,employee_address,employee_phone,employee_email,department_id) 
VALUES('Mei', 'Wong', '1110 17th Avenue Moline', '309 632 0001', 'MeiWong@gmail.com', (SELECT department_id FROM department WHERE department_name = 'IT'));
   
-- Insert into customer table
INSERT INTO customer(customer_first_name, customer_last_name, customer_phone,customer_email, customer_address)
VALUES('James', 'Smith','309 632 0832', 'JamesSmith@yahoo.com', '2221 22th Avenue Davenport');

INSERT INTO customer(customer_first_name, customer_last_name, customer_phone,customer_email, customer_address)
VALUES('Michael', 'Garcia','309 492 4132', 'MichaelGarcia@yahoo.com', '2005 17th Avenue Moline');

INSERT INTO customer(customer_first_name, customer_last_name, customer_phone,customer_email, customer_address)
VALUES('David', 'Martina ','309 501 4452', 'DavidMartina@gmail.com', '1111 17th Avenue Missourie');
 
INSERT INTO customer(customer_first_name, customer_last_name, customer_phone,customer_email, customer_address)
VALUES('Maria', 'Martinez','309 305 1142', 'MariaMartinez@gmail.com', '5523 8th Avenue Texas');
 
INSERT INTO customer(customer_first_name, customer_last_name, customer_phone,customer_email, customer_address)
VALUES('James', 'Johnson','855 606 3056', 'Jamesjohnson@gmail.com', '2031 8th Street Moline');

INSERT INTO customer(customer_first_name, customer_last_name, customer_phone,customer_email, customer_address)
VALUES('Bob', 'Workman','855 633 3456', 'Bobworkman@gmail.com', '1129 15th Street Moline');
 
-- insert into supplier table 
INSERT INTO supplier(supplier_name, supplier_address, supplier_phone, supplier_email, supplier_rep_name)
VALUES('Active Enddeavors', '3950 Elmore Avenue, Davenport, IA 52807', '563 441 9488', 'Activeenddeavors@gmail.com','Roberta');

INSERT INTO supplier(supplier_name, supplier_address, supplier_phone, supplier_email, supplier_rep_name)
VALUES('Field & Stream', '5511 Elmore Avenue Ste B, Davenport, IA 52807', '563 355 7042', 'Field@Stream.com','Smith' );

INSERT INTO supplier(supplier_name, supplier_address, supplier_phone, supplier_email, supplier_rep_name)
VALUES('REI','7483 W Towne Way, Madison, WI 53719', '608 833 6680', 'rei@capimg.com', 'Roberta');

INSERT INTO supplier(supplier_name, supplier_address, supplier_phone, supplier_email, supplier_rep_name)
VALUES('Jacks Camp','809 N 25th Rd, Oglesby, IL 61348', '815 667 4506', 'Jackscamp@gmail.com', 'Hernandez');

INSERT INTO supplier(supplier_name, supplier_address, supplier_phone, supplier_email, supplier_rep_name)
VALUES('Dark Night','11618 6th St, Milan, IL 61264', '309 781 8421', 'Darknight@gmail.com', 'Hartman');

INSERT INTO supplier(supplier_name, supplier_address, supplier_phone, supplier_email, supplier_rep_name)
VALUES('Cabela,s', ' 5225 Prairie Stone Pkwy, Hoffman Estates, IL 60192','847 645 0400', 'Cabela@gmail.com','Winner');

-- insert into equipment table
INSERT INTO equipment (equipment_name, equipment_unit_price, equipment_rent_price, equipment_buy_price, equipment_quantity)
VALUES('Tents', 10, 20, 100, 2);

INSERT INTO equipment (equipment_name, equipment_unit_price, equipment_rent_price, equipment_buy_price, equipment_quantity)
VALUES('sleeping bags', 8, 15, 75, 5);

INSERT INTO equipment (equipment_name, equipment_unit_price, equipment_rent_price, equipment_buy_price, equipment_quantity)
VALUES('headlamps',3,  10, 40, 5);

INSERT INTO equipment (equipment_name, equipment_unit_price, equipment_rent_price, equipment_buy_price, equipment_quantity)
VALUES('Camp chairs', 2,  5, 25, 5);

INSERT INTO equipment (equipment_name, equipment_unit_price, equipment_rent_price, equipment_buy_price, equipment_quantity)
VALUES('Lanterns', 2, 5, 25, 10);

INSERT INTO equipment (equipment_name, equipment_unit_price, equipment_rent_price, equipment_buy_price, equipment_quantity)
VALUES('Boots', 13, 20, 60, 5);

-- insert into trip location
INSERT INTO trip_location (trip_location_name)  VALUES('Africa');
INSERT INTO trip_location (trip_location_name)  VALUES('Asia');
INSERT INTO trip_location (trip_location_name)  VALUES('Southern Europe');

-- insert into visa_requirement
INSERT INTO visa_requirements(visa_requirements_name, trip_location_id) 
VALUES('Botswana Tourist eVisa', (SELECT trip_location_id FROM trip_location WHERE trip_location_name = 'Africa'));

INSERT INTO visa_requirements(visa_requirements_name, trip_location_id) 
VALUES('China Tourist Visa - L Visa', (SELECT trip_location_id FROM trip_location WHERE trip_location_name = 'Asia'));

INSERT INTO visa_requirements(visa_requirements_name, trip_location_id) 
VALUES('Italian Schengen Visa', (SELECT trip_location_id FROM trip_location WHERE trip_location_name = 'Southern Europe'));

INSERT INTO visa_requirements(visa_requirements_name, trip_location_id) 
VALUES('Japan Tourist Visa', (SELECT trip_location_id FROM trip_location WHERE trip_location_name = 'Asia'));

INSERT INTO visa_requirements(visa_requirements_name, trip_location_id) 
VALUES('Greek Schengen visa', (SELECT trip_location_id FROM trip_location WHERE trip_location_name = 'Southern Europe'));

INSERT INTO visa_requirements(visa_requirements_name, trip_location_id) 
VALUES('Egypt e-Visa', (SELECT trip_location_id FROM trip_location WHERE trip_location_name = 'Africa'));

-- insert into inoculations table 
INSERT INTO inoculations(inoculations_name, trip_location_id) 
VALUES('Measles-Mumps-Rubella (MMR)', (SELECT trip_location_id FROM trip_location WHERE trip_location_name = 'Africa'));

INSERT INTO inoculations(inoculations_name, trip_location_id) 
VALUES('Tick-borne Encephalitis', (SELECT trip_location_id FROM trip_location WHERE trip_location_name = 'Asia'));

INSERT INTO inoculations(inoculations_name, trip_location_id) 
VALUES('Hepatitis A', (SELECT trip_location_id FROM trip_location WHERE trip_location_name = 'Southern Europe'));

INSERT INTO inoculations(inoculations_name, trip_location_id) 
VALUES('Japanese Encephalitis', (SELECT trip_location_id FROM trip_location WHERE trip_location_name = 'Asia'));

INSERT INTO inoculations(inoculations_name, trip_location_id) 
VALUES('Shingles', (SELECT trip_location_id FROM trip_location WHERE trip_location_name = 'Southern Europe'));

INSERT INTO inoculations(inoculations_name, trip_location_id) 
VALUES('Rabies', (SELECT trip_location_id FROM trip_location WHERE trip_location_name = 'Africa'));

-- insert into airfare table 
INSERT INTO airfare(airfare_price, season, trip_location_id) 
VALUES(1640, 'Spring', (SELECT trip_location_id FROM trip_location WHERE trip_location_name = 'Africa'));

INSERT INTO airfare(airfare_price, season, trip_location_id) 
VALUES(5173, 'Winter', (SELECT trip_location_id FROM trip_location WHERE trip_location_name = 'Asia'));

INSERT INTO airfare(airfare_price, season, trip_location_id) 
VALUES(918, 'Summer', (SELECT trip_location_id FROM trip_location WHERE trip_location_name = 'Southern Europe'));

INSERT INTO airfare(airfare_price, season, trip_location_id) 
VALUES(1139, 'Spring', (SELECT trip_location_id FROM trip_location WHERE trip_location_name = 'Asia'));

INSERT INTO airfare(airfare_price, season, trip_location_id) 
VALUES(743, 'Fall', (SELECT trip_location_id FROM trip_location WHERE trip_location_name = 'Southern Europe'));

INSERT INTO airfare(airfare_price, season, trip_location_id) 
VALUES(675,  'Summer', (SELECT trip_location_id FROM trip_location WHERE trip_location_name = 'Africa')); 

-- insert into customerOrder table
INSERT INTO customerOrder(customer_id, equipment_id, customer_equipment_quantity, customer_order_date, rented_or_bought) 
VALUES((SELECT customer_id FROM customer WHERE customer_id = '1'), (SELECT equipment_id FROM equipment WHERE equipment_id = '6'), 
'1', '2020/09/16 ', 'RENT');

INSERT INTO customerOrder(customer_id, equipment_id, customer_equipment_quantity, customer_order_date, rented_or_bought) 
VALUES((SELECT customer_id FROM customer WHERE customer_id = '2'), (SELECT equipment_id FROM equipment WHERE equipment_id = '5'), 
'1', '2018/05/15 ', 'BUY');

INSERT INTO customerOrder(customer_id, equipment_id, customer_equipment_quantity, customer_order_date, rented_or_bought) 
VALUES((SELECT customer_id FROM customer WHERE customer_id = '3'), (SELECT equipment_id FROM equipment WHERE equipment_id = '4'), 
'2', '2022/06/14', 'RENT');

INSERT INTO customerOrder(customer_id, equipment_id, customer_equipment_quantity, customer_order_date, rented_or_bought) 
VALUES((SELECT customer_id FROM customer WHERE customer_id = '4'), (SELECT equipment_id FROM equipment WHERE equipment_id = '3'), 
'2 ', '2017/02/13', 'BUY');

INSERT INTO customerOrder(customer_id, equipment_id, customer_equipment_quantity, customer_order_date, rented_or_bought) 
VALUES((SELECT customer_id FROM customer WHERE customer_id = '5'), (SELECT equipment_id FROM equipment WHERE equipment_id = '2'), 
'1 ', '2021/04/27', 'RENT');

INSERT INTO customerOrder(customer_id, equipment_id, customer_equipment_quantity, customer_order_date, rented_or_bought) 
VALUES((SELECT customer_id FROM customer WHERE customer_id = '6'), (SELECT equipment_id FROM equipment WHERE equipment_id = '1'), 
'5', '2015/11/15', 'BUY');

-- insert into supplyOrder table
INSERT INTO supplyOrder (equipment_id, supply_order_quantity, supply_order_date, supplier_id)
VALUES ((SELECT equipment_id FROM equipment WHERE equipment_id = '1'), '4', '2022/02/19', 
(SELECT supplier_id FROM supplier WHERE supplier_id = '3 '));

INSERT INTO supplyOrder (equipment_id, supply_order_quantity, supply_order_date, supplier_id)
VALUES ((SELECT equipment_id FROM equipment WHERE equipment_id = '2'), '6', '2015/07/07', 
(SELECT supplier_id FROM supplier WHERE supplier_id = '5'));

INSERT INTO supplyOrder (equipment_id, supply_order_quantity, supply_order_date, supplier_id)
VALUES ((SELECT equipment_id FROM equipment WHERE equipment_id = '3'), '9', '2017/04/12', 
(SELECT supplier_id FROM supplier WHERE supplier_id = '2'));

INSERT INTO supplyOrder (equipment_id, supply_order_quantity, supply_order_date, supplier_id)
VALUES ((SELECT equipment_id FROM equipment WHERE equipment_id = '4'), '1', '2021/12/03', 
(SELECT supplier_id FROM supplier WHERE supplier_id = '1'));

INSERT INTO supplyOrder (equipment_id, supply_order_quantity, supply_order_date, supplier_id)
VALUES ((SELECT equipment_id FROM equipment WHERE equipment_id = '5'), '15', '2016/04/15', 
(SELECT supplier_id FROM supplier WHERE supplier_id = '6'));

INSERT INTO supplyOrder (equipment_id, supply_order_quantity, supply_order_date, supplier_id)
VALUES ((SELECT equipment_id FROM equipment WHERE equipment_id = '6'), '25', '2020/10/31', 
(SELECT supplier_id FROM supplier WHERE supplier_id = '4'));

-- insert into customerBooking table
INSERT INTO customerBooking (customer_id, trip_location_id, customer_trip_date, airfare_id, employee_id)
VALUES ((SELECT customer_id FROM customer WHERE customer_id = '1'), (SELECT trip_location_id FROM trip_location WHERE trip_location_id = '3'), 
'2023/09/09', (SELECT airfare_id FROM airfare WHERE airfare_id = '5'), (SELECT employee_id FROM employee WHERE employee_id = '3'));

INSERT INTO customerBooking (customer_id, trip_location_id, customer_trip_date, airfare_id, employee_id)
VALUES ((SELECT customer_id FROM customer WHERE customer_id = '2'), (SELECT trip_location_id FROM trip_location WHERE trip_location_id = '2'), 
'2022/12/15', (SELECT airfare_id FROM airfare WHERE airfare_id = '2'), (SELECT employee_id FROM employee WHERE employee_id = '4'));

INSERT INTO customerBooking (customer_id, trip_location_id, customer_trip_date, airfare_id, employee_id)
VALUES ((SELECT customer_id FROM customer WHERE customer_id = '3'), (SELECT trip_location_id FROM trip_location WHERE trip_location_id = '1'), 
'2020/06/25', (SELECT airfare_id FROM airfare WHERE airfare_id = '6'), (SELECT employee_id FROM employee WHERE employee_id = '3'));

INSERT INTO customerBooking (customer_id, trip_location_id, customer_trip_date, airfare_id, employee_id)
VALUES ((SELECT customer_id FROM customer WHERE customer_id = '4'), (SELECT trip_location_id FROM trip_location WHERE trip_location_id = '2'), 
'2019/04/18', (SELECT airfare_id FROM airfare WHERE airfare_id = '4'), (SELECT employee_id FROM employee WHERE employee_id = '4'));

INSERT INTO customerBooking (customer_id, trip_location_id, customer_trip_date, airfare_id, employee_id)
VALUES ((SELECT customer_id FROM customer WHERE customer_id = '5'), (SELECT trip_location_id FROM trip_location WHERE trip_location_id = '3'), 
'2021/10/25', (SELECT airfare_id FROM airfare WHERE airfare_id = '5'), (SELECT employee_id FROM employee WHERE employee_id = '3'));

INSERT INTO customerBooking (customer_id, trip_location_id, customer_trip_date, airfare_id, employee_id)
VALUES ((SELECT customer_id FROM customer WHERE customer_id = '6'), (SELECT trip_location_id FROM trip_location WHERE trip_location_id = '2'), 
'2020/01/17', (SELECT airfare_id FROM airfare WHERE airfare_id = '2'), (SELECT employee_id FROM employee WHERE employee_id = '3'));

