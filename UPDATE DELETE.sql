SELECT *
FROM customers;

UPDATE customers
SET cust_email = 'kim@thetoystore.com'
WHERE cust_id = '1000000005';

UPDATE customers
SET cust_contact = 'Sam Roberts',
    cust_email = 'sam@toyland.com'
WHERE cust_id = '1000000006';

UPDATE customers
SET cust_email = NULL
WHERE cust_id = '1000000005';

DELETE
FROM customers
WHERE cust_id = '1000000008';