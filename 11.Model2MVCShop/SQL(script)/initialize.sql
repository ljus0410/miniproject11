
DROP TABLE transaction;
DROP TABLE basket;
DROP TABLE product;
DROP TABLE users;

DROP SEQUENCE seq_product_prod_no;
DROP SEQUENCE seq_transaction_tran_no;


CREATE SEQUENCE seq_product_prod_no		 	INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_transaction_tran_no		INCREMENT BY 1 START WITH 10000;


CREATE TABLE users ( 
	user_id 				VARCHAR2(20)	NOT NULL,
	user_name 				VARCHAR2(50)	NOT NULL,
	password 				VARCHAR2(10)	NOT NULL,
	role 					VARCHAR2(5) 	DEFAULT 'user',
	ssn 					VARCHAR2(13),
	cell_phone 				VARCHAR2(14),
	addr_postcode 			VARCHAR2(100),
	addr_road 				VARCHAR2(100),
	addr_extra	 			VARCHAR2(100),
	email 					VARCHAR2(50),
	reg_date 				DATE,
	PRIMARY KEY(user_id)
);


CREATE TABLE product ( 
	prod_no 				NUMBER 			NOT NULL,
	prod_name 				VARCHAR2(100) 	NOT NULL,
	prod_detail 			VARCHAR2(200),
	manufacture_day			VARCHAR2(10),
	price 					NUMBER(10),
	image_file 				VARCHAR2(100),
	reg_date 				DATE,
	prod_count				NUMBER(10),
	PRIMARY KEY(prod_no)
);

CREATE TABLE transaction ( 
	tran_no 				NUMBER 			NOT NULL,
	prod_no 				NUMBER(16)		NOT NULL REFERENCES product(prod_no),
	buyer_id 				VARCHAR2(20)	NOT NULL REFERENCES users(user_id),
	payment_option			CHAR(3),
	receiver_name 			VARCHAR2(20),
	receiver_phone			VARCHAR2(14),
	divy_addr 				VARCHAR2(100),
	divy_request 			VARCHAR2(100),
	tran_status_code		CHAR(3),
	order_date 				DATE,
	divy_date 				DATE,
	PRIMARY KEY(tran_no)
);


INSERT 
INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr_postcode, addr_road, addr_extra, email, reg_date ) 
VALUES ( 'admin', 'admin', '1234', 'admin', NULL, NULL, '06134', '서울특별시 강남구 강남대로94길 20', '삼오빌딩 5-9층', 'admin@mvc.com', to_date('2012/01/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS')); 

INSERT 
INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr_postcode, addr_road, addr_extra, email, reg_date ) 
VALUES ( 'manager', 'manager', '1234', 'admin', NULL, NULL, '06134', '서울특별시 강남구 강남대로94길 20', '삼오빌딩 5-9층', 'manager@mvc.com', to_date('2012/01/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS'));          

INSERT INTO users 
VALUES ( 'user01', 'SCOTT', '1111', 'user', NULL, NULL, NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user02', 'SCOTT', '2222', 'user', NULL, NULL, NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user03', 'SCOTT', '3333', 'user', NULL, NULL, NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user04', 'SCOTT', '4444', 'user', NULL, NULL, NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user05', 'SCOTT', '5555', 'user', NULL, NULL, NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user06', 'SCOTT', '6666', 'user', NULL, NULL, NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user07', 'SCOTT', '7777', 'user', NULL, NULL, NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user08', 'SCOTT', '8888', 'user', NULL, NULL, NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user09', 'SCOTT', '9999', 'user', NULL, NULL, NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user10', 'SCOTT', '1010', 'user', NULL, NULL, NULL, NULL, NULL, NULL, sysdate); 

COMMIT;

CREATE SEQUENCE seq_basket_basket_no	INCREMENT BY 1 START WITH 10000;

CREATE TABLE basket (
	basket_no	NUMBER		NOT NULL,
	prod_no		NUMBER(16)	NOT NULL	REFERENCES product(prod_no),
	user_id		VARCHAR2(100)	NOT NULL	REFERENCES users(user_id),
	PRIMARY KEY(basket_no)
);

commit;
