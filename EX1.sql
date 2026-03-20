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

create table orders(
	order_id serial primary key,
	product_id int references products(product_id),
	quantity int not null,
	total_price int not null
);

insert into orders(product_id, quantity, total_price) values
(1,2,2200),
(2,3,3300),
(3,5,2500),
(4,4,1600),
(1,1,1100);

select sum(o.total_price) as "total_sales", sum(o.quantity) as "total_quantity", p.category as "category"
from products p join orders o on p.product_id = o.product_id
group by p.category
having sum(o.total_price) > 2000
order by sum(o.total_price) desc;

