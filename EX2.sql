--Ý 1:
select p.product_name, sum(o.total_price) as "total_revenue"
from products p join orders o on p.product_id = o.product_id
group by p.product_name, p.product_id
having sum(o.total_price) = (
	select max(total_rev)
	from(
		select sum(o.total_price) as "total_rev"
		from orders o
		group by product_id
	)
);

--Ý 2:
select p.category, sum(o.total_price) as "total_sales"
from products p join orders o on p.product_id = o.product_id
group by p.category;

--Ý 3:
select p.category
from products p join orders o on p.product_id = o.product_id
group by p.product_id, p.category
having sum(o.total_price) = (
	select max(total_rev)
	from (
		select sum(total_price) as "total_rev"
		from orders
		group by product_id
	)
)

intersect

select p.category
from products p join orders o on p.product_id = o.product_id
group by p.category
having sum(o.total_price) > 3000;

