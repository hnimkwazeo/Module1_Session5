create table customers (
	customer_id serial primary key,
	customer_name varchar(100),
	city varchar(50)
);

insert into customers (customer_name, city) values
('Nguyễn Văn An', 'Hà Nội'),
('Trần Thị Bình', 'Hải Phòng'),
('Lê Minh Cường', 'Đà Nẵng'),
('Phạm Thu Dung', 'TP Hồ Chí Minh'),
('Hoàng Văn Đức', 'Cần Thơ'),
('Nguyễn Thị Hạnh', 'Huế'),
('Trần Quốc Khánh', 'Hải Phòng'),
('Lê Thị Lan', 'Hà Nội'),
('Phạm Văn Minh', 'Đà Nẵng'),
('Hoàng Thị Ngọc', 'TP Hồ Chí Minh'),
('Bùi Văn Nam', 'Nha Trang'),       
('Đặng Thị Oanh', 'Vinh');        

create table orders (
	order_id serial primary key,
	customer_id int references customers(customer_id),
	order_date date,
	total_amount numeric(10,2)
);

insert into orders (customer_id, order_date, total_amount) values
(1, '2024-02-01', 5000.00),
(1, '2024-02-10', 3200.00),
(2, '2024-02-05', 1500.00),
(3, '2024-02-07', 2200.00),
(4, '2024-02-08', 8000.00),
(4, '2024-02-15', 4500.00),
(5, '2024-02-12', 900.00),
(6, '2024-02-14', 1200.00),
(7, '2024-02-18', 3000.00),
(8, '2024-02-20', 2700.00),
(9, '2024-02-22', 3500.00),
(10, '2024-02-25', 6000.00);

create table order_items (
	item_id serial primary key,
	order_id int references orders(order_id),
	product_name varchar(100),
	quantity int,
	price numeric(10,2)
);

insert into order_items (order_id, product_name, quantity, price) values
(1, 'Laptop Dell XPS', 1, 4000.00),
(1, 'Chuột Logitech', 2, 500.00),
(2, 'Bàn phím cơ', 2, 1600.00),
(3, 'Tai nghe Sony', 3, 500.00),
(4, 'Màn hình LG', 2, 1100.00),
(5, 'iPhone 13', 1, 8000.00),
(5, 'Ốp lưng', 2, 250.00),
(6, 'MacBook Air', 1, 4500.00),
(7, 'USB 64GB', 10, 90.00),
(8, 'Loa Bluetooth', 2, 600.00),
(9, 'Máy in Canon', 1, 3000.00),
(10, 'Tablet Samsung', 1, 2700.00),
(11, 'Điện thoại Xiaomi', 1, 3500.00),
(12, 'TV Samsung 4K', 1, 6000.00);

--Ý 1: ALIAS
select c.customer_name as "Tên khách", o.order_date as "Ngày đặt hàng", o.total_amount as "Tổng tiền"
from orders o
join customers c on o.customer_id = c.customer_id;

--Ý 2: Aggregate Functions
select sum(total_amount) as "Tổng doanh thu", avg(total_amount) as "Trung bình giá trị đơn hàng", max(total_amount) as "Đơn hàng lớn nhất", 
min(total_amount) as "Đơn hàng nhỏ nhất", count(order_id) as "Số lượng đơn hàng"
from orders;

--Ý 3: GROUP BY / HAVING
select c.city as "Thành phố", sum(o.total_amount) as "Tổng doanh thu"
from orders o
join customers c on o.customer_id = c.customer_id
group by c.city
having sum(o.total_amount) > 10000;

--Ý 4: JOIN
select c.customer_name as "Tên khách hàng", oi.product_name as "Sản phẩm đã bán",
o.order_date as "Ngày đặt hàng", oi.quantity as "Số lượng", oi.price as "Giá", oi.price * oi.quantity as "Thành tiền"
from order_items
join orders o oi on oi.order_id = o.order_id
join customers c on o.customer_id = c.customer_id;

--Ý 5: Subquery
select c.customer_name as "Tên khách hàng", sum(o.total_amount) as "Tổng doanh thu"
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_name
having sum(o.total_amount) = (
	select max(total_rev)
	from (
		select sum(total_amount) as "total_rev"
		from orders
		group by customer_id
	)
);


--Ý 6: UNION và INTERSECT
select city
from customers
union
select distinct c.city
from orders o
join customers c on o.customer_id = c.customer_id;

select city
from customers
intersect
select c.city
from customers c
join orders o on c.customer_id = o.customer_id;
