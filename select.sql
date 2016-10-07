USE tysql;

SELECT prod_name 
FROM products;

SELECT prod_id, prod_name, prod_price
FROM products;

SELECT *
FROM products;

SELECT vend_id
FROM products;

SELECT DISTINCT vend_id
FROM products;

SELECT prod_name
FROM products
LIMIT 5;

SELECT prod_name
FROM products
LIMIT 5 OFFSET 5;

SELECT prod_name
FROM products
ORDER BY prod_name;

SELECT prod_id, prod_price, prod_name
FROM products
ORDER BY prod_price, prod_name;

SELECT prod_id, prod_price, prod_name
FROM products
ORDER BY 2, 3;

SELECT prod_id, prod_price, prod_name
FROM products
ORDER BY prod_price DESC;

SELECT prod_id, prod_price, prod_name
FROM products
ORDER BY prod_price DESC, prod_name;

SELECT prod_name, prod_price
FROM products
WHERE prod_price = 3.49;

SELECT prod_name, prod_price
FROM products
WHERE prod_price < 10;

SELECT prod_name, prod_price
FROM products
WHERE prod_price <= 10;

SELECT vend_id, prod_name
FROM products
WHERE vend_id <> 'DLL01';

SELECT vend_id, prod_name
FROM products
WHERE vend_id != 'DLL01';

SELECT prod_name, prod_price
FROM products
WHERE prod_price BETWEEN 5 AND 10;

SELECT cust_name
FROM customers
WHERE cust_email IS NULL;

SELECT prod_id, prod_price, prod_name
FROM products
WHERE vend_id = 'DLL01' AND prod_price <= 4;

SELECT prod_id, prod_price, prod_name, vend_id
FROM products
WHERE vend_id = 'DLL01' OR vend_id = 'BRS01';

SELECT prod_name, prod_price, vend_id
FROM products
WHERE (vend_id = 'DLL01' OR vend_id = 'BRS01') AND prod_price >= 10;

SELECT prod_name, prod_price
FROM products
WHERE vend_id IN ('DLL01', 'BRS01')
ORDER BY prod_name;

SELECT prod_name, prod_price
FROM products
WHERE vend_id = 'DLL01' OR vend_id = 'BRS01'
ORDER BY prod_name;

SELECT prod_name, vend_id
FROM products
WHERE NOT vend_id = 'DLL01'
ORDER BY prod_name;

SELECT prod_name, vend_id
FROM products
WHERE vend_id <> 'DLL01'
ORDER BY prod_name;

SELECT prod_id, prod_name
FROM products
WHERE prod_name LIKE 'Fish%';

SELECT prod_id, prod_name
FROM products
WHERE prod_name LIKE '%bean bag%';

SELECT prod_name
FROM products
WHERE prod_name LIKE 'F%y';

SELECT prod_name
FROM products
WHERE prod_name LIKE '%';

SELECT prod_id, prod_name
FROM products
WHERE prod_name LIKE '__ inch teddy bear';

SELECT prod_id, prod_name
FROM products
WHERE prod_name LIKE '% inch teddy bear';

SELECT cust_contact
FROM customers
WHERE cust_contact LIKE '[JM]%' #Mysql中此句不管用，[]属于正则模式
ORDER BY cust_contact;

SELECT cust_contact
FROM customers
WHERE cust_contact REGEXP '[JM].*' #使用正则模式解决上述问题
ORDER BY cust_contact;

SELECT cust_contact
FROM customers
WHERE NOT cust_contact REGEXP '[JM].*' 
ORDER BY cust_contact;

SELECT concat(vend_name, '(', vend_country, ')') AS vend_title #Mysql中无法使用 + 进行拼接
FROM Vendors
ORDER BY vend_name;

SELECT prod_id, quantity, item_price, order_num, quantity*item_price AS expanded_price
FROM orderitems
WHERE order_num = 20008;

SELECT vend_name, UPPER(vend_name) AS vend_name_upcase
FROM vendors
ORDER BY vend_name;

SELECT cust_name, cust_contact
FROM customers
WHERE SOUNDEX(cust_contact) = SOUNDEX('Michael Green');

SELECT order_num, order_date
FROM orders
WHERE YEAR(order_date) = 2012;

SELECT AVG(prod_price) AS avg_price
FROM products
WHERE vend_id = 'DLL01';

SELECT *
FROM customers;

SELECT COUNT(*) AS num_cust
FROM customers;

SELECT COUNT(cust_email) AS num_cust
FROM customers;

SELECT MAX(prod_price) AS max_price
FROM products;

SELECT MIN(prod_price) AS min_price
FROM products;

SELECT SUM(quantity) AS items_ordered 
FROM orderitems
WHERE order_num = 20005;

SELECT item_price, quantity
FROM orderitems
WHERE order_num = 20005;

SELECT SUM(item_price*quantity) AS total_price
FROM orderitems
WHERE order_num = 20005;

SELECT AVG(DISTINCT prod_price) as avg_price
FROM products
WHERE vend_id = 'DLL01';

SELECT COUNT(*) AS num_item,
	   MIN(prod_price) AS price_min,
       MAX(prod_price) AS price_max,
       AVG(prod_price) AS price_avg
FROM products;

