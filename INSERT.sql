SELECT *
FROM customers;

INSERT INTO customers
VALUES('1000000006',
	   'Toy Land',
       '123 Any Street',
       'New York',
       'NY',
       '11111',
       'USA',
       NULL,
       NULL);
       
INSERT INTO customers(cust_id,
                      cust_name,
                      cust_address,
                      cust_city,
                      cust_state,
                      cust_zip,
                      cust_country,
                      cust_contact,
                      cust_email)
VALUES('1000000007',
	   'Toy Land',
       '123 Any Street',
       'New York',
       'NY',
       '11111',
       'USA',
       NULL,
       NULL);
       
INSERT INTO customers(cust_id,
                      cust_name,
                      cust_address,
                      cust_city,
                      cust_state,
                      cust_zip,
                      cust_country)
VALUES('1000000008',
	   'Toy Land',
       '123 Any Street',
       'New York',
       'NY',
       '11111',
       'USA');
       
CREATE TABLE custcopy AS
SELECT *
FROM customers; #从一个表复制到另一个表

SHOW tables;