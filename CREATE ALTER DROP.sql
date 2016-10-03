CREATE TABLE newproducts
(
	prod_id		CHAR(10)		NOT NULL, #1~255个字符的定长字符串，缺少的字符用空格填充
    vend_id		CHAR(10)		NOT NULL, #处理CHAR比处理VARCHAR快得多
    prod_name	CHAR(254)		NOT NULL,
    prod_price 	DECIMAL(8,2)	NOT NULL, #定点或精度可变的浮点值，-999999.99~9999999.99，小数点后两位，最多9个数字
    prod_desc	VARCHAR(1000)	NULL      #变长文本
);

SHOW TABLES;

INSERT INTO newproducts(prod_id,
                        vend_id,
                        prod_name,
                        prod_price)
VALUES('1',
       '1',
       '1',
       '-999999.99'
);

SELECT *
FROM newproducts;

CREATE TABLE neworders
(
	order_num	INTEGER		NOT NULL, #4字节整数值
    order_date	DATETIME	NOT NULL, #日期时间值
    cust_id		CHAR(10)	NOT NULL
);

SELECT *
FROM vendors;

ALTER TABLE vendors
ADD vend_phone CHAR(20); #添加一列

ALTER TABLE vendors
DROP COLUMN vend_phone; #删除一列

DROP TABLE custcopy;

SHOW TABLES;
