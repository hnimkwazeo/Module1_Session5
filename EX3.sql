create table customers(
	customer_id serial primary key,
	customer_name varchar(100) not null,
	city varchar(100) not null
);

insert into customers(customer_name,city) values
('Nguyễn Văn A','Hà Nội'),
('Trần Thị B','Đà Nẵng'),
('Lê Văn C','Hồ Chí Minh'),
('Phạm Thị D','Hà Nội');

create table orders(
	order_id int primary key,
	customer_id int references customers(customer_id),
	order_date date not null,
	total_price int not null
);

insert into orders(order_id,customer_id,order_date,total_price) values
(101,1,'2024-12-20', 3000),
(102,2,'2025-01-05', 1500),
(103,1,'2025-02-10', 2500),
(104,3,'2025-02-15', 4000),
(105,4,'2025-03-01', 800);

create table products(
	product_id serial primary key,
	product_name varchar(100) not null,
	category varchar(100) not null
);

insert into products(product_name, category) values
('Laptop Dell', 'Electronics'),
('IPhone 15', 'Electronics'),
('Bàn học gỗ', 'Furniture'),
('Ghế xoay', 'Furniture');

create table order_items(
	item_id serial primary key,
	order_id int references orders(order_id),
	product_id int references products(product_id),
	quantity int not null,
	price int not null
);

insert into order_items(order_id,product_id,quantity,price) values
(101,1,2,1500),
(102,2,1,1500),
(103,3,5,500),
(104,2,4,1000),
(105,2,1,800);

--Ý 1:
select o.customer_id, c.customer_name, sum(o.total_price) as "total_revenue", count(o.customer_id) as "order_count"
from orders o join customers c on o.customer_id = c.customer_id
group by o.customer_id, c.customer_name
having sum(o.total_price) > 2000
order by o.customer_id asc;

--Ý 2:
select o.customer_id, c.customer_name, sum(o.total_price) as "total_revenue"
from orders o join customers c on o.customer_id = c.customer_id
group by o.customer_id, c.customer_name
having sum(o.total_price) > (
	select avg(total_price) 
	from orders
)
order by o.customer_id asc;

--Ý 3:
select c.city, sum(o.total_price) as "total_revenue"
from customers c join orders o  on c.customer_id = o.customer_id
group by c.city
having sum(o.total_price) = (
	select max(total_rev)
	from (	
		select sum(o.total_price) as "total_rev" 
		from orders o join customers c on c.customer_id = o.customer_id 
		group by c.city
	)
);

--Ý 4:
select c.customer_name as "Tên khách hàng", c.city as "Tên thành phố", 
sum(oi.quantity) as "Tổng sản phẩm đã mua", sum(o.total_price) as "Tổng chi tiêu"
from order_items oi join orders o on oi.order_id = o.order_id join customers c on c.customer_id = o.customer_id
group by c.customer_id
order by c.customer_id asc;