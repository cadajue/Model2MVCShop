DROP TABLE images;
DROP TABLE transaction;
DROP TABLE discount;

DROP TABLE product CASCADE constraints;
DROP TABLE users CASCADE constraints;
DROP TABLE coupon CASCADE constraints;


DROP SEQUENCE seq_product_prod_no;
DROP SEQUENCE seq_transaction_tran_no;
DROP SEQUENCE seq_image_no;
DROP SEQUENCE seq_coupon_no;
DROP SEQUENCE seq_discount_no;


CREATE SEQUENCE seq_product_prod_no	 	INCREMENT BY 1 START WITH 1000;
CREATE SEQUENCE seq_transaction_tran_no	INCREMENT BY 1 START WITH 2000;
CREATE SEQUENCE seq_image_no			INCREMENT BY 1 START WITH 3000;
CREATE SEQUENCE seq_coupon_no			INCREMENT BY 1 START WITH 4000;
CREATE SEQUENCE seq_discount_no			INCREMENT BY 1 START WITH 5000;


CREATE TABLE users ( 
	user_id 				VARCHAR2(20)		NOT NULL,
	user_name 				VARCHAR2(50)		NOT NULL,
	password 				VARCHAR2(10),
	role 					VARCHAR2(5) 		DEFAULT 'user',
	ssn 					VARCHAR2(13),
	cell_phone				VARCHAR2(14),
	addr 					VARCHAR2(100),
	email 					VARCHAR2(50),
	google_id				VARCHAR2(100),
	reg_date 				DATE,
	PRIMARY KEY(user_id)
);


CREATE TABLE product ( 
	prod_no 				NUMBER 			NOT NULL,
	prod_name 				VARCHAR2(100) 	NOT NULL,
	prod_detail 			VARCHAR2(200),
	manufacture_day			VARCHAR2(8),
	price 					NUMBER(10),
	reg_date 				DATE,
	PRIMARY KEY(prod_no)
);


CREATE TABLE images ( 
	image_no				NUMBER 			NOT NULL,
	prod_no 				NUMBER			NOT NULL REFERENCES product(prod_no),
	image_file 				VARCHAR2(100) 	NOT NULL,
	PRIMARY KEY(image_no)
);




CREATE TABLE transaction ( 
	tran_no 				NUMBER 			NOT NULL,
	prod_no 				NUMBER			NOT NULL REFERENCES product(prod_no),
	buyer_id 				VARCHAR2(20)	NOT NULL REFERENCES users(user_id),
	payment_option			VARCHAR2(3),
	receiver_name 			VARCHAR2(20),
	receiver_phone			VARCHAR2(14),
	dlvy_addr 				VARCHAR2(100),
	dlvy_request 			VARCHAR2(100),
	tran_status_code		VARCHAR2(3),
	order_date 				DATE,
	dlvy_date 				DATE,
	PRIMARY KEY(tran_no)
);


CREATE TABLE coupon(
	coupon_no				NUMBER 			NOT NULL,
	coupon_name				VARCHAR2(100) 	NOT NULL,
	discount_ratio			NUMBER		 	NOT NULL,	
	maximum_discount_price	NUMBER,
	minimum_price			NUMBER,
	PRIMARY KEY(coupon_no)
);


CREATE TABLE discount(
	discount_no				NUMBER 			NOT NULL,
	owner_id				VARCHAR2(20) 	NOT NULL REFERENCES users(user_id),
	coupon_no				NUMBER			NOT NULL REFERENCES coupon(coupon_no),
	product_no				NUMBER			REFERENCES product(prod_no),	
	issued_date				DATE,
	expiration_date			DATE,
	purchase_date			DATE,
	PRIMARY KEY(discount_no)
);



INSERT 
INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, google_id, reg_date ) 
VALUES ( 'admin', 'admin', '1234', 'admin', NULL, NULL, '����� ���ʱ�', 'admin@mvc.com', NULL, to_date('2012/01/14', 'YYYY/MM/DD')); 

INSERT 
INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, google_id, reg_date ) 
VALUES ( 'manager', 'manager', '1234', 'admin', NULL, NULL, NULL, 'manager@mvc.com', NULL, to_date('2012/01/14', 'YYYY/MM/DD'));          

