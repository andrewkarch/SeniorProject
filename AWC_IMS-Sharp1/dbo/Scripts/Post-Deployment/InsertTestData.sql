/*
	Delete all current test data from the tables.
 */
/*Level 6*/
DELETE FROM purchase_order_product;
/*Level 5*/
DELETE FROM purchase_order;
/*Level 4*/
DELETE FROM customer_shipping_address;
/*Level 3*/
DELETE FROM employee;
DELETE FROM customer;
/*Level 2*/
DELETE FROM position;
DELETE FROM account;
DELETE FROM inventory;
/*Level 1*/
DELETE FROM authorization_level;
DELETE FROM department;
DELETE FROM product;



/*____________________________LEVEL 1______________________________*/
/*
	Inserts test data into the authorization_level table.
 */
 INSERT INTO authorization_level (name, "description")

 VALUES ('Admin', 'Allows administrator rights'),

	    ('Orders', 'Allows employees to view oustanding orders'),

		('Order Webpage', 'Allows entry on the customer webpage'),
		
		('Picker', 'Allows pickers to log in to the system and view next order to fill.'),
		
		('Maintenance', 'Allows maintenance workers to adjust orders and inventory.');

/*
	Inserts test data into the department table.
 */
 INSERT INTO department (name, "description")

VALUES ('Maintenance', 'The maintenace department.'),

	   ('Manufacturing', 'The manufacturing department.'),

	   ('Sales', 'The sales department'),

	   ('IT', 'The IT department'),

	   ('Human Resources', 'The human resources department');

/*
	Inserts test data into the product table
 */
 INSERT INTO product (name, "description", price, active)

 VALUES ('Widget 1', 'This is widget 1', 54.23, 1),

		('Widget 2', 'This is widget 2', 41.83, 1),

		('Widget 3', 'This is widget 3', 67.14, 0),

		('Widget 4', 'This is widget 4', 2.34, 1);
 



/*____________________________LEVEL 2______________________________*/
/*
	Insert test data into the position table.
 */
 INSERT INTO position (title, department_id)

 VALUES ('Picker', (SELECT department_id FROM department WHERE name = 'Manufacturing')),

		('Order Maintenance', (SELECT department_id FROM department WHERE name = 'Maintenance')),

		('Sales Associate', (SELECT department_id FROM department WHERE name = 'Sales')),

		('Systems Analyst', (SELECT department_id FROM department WHERE name = 'IT'));

/*
	Inserts test data into the account table.
 */
 INSERT INTO account (username, "password", authorization_id, create_date)

 VALUES ('itc', '123456', (SELECT authorization_id FROM authorization_level WHERE name = 'Order Webpage'), GETDATE()),

		('aksteel', '123456', (SELECT authorization_id FROM authorization_level WHERE name = 'Order Webpage'), GETDATE()),

		('hooters', '123456', (SELECT authorization_id FROM authorization_level WHERE name = 'Order Webpage'), GETDATE()),

		('bestbuy', '123456', (SELECT authorization_id FROM authorization_level WHERE name = 'Order Webpage'), GETDATE()),

		('walmart', '123456', (SELECT authorization_id FROM authorization_level WHERE name = 'Order Webpage'), GETDATE()),

		('meadj', '123456', (SELECT authorization_id FROM authorization_level WHERE name = 'Order Webpage'), GETDATE()),
		
		('jdaming','123456', (SELECT authorization_id FROM authorization_level WHERE name = 'Maintenance'), GETDATE()),
		
		('jsmith', '123456', (SELECT authorization_id FROM authorization_level WHERE name = 'Picker'), GETDATE()),

		('tsmith', '123456', (SELECT authorization_id FROM authorization_level WHERE name = 'Picker'), GETDATE()),
		
		('dsmith', '123456', (SELECT authorization_id FROM authorization_level WHERE name = 'Admin'), GETDATE()),
		
		('mshapker', '123456', (SELECT authorization_id FROM authorization_level WHERE name = 'Orders'), GETDATE());

/*
	Insert test date into the inventory table
 */
 INSERT INTO inventory (product_id, quantity, "row", box)

 VALUES ((SELECT product_id FROM product WHERE name = 'Widget 1'), 130, 2, 'A'),

		((SELECT product_id FROM product WHERE name = 'Widget 1'), 14, 2, 'B'),

		((SELECT product_id FROM product WHERE name = 'Widget 2'), 36, 1, 'A'),

		((SELECT product_id FROM product WHERE name = 'Widget 3'), 65, 3, 'C'),

		((SELECT product_id FROM product WHERE name = 'Widget 4'), 1034, 1, 'C')