SELECT vend_id, COUNT(*) AS num_prods
FROM products
GROUP BY vend_id; #先分组，后计算COUNT

SELECT *
FROM orders;

SELECT cust_id, COUNT(*) AS orders
FROM orders
GROUP BY cust_id
HAVING COUNT(*) >= 2; #先分组，后计算，最后用HAVING过滤

SELECT *
FROM products;

SELECT vend_id, COUNT(*) AS num_prods
FROM products
WHERE prod_price >= 4
GROUP BY vend_id
HAVING COUNT(*) >= 2
ORDER BY num_prods;

#视图
SELECT cust_name, cust_contact
FROM customers, orders, orderitems
WHERE customers.cust_id = orders.cust_id
	AND orders.order_num = orderitems.order_num
    AND prod_id = 'RGAN01';
    
CREATE VIEW productcustomers AS
SELECT cust_name, cust_contact, prod_id
FROM customers, orders, orderitems
WHERE customers.cust_id = orders.cust_id
AND orderitems.order_num = orders.order_num;

SELECT *
FROM productcustomers;

SELECT cust_name, cust_contact
FROM productcustomers
WHERE prod_id = 'RGAN01';

CREATE VIEW vendorlocation AS
SELECT CONCAT(vend_name, '(', vend_country, ')') AS vend_title
FROM vendors;

SELECT *
FROM vendorlocation;

CREATE VIEW customeremaillist AS
SELECT cust_id, cust_name, cust_email
FROM customers
WHERE cust_email IS NOT NULL;

SELECT *
FROM customeremaillist;

CREATE VIEW orderitemsexpanded AS
SELECT order_num,
       prod_id,
       quantity, 
       item_price,
       quantity*item_price AS expanded_price
FROM orderitems;

SELECT *
FROM orderitemsexpanded
WHERE order_num = 20008;

SELECT order_num
FROM orderitems
WHERE prod_id = 'RGAN01';

SELECT cust_id
FROM orders
WHERE order_num IN (20007,20008);

SELECT cust_id
FROM orders
WHERE order_num IN (SELECT order_num
					FROM orderitems
					WHERE prod_id = 'RGAN01');
                    
SELECT cust_name, cust_contact
FROM customers
WHERE cust_id IN ('1000000004','1000000005'); #硬编码顾客ID

SELECT cust_name, cust_contact
FROM customers
WHERE cust_id IN (SELECT cust_id
				  FROM orders
                  WHERE order_num IN (SELECT order_num
					                  FROM orderitems
					                  WHERE prod_id = 'RGAN01'));
                                      
SELECT COUNT(*) AS orders
FROM orders
WHERE cust_id = '1000000001';

#统计每个顾客的订单数目
SELECT cust_name, cust_state, 
       (SELECT COUNT(*)
        FROM orders
        WHERE orders.cust_id = customers.cust_id) AS orders
FROM customers
ORDER BY cust_name;

#联结：在一条SELECT语句中关联多个表alter
SELECT vend_name, prod_name, prod_price
FROM vendors, products
WHERE vendors.vend_id = products.vend_id;

#输出笛卡尔积的数目
SELECT vend_name, prod_name, prod_price
FROM vendors, products;

#内联结
SELECT vend_name, prod_name, prod_price
FROM vendors INNER JOIN products
ON vendors.vend_id = products.vend_id;

#联结多个表
SELECT prod_name, vend_name, prod_price, quantity
FROM orderitems, products, vendors
WHERE products.vend_id = vendors.vend_id
AND orderitems.prod_id = products.prod_id
AND order_num = 20007;

SELECT CONCAT(vend_name, '(', vend_country, ')') AS vend_title
FROM vendors
ORDER BY vend_name;

#给表起别名
SELECT cust_name, cust_contact
FROM customers AS C, orders AS O, orderitems AS OI
WHERE C.cust_id = O.cust_id
AND OI.order_item = O.order_num
AND prod_id = 'RGAN01';

#外联结：联结包含了那些在相关表中没有关联行的行
SELECT customers.cust_id, orders.order_num
FROM customers LEFT OUTER JOIN orders #LEFT指定其包括所有行的表为左边的表
ON customers.cust_id = orders.cust_id;

SELECT customers.cust_id, orders.order_num
FROM customers RIGHT OUTER JOIN orders 
ON customers.cust_id = orders.cust_id;

SELECT customers.cust_id, COUNT(orders.order_num) AS num_ord
FROM customers INNER JOIN orders
ON customers.cust_id = orders.cust_id
GROUP BY customers.cust_id; 

SELECT customers.cust_id, COUNT(orders.order_num) AS num_ord
FROM customers LEFT OUTER JOIN orders #LEFT指定其包括所有行的表为左边的表
ON customers.cust_id = orders.cust_id
GROUP BY customers.cust_id; #必须分组后再使用COUNT

#组合查询
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_state IN ('IL','IN','MI')
UNION
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_name = 'Fun4All';

SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_state IN ('IL','IN','MI')
OR cust_name = 'Fun4All';

SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_state IN ('IL','IN','MI')
UNION ALL #不取消重复的行
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_name = 'Fun4All';

SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_state IN ('IL','IN','MI')
UNION
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_name = 'Fun4All'
ORDER BY cust_name, cust_contact;