INSERT INTO users 
VALUES ( 'user01', '�հ�', '1111', 'user', NULL, '010-1111-2222', '����� ���ʱ�', 'kadadue@gmail.com', NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user02', 'SCOTT', '2222', 'user', NULL, NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user03', 'SCOTT', '3333', 'user', NULL, NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user04', 'SCOTT', '4444', 'user', NULL, NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user05', 'SCOTT', '5555', 'user', NULL, NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user06', 'SCOTT', '6666', 'user', NULL, NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user07', 'SCOTT', '7777', 'user', NULL, NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user08', 'SCOTT', '8888', 'user', NULL, NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user09', 'SCOTT', '9999', 'user', NULL, NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user10', 'SCOTT', '1010', 'user', NULL, NULL, NULL, NULL, NULL, sysdate); 

       

insert into product values (seq_product_prod_no.nextval,'�Ҵ� A7R3','��ȭ�� �̷�����','20190312',3200000, sysdate);
insert into images values(seq_image_no.nextval,1000,'Q4GH4H580A7R3.jpg');
insert into images values(seq_image_no.nextval,1000,'4sxi6wsu.png');
insert into images values(seq_image_no.nextval,1000,'asdfga235sg.jpg');
insert into images values(seq_image_no.nextval,1000,'dyfd6egt55g4.jpg');

insert into product values (seq_product_prod_no.nextval,'�Ҵ� RM100','����Ʈ �̷�����','20150425',430000, sysdate);
insert into images values(seq_image_no.nextval,1001,'17369039962142.jpg');
insert into images values(seq_image_no.nextval,1001,'wdqwfgqg234.jpg');

insert into product values (seq_product_prod_no.nextval,'���� X-pro3','Ŭ���� �̷�����','20190317',1350000, sysdate);
insert into images values(seq_image_no.nextval,1002,'2016243376werth321106.jpg');

insert into product values (seq_product_prod_no.nextval,'���� 100f','Ŭ���� ����Ʈ ī�޶�','20180228',630000, sysdate);
insert into images values(seq_image_no.nextval,1003,'20181384765947qqw52.jpg');

insert into product values (seq_product_prod_no.nextval,'���� X-T3','Ŭ���� �̷����� ī�޶�','20180520',829000, sysdate);
insert into images values(seq_image_no.nextval,1004,'201825733wrth453311.jpg');

insert into product values (seq_product_prod_no.nextval,'�Ҵ� RM102','����Ʈ �̷�����','20160425',550000, sysdate);
insert into images values(seq_image_no.nextval,1005,'23467fhyg4hh.jpg');

insert into product values (seq_product_prod_no.nextval,'���� X-T2','Ŭ���� �̷����� ī�޶�','20140425',350000, sysdate);
insert into images values(seq_image_no.nextval,1006,'2346902GQ3G34.jpg');

insert into product values (seq_product_prod_no.nextval,'�Ｎī�޶�','��ȸ�� �ʸ� ī�޶�','20120425',350000, sysdate);
insert into images values(seq_image_no.nextval,1007,'234UYWERH467G.jpg');

insert into product values (seq_product_prod_no.nextval,'ĳ�� R5','�������� �̷����� ī�޶�','20180605',350000, sysdate);
insert into images values(seq_image_no.nextval,1008,'33570_63794_817.jpg');

insert into product values (seq_product_prod_no.nextval,'���� D780','�������� DSLR ī�޶�','20200205',350000, sysdate);
insert into images values(seq_image_no.nextval,1009,'82705_53723_2834.jpg');

insert into product values (seq_product_prod_no.nextval,'�ø�Ǫ�� el10','����Ʈ �̷����� ī�޶�','20191225',350000, sysdate);
insert into images values(seq_image_no.nextval,1010,'997B20355C15B67E10.png');

insert into product values (seq_product_prod_no.nextval,'�Ｚ NX200','����Ʈ �̷����� ī�޶�','20160125',150000, sysdate);
insert into images values(seq_image_no.nextval,1011,'asdfah34h348i.jpg');

insert into product values (seq_product_prod_no.nextval,'����ī ������̵�','����Ʈ �̷����� ī�޶�','20140125',1850000, sysdate);
insert into images values(seq_image_no.nextval,1012,'fqg3g.jpg');

insert into product values (seq_product_prod_no.nextval,'����ī�޶�','����Ʈ ī�޶�','20140425',50000, sysdate);
insert into images values(seq_image_no.nextval,1013,'G6T34HY.jpg');

insert into product values (seq_product_prod_no.nextval,'ĳ�� 5Ds','�������� DSLR ī�޶�','20140425',9580000, sysdate);
insert into images values(seq_image_no.nextval,1014,'gasgqh.jpg');

insert into product values (seq_product_prod_no.nextval,'���� X100 pro','����Ʈ �̷����� ī�޶�','20140425',50000, sysdate);
insert into images values(seq_image_no.nextval,1015,'gqrghsgqerg.jpg');

insert into product values (seq_product_prod_no.nextval,'�ø�Ǫ�� ��F','����Ʈ �̷����� ī�޶�','20170425',590000, sysdate);
insert into images values(seq_image_no.nextval,1016,'gwergh.jpg');

insert into product values (seq_product_prod_no.nextval,'���� ī�޶�','��ȸ�� ī�޶�','20150425',90000, sysdate);
insert into images values(seq_image_no.nextval,1017,'qweh3hA87943.jpg');

insert into product values (seq_product_prod_no.nextval,'�ø�Ǫ�� EM5','�������� �̷����� ī�޶�','20190425',1290000, sysdate);
insert into images values(seq_image_no.nextval,1018,'qwergwg453.jpg');

insert into product values (seq_product_prod_no.nextval,'����ī C-Lux','����Ʈ ī�޶�','20170521',4570000, sysdate);
insert into images values(seq_image_no.nextval,1019,'unfjkhjk8768.jpg');

insert into product values (seq_product_prod_no.nextval,'ĳ�� 200D','DSLR ī�޶�','20150521',5570000, sysdate);
insert into images values(seq_image_no.nextval,1020,'u7n46naas5me6d.jpg');

insert into product values (seq_product_prod_no.nextval,'����ī D-Lux ','����Ʈ ī�޶�','20140521',550000, sysdate);
insert into images values(seq_image_no.nextval,1021,'unnaasdfmedfjhfh6.jpg');

insert into product values (seq_product_prod_no.nextval,'�Ҵ� A5100','����Ʈ ī�޶�','20130521',892000, sysdate);
insert into images values(seq_image_no.nextval,1022,'asfeginneasdfasgasfd03.jpg');

insert into product values (seq_product_prod_no.nextval,'ĳ�� 200D ȭ��Ʈ','DSLR ī�޶�','20180521',132000, sysdate);
insert into images values(seq_image_no.nextval,1023,'asdfasdfefff2345ffa.jpg');

insert into product values (seq_product_prod_no.nextval,'���� GR','����Ʈ ī�޶�','20170521',9900, sysdate);
insert into images values(seq_image_no.nextval,1024,'ferh476hf335g3.jpg');

insert into product values (seq_product_prod_no.nextval,'����� ����','����Ʈ ī�޶�','20180521',19900, sysdate);
insert into images values(seq_image_no.nextval,1025,'sdf572g46j2gj7oqht.jpg');

insert into product values (seq_product_prod_no.nextval,'�ø�Ǫ�� EM1','�������� �̷����� ī�޶�','20200325',259900, sysdate);
insert into images values(seq_image_no.nextval,1026,'1fhqw23qwe4qwqw.jpg');
insert into images values(seq_image_no.nextval,1026,'34793w12e5315221980.jpg');
insert into images values(seq_image_no.nextval,1026,'qwevt20qwru000_4.jpg');

insert into product values (seq_product_prod_no.nextval,'���� X-T4','�������� �̷����� ī�޶�','20200517',859500, sysdate);
insert into images values(seq_image_no.nextval,1027,'gho45t58095jh69g.jpg');
insert into images values(seq_image_no.nextval,1027,'q5we408gh74qrg4.PNG');
insert into images values(seq_image_no.nextval,1027,'ret42uer.PNG');
insert into images values(seq_image_no.nextval,1027,'12g75nogwg3.jpg');
insert into images values(seq_image_no.nextval,1027,'234y42uqwt.PNG');

insert into product values (seq_product_prod_no.nextval,'������ �����8','����Ʈ ī�޶�','20190711',39900, sysdate);
insert into images values(seq_image_no.nextval,1028,'fsh5372836.jpg');

insert into product values (seq_product_prod_no.nextval,'������ �����4','����Ʈ ī�޶�','20140711',19900, sysdate);
insert into images values(seq_image_no.nextval,1029,'ASDF234523F23.jpg');

insert into product values (seq_product_prod_no.nextval,'�Ҵ� FDR-X3000','����Ʈ ī�޶�','20170711',22900, sysdate);
insert into images values(seq_image_no.nextval,1030,'62324uqt43w8e.jpg');

insert into coupon values (seq_coupon_no.nextval,'�ű� ������ ����', 10, 10000,100000);
insert into coupon values (seq_coupon_no.nextval,'�̴��� VIP ����', 40, 200000, 500000);
insert into coupon values (seq_coupon_no.nextval,'�̴��� �̺�Ʈ ����', 30, 15000, 10000);
insert into coupon values (seq_coupon_no.nextval,'������ �̺�Ʈ ����', 10, 5000, 10000);

commit;