/*____________________________LEVEL 3______________________________*/
/*	
	Inserts test data into the customer table.
 */
 INSERT INTO customer (name,"description", billing_street_address, 
						billing_city, billing_state, billing_zipcode, 
						billing_country, username)

VALUES ('Indiana Tube Corporation', 'Steel Tube Maker', '2600 Lexington Ave.',
		'Evansville', 'IN', '47720', 'United States of America', 'itc'),

	   ('AK Steel', 'Steel Maker', 'State Rd. 231',
		'Rockport', 'IN', '47635', 'United States of America', 'aksteel'),
		
	   ('Hooters', 'Restaurant', '426 S. Green River Rd.',
		'Evansville', 'IN', '47712', 'United States of America', 'hooters'),
		
	   ('Best Buy', 'Electronics Retailer', '6726 Burkhardt Ave.',
		'Evansville', 'IN', '47711', 'United States of America', 'bestbuy'),
		
	   ('Walmart', 'Retailer', '5232 Burkhardt Ave.',
		'Evansville', 'IN', '47711', 'United States of America', 'walmart'),
		
	   ('Mead Johnson', '', '310 St. Joseph Ave.',
		'Evansville', 'IN', '47712', 'United States of America', 'meadj');

/*
	Insert test data into the employee table.
 */
 INSERT INTO employee (first_name, middle_name, last_name, username, date_of_birth,
						"start_date", position_id, street_address, city, "state", zipcode,
						country, home_phone, mobile_phone, work_phone, active)

VALUES ('Jason', 'Michael', 'Smith', 'jsmith', '11/23/1978', '1/3/2003', 
		(SELECT position_id FROM position WHERE title = 'Picker'),
		'75 S. Hodges Dr.', 'Richland', 'IN', '47634', 'United States of America', null, null, '18128373476', 1),
		
	   ('Tom', 'Aaron', 'Smith', 'tsmith', '11/23/1983', '4/6/2003', 
	   (SELECT position_id FROM position WHERE title = 'Picker'),
	   '86 S. Hodges Dr.', 'Richland', 'IN', '47634', 'United States of America', '1812736362', null, '1812839837', 1);



/*____________________________LEVEL 4______________________________*/
/*
	Inserts test data in the customer_shipping_address table
 */
 INSERT INTO customer_shipping_address (customer_id, shipping_street_address, shipping_city,
										shipping_state, shipping_zipcode, shipping_country)

VALUES ((SELECT customer_id FROM customer WHERE name = 'Indiana Tube Corporation'), '2600 Lexington Ave.',
		'Evansville', 'IN', '47720', 'United States of America'),

	   ((SELECT customer_id FROM customer WHERE name = 'AK Steel'), 'State Rd. 231',
		'Rockport', 'IN', '47635', 'United States of America'),
		
	   ((SELECT customer_id FROM customer WHERE name = 'Hooters'), '426 S. Green River Rd.',
		'Evansville', 'IN', '47712', 'United States of America'),
		
	   ((SELECT customer_id FROM customer WHERE name = 'Best Buy'), '6726 Burkhardt Ave.',
		'Evansville', 'IN', '47711', 'United States of America'),
		
	   ((SELECT customer_id FROM customer WHERE name = 'Walmart'), '5232 Burkhardt Ave.',
		'Evansville', 'IN', '47711', 'United States of America'),
		
	   ((SELECT customer_id FROM customer WHERE name = 'Mead Johnson'), '310 St. Joseph Ave.',
		'Evansville', 'IN', '47712', 'United States of America');



/*____________________________LEVEL 5______________________________*/
/*
	Insert test data in the purchase_order table
 */
 INSERT INTO purchase_order (customer_id, date_placed, csa_id)

 VALUES ((SELECT customer_id FROM customer WHERE name = 'Indiana Tube Corporation'), GETDATE(),
			(SELECT csa_id FROM customer_shipping_address WHERE customer_id = (SELECT customer_id FROM customer WHERE name = 'Indiana Tube Corporation')));



/*____________________________LEVEL 6______________________________*/
/*
	Insert test data in the purchase_order_product table
 */
 INSERT INTO purchase_order_product (po_id,product_id, quantity)

 VALUES ((SELECT po_id FROM purchase_order), (SELECT product_id FROM product WHERE name = 'Widget 1'), 30),

		((SELECT po_id FROM purchase_order), (SELECT product_id FROM product WHERE name = 'Widget 3'), 10),

		((SELECT po_id FROM purchase_order), (SELECT product_id FROM product WHERE name = 'Widget 4'), 3);