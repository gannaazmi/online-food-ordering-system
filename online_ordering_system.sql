create database online_store_system;
use online_store_system;

create table customer(
    customerID int primary key auto_increment,
    name varchar(50),
    email varchar(50),
    phoneNum varchar(20),
    address varchar(100)
);

create table category(
    categoryID int primary key auto_increment,
    name varchar(50)
);

create table product(
    productID int primary key auto_increment,
    name varchar(50),
    price int,
    availableQuantity int,
    categoryID int,
    foreign key(categoryID) references category(categoryID)
);

create table orders(
    orderID int primary key auto_increment,
    orderDate datetime,
    totalAmount int,
    customerID int,
    foreign key(customerID) references customer(customerID)
);

create table order_item(
    orderID int,
    productID int,
    primary key(orderID, productID),
    foreign key(orderID) references orders(orderID),
    foreign key(productID) references product(productID)
);