create database online_food_ordering_system;
create table CUSTOMER(
customerID int primary key auto_increment,
name varchar(20) not null ,
phoneNumber int not null unique,
address varchar(20) not null 
);

INSERT INTO CUSTOMER (name, phoneNumber, address) VALUES
('Ali Ahmed', 1012345678, 'Cairo'),
('Sara Mohamed', 1023456789, 'Alexandria'),
('Omar Khaled', 1034567890, 'Giza');

INSERT INTO CUSTOMER (name, phoneNumber, address) VALUES
 ('jana ali', 1039905890, 'Giza');
 
 select address ,count(customerID) as 'no. of customers'
 from customer
 group by address;

select count(customerID) from customer;

select distinct address from CUSTOMER ;


ALTER TABLE DELIVERY_PERSON
MODIFY phoneNumber VARCHAR(15) NOT NULL UNIQUE;


create table RESTAURANT(
restID int primary key auto_increment,
name varchar(20)
);

INSERT INTO RESTAURANT (name) VALUES
('Pizza Palace'),
('Burger House'),
('Koshary El Tahrir');

select * FROM RESTAURANT;


create table MENU_ITEM(
itemID int primary key auto_increment,
name varchar(20) not null,
price decimal(10,2) check (price>=0),
restID int,
foreign key (restID) references RESTAURANT(restID)
);
ALTER TABLE restaurant
rename column name to restName;

INSERT INTO MENU_ITEM (name, price, restID) VALUES
('Margherita Pizza', 80.00, 1),
('Pepperoni Pizza', 95.00, 1),
('Beef Burger', 70.00, 2),
('Chicken Burger', 65.00, 2),
('Koshary Large', 50.00, 3);

SELECT * FROM MENU_ITEM
limit 3;

select restName , name 
from restaurant inner join menu_item
on restaurant.restID=menu_item.restID;

create table ORDERS(
orderID int primary key auto_increment,
orderDate datetime not null,

totalAmount decimal(10,2) check (totalAmount>=0),
customerID int,
foreign key (customerID) references CUSTOMER(customerID)
);

INSERT INTO ORDERS (orderDate, totalAmount, customerID) VALUES
('2026-04-10 12:30:00', 150.00, 1),
('2026-04-11 15:00:00', 70.00, 2),
('2026-04-12 18:45:00', 50.00, 3);

select * FROM ORDERS order by orderDate;

select O.orderDate,P.totalAmount
from orders O left join payment P   
on O.orderID=P.orderID
union
select O.orderDate,P.totalAmount
from orders O right join payment P   
on O.orderID=P.orderID;

create table ORDERS_ITEM(
itemID int,
orderID int,
quantity int,
foreign key (itemID) references MENU_ITEM (itemID),
foreign key (orderID) references ORDERS(orderID)
);

INSERT INTO ORDERS_ITEM (itemID, orderID, quantity) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 2, 1),
(5, 3, 1);

create table CART(
cartID int primary key auto_increment,
customerID int,
foreign key (customerID) references CUSTOMER(customerID)
);

INSERT INTO CART (customerID) VALUES
(1),
(2);

create table CART_ITEM(
cartID int,
itemID int,
quantity int,
foreign key (cartID) references CART(cartID),
foreign key (itemID) references MENU_ITEM(itemID)
);

INSERT INTO CART_ITEM (cartID, itemID, quantity) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 5, 1);

select sum(quantity) as total_quantity 
from cart_item;


create table PAYMENT(
paymentID int primary key auto_increment,
orderID int,
totalAmount decimal(10,2) check (totalAmount>=0),
foreign key (orderID) references ORDERS(orderID)
);

INSERT INTO PAYMENT (orderID, totalAmount) VALUES
(1, 150.00),
(2, 70.00),
(3, 50.00);

select avg(totalAmount) as avg_price
from payment;


select * from PAYMENT
where totalAmount>100;

create table DELIVERY_PERSON(
deliveryID int primary key auto_increment,
name varchar(20),
phoneNumber int unique

);

INSERT INTO DELIVERY_PERSON (name, phoneNumber) VALUES
('Mahmoud Ali', 1098765432),
('Hassan Adel', 1087654321);

alter table delivery_person
rename column name to delName;

select delName,orderID
from delivery_person D left join orders O 
on D.deliveryID =O.orderID;

create table DELIVERY(
deliveryID int,
orderID int,
status ENUM('pending','delivered'),
foreign key (deliveryID) references DELIVERY_PERSON(deliveryID),
foreign key(orderID) references ORDERS(orderID)
);

INSERT INTO DELIVERY (deliveryID, orderID, status) VALUES
(1, 1, 'delivered'),
(2, 2, 'pending'),
(1, 3, 'delivered');







